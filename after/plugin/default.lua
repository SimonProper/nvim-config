-- @param plugin string
--- @param callback fun(pluginRef : unknown )
local prequire = function(plugin, callback)
  local status, pluginRef = pcall(require, plugin)
  if not status then
    return
  end
  callback(pluginRef)
end

vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'

------------------------
-- Tab and Whitespace --
------------------------
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.cmd([[set nowrap]])

-----------------
-- Keybindings --
-----------------

-- Move and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})

-- Nvim Tree
vim.keymap.set('n', '<leader>ee', ':NvimTreeFocus<CR>', {silent= true})
vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', {silent= true})

-- Format
vim.keymap.set('n', '<leader>f', ':Format<CR>', {silent= true})

-- Git diff view
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', {silent= true})


-- Buffer
vim.keymap.set('n', '<TAB>', ':bnext<CR>', {silent= true})
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', {silent= true})
vim.keymap.set('n', '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', {silent= true})

vim.keymap.set('n', '<leader>ss', ':w<CR>', {silent= true})

-- Tab managment
vim.keymap.set('n', '<leader>td', ':tabc<CR>', {silent= true})
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', {silent= true})

-- lsp
vim.keymap.set({ 'v', 'n' }, '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', {silent= true})

vim.keymap.set("n", 'gf', ':LspDiagLine<CR>', {silent= true})

------------------
-- Plugin setup --
------------------

-- Theme
prequire('lualine', function(lualine)
  lualine.setup({
    options = {
      theme = 'sonokai'
    },
    sections = {
      lualine_c = {
        {
          'filename',
          -- Relative path, to include the parent directory
          path = 1,
          -- Shortens path to leave X spaces in the window
          -- for other components.
          shortening_target = 40,
        }
      }
    }
  })
end)


-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_better_performance = 1
-- vim.cmd [[colorscheme sonokai]]

prequire('nordic', function(nordic)
  nordic.setup({
    telescope = {
      style = 'flat',
    }
  }
  )

end)

vim.cmd [[colorscheme nordic]]

vim.opt.termguicolors = true

-- Nvim Tree
prequire('nvim-tree', function(nvim_tree)
  nvim_tree.setup({
    hijack_cursor = true,
    view = {
      mappings = {
        list = {
          { key = "h", action = "close_node" },
          { key = "l", action = "edit" },
        },
      },
    },
  })
end)


-- Bufferline
prequire('bufferline', function(bufferline)
  bufferline.setup({
    options = {
      -- adds the prefix path when multiple buffers with the same name are open
      view = 'multieview',
      -- offsets the bufferline from NvimTree sidebar
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true -- use a "true" to enable the default, or set your own character
        }
      },
      separator_style = 'slant',
      diagnostics = "nvim_lsp",
    }
  })
end
)

-- Context based comments for tsx and other files
prequire('nvim-treesitter.configs', function(configs)
  configs.setup({
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    -- nvim-ts-autotag
    autotag = { enable = true }
  })
end
)

prequire('null-ls', function(null_ls)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.rustywind
      -- null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.formatting.lua_format,
    },
    debug = true,
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(client)
                return client.name == "null-ls"
              end
            })
            -- vim.lsp.buf.formatting_sync()
          end,
        })
      end
    end
  })
end)

-- add the context to the comment plugin
prequire('Comment', function(Comment)
  Comment.setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  })
end
)

-- Telescope ignore node_modules
prequire('telescope', function(telescope)
  telescope.setup({
    picker = {
      hidden = false,
      layout_config = {
        scroll_speed = 1,
      },
    },
    defaults = {
      file_ignore_patterns = { "node_modules" },
      prompt_prefix = '   ',
      selection_caret = '❯ ',
      entry_prefix = '  ',
      sorting_strategy = 'ascending',
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--ignore',
        '--hidden',
        '-g',
        '!.git',
      },
      mappings = {
        i = {
          -- ['<ESC>'] = require('telescope.actions').close,
          ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
          ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
        },
      },
      initial_mode = 'insert',
      selection_strategy = 'reset',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
        scroll_speed = 1,
      },
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { 'truncate' },
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    }
  })
end)


-- Autopairs
prequire("nvim-autopairs", function(autopairs)
  autopairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
      lua = { "string" }, -- don't add pairs in lua string treesitter nodes
      javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
      java = false, -- don't check treesitter on java
    },
  })
end)

-- Noice
prequire('noice', function(noice)
  noice.setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      -- bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    cmdline = {
      -- view = 'cmdline',
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = false, -- enables the Noice messages UI
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    notify = {
      enabled = false,
    },

  })

  -- Dressing
  prequire('dressing', function(dressing)
    dressing.setup({
      nput = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,

        -- Default prompt string
        default_prompt = 'Input:',

        -- Can be 'left', 'right', or 'center'
        prompt_align = 'left',

        -- When true, <Esc> will close the modal
        insert_only = true,

        -- These are passed to nvim_open_win
        anchor = 'SW',
        border = 'rounded',
        -- 'editor' and 'win' will default to being centered
        relative = 'cursor',

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        win_options = {
          -- Window transparency (0-100)
          winblend = 10,
          -- Change default highlight groups (see :help winhl)
          winhighlight = '',
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        -- Options for fzf selector
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- Options for fzf_lua selector
        fzf_lua = {
          winopts = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- Options for nui Menu
        nui = {
          position = '50%',
          size = nil,
          relative = 'editor',
          border = {
            style = 'rounded',
            width = 0.2
          },
          buf_options = {
            swapfile = false,
            filetype = 'DressingSelect',
          },
          win_options = {
            winblend = 10,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },

        -- Options for built-in selector
        builtin = {
          -- These are passed to nvim_open_win
          anchor = 'NW',
          border = 'rounded',
          -- 'editor' and 'win' will default to being centered
          relative = 'editor',

          win_options = {
            -- Window transparency (0-100)
            winblend = 10,
            -- Change default highlight groups (see :help winhl)
            winhighlight = '',
          },
          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- the min_ and max_ options can be a list of mixed types.
          -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
      },
    })
  end)
end)

-- cmp tailwind laggy fix
prequire('nvim-cmp', function (nvim_cmp)
  nvim_cmp.setup({
    sources ={
      { name = 'nvim_lsp', keyword_length = 6, group_index = 1, max_item_count = 30 }
    }
  })
  
end)
