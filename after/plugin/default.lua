vim.opt.relativenumber = true

-- Move and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})

-- Nvim Tree
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', {})
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', {})

-- Format
vim.keymap.set('n', '<leader>f', ':Format<CR>', {})

-- Git diff view
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', {})

require('lualine').setup({
  options = {
    theme = 'catppuccin'
  }
})
vim.cmd [[colorscheme catppuccin-frappe]]

vim.opt.termguicolors = true
require("bufferline").setup({})

-- Buffer 
vim.keymap.set('n', '<TAB>', ':bnext<CR>', {})
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', {})
vim.keymap.set('n', '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', {})

-- Tab managment
vim.keymap.set('n', '<leader>tc', ':tabc<CR>', {})
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', {})
