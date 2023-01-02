vim.opt.relativenumber = true

vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})

vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', {})
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>f', ':Format<CR>', {})
