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
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
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
            min_width = 60,
            max_height = 12,
            border = 'rounded',
            winhighlight = table.concat({
              'Normal:NoiceCmdlinePopup',
              'FloatBorder:NoiceCmdlinePopupBorder',
              'CursorLine:NoicePopupmenuSelected',
              'Search:None',
            }, ','),
            scrollbar = false,
            direction_priority = function()
              local pos = vim.g.ui_cmdline_pos
              if pos and pos[1] then
                local middle = math.floor(vim.o.lines / 2)
                if pos[1] <= middle then
                  return { 's', 'n' }
                end
                return { 'n', 's' }
              end
              return { 's', 'n' }
            end,
            cmdline_position = function()
              local pos = vim.g.ui_cmdline_pos
              if pos and pos[1] then
                return { pos[1] - 1, pos[2] }
              end
              local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
              return { vim.o.lines - height, 0 }
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
