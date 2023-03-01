local ok, nordic = pcall(require, 'nordic')

if not ok then
    return
end

nordic.setup({
    telescope = {
        style = 'flat'
    },
    noice = {
      style = 'classic',
    },
    override = {
      NormalFloat = {
        -- bg = '#191C24',
      },
    },
})

vim.cmd [[colorscheme nordic]]

vim.opt.termguicolors = true
