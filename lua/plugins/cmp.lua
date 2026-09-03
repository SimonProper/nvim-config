return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = (function()
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    config = function()
      require('luasnip').config.setup {}
    end,
  },
  {
    'saghen/blink.cmp',
    version = 'v1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      {
        'saghen/blink.compat',
        version = '2.*',
        lazy = false,
        main = 'blink.compat',
        opts = {},
      },
      'rafamadriz/friendly-snippets',
    },
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = 'luasnip' },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          -- Disabled: no context awareness for callback positions,
          -- e.g. onClick={handleClick} becomes onClick={handleClick()}
          auto_brackets = {
            enabled = false,
          },
        },
        menu = {
          border = 'rounded',
          winhighlight = 'Normal:NoiceCmdlinePopup,FloatBorder:NoiceCmdlinePopupBorder,CursorLine:NoicePopupmenuSelected,Search:None',
          draw = {
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = 'cmdline',
          ['<Right>'] = false,
          ['<Left>'] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ':'
            end,
          },
          ghost_text = { enabled = true },
        },
      },
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
          lsp = {
            max_items = 200,
            opts = {
              tailwind_color_icon = '',
            },
            -- Deprioritize Node.js built-in completions so framework-specific
            -- exports (e.g. svelte/events) rank higher in autocomplete
            transform_items = function(_, items)
              local find = string.find
              for i = 1, #items do
                local item = items[i]
                local ld = item.labelDetails
                if ld then
                  local desc = ld.description
                  if desc and find(desc, 'node:', 1, true) then
                    item.score_offset = (item.score_offset or 0) - 5
                  end
                end
              end
              return items
            end,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    config = function(_, opts)
      local ok, tailwind_hack = pcall(require, 'blink.cmp.sources.lsp.hacks.tailwind')
      if ok and not tailwind_hack._patched_for_performance then
        local orig = tailwind_hack.process_response
        tailwind_hack.process_response = function(response, icon)
          if not icon or icon == '' then return response end
          return orig(response, icon)
        end
        tailwind_hack._patched_for_performance = true
      end
      require('blink.cmp').setup(opts)
    end,
  },
}
