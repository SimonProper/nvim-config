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
require('lualine').setup({
  options = {
    theme = 'catppuccin'
  }
})
vim.cmd [[colorscheme catppuccin-frappe]]

vim.opt.termguicolors = true

-- Bufferline
require("bufferline").setup({})

-- Context based comments for tsx and other files
require 'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
-- add the context to the comment plugin
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
