--- @param plugin string
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
vim.keymap.set('n', '<leader>ee', ':NvimTreeFocus<CR>', {})
vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', {})

-- Format
vim.keymap.set('n', '<leader>f', ':Format<CR>', {})

-- Git diff view
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', {})


-- Buffer
vim.keymap.set('n', '<TAB>', ':bnext<CR>', {})
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', {})
vim.keymap.set('n', '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', {})

-- Tab managment
vim.keymap.set('n', '<leader>td', ':tabc<CR>', {})
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', {})

-- lsp
vim.keymap.set({ 'v', 'n' }, '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', {})

vim.keymap.set("n", 'gf', ':LspDiagLine<CR>')

------------------
-- Plugin setup --
------------------

-- Theme
prequire('lualine', function(lualine)
  lualine.setup({
    options = {
      theme = 'catppuccin'
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

vim.cmd [[colorscheme catppuccin-frappe]]

vim.opt.termguicolors = true

-- Nvim Tree
prequire('nvim-tree', function (nvim_tree)
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
    defaults = { file_ignore_patterns = { "node_modules" } }
  })
end)


-- Autopairs
prequire("nvim-autopairs", function (autopairs)
  autopairs.setup({
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { "string" }, -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
  })
end)


