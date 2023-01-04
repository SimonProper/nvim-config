vim.opt.relativenumber = true

vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})

vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', {})
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>f', ':Format<CR>', {})
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', {})

require('lualine').setup({
  options = {
    theme = 'catppuccin'
  }
})
vim.cmd [[colorscheme catppuccin-frappe]]

vim.opt.termguicolors = true
require("bufferline").setup({})

vim.keymap.set('n', '<TAB>', ':bnext<CR>', {})
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', {})
vim.keymap.set('n', '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', {})
