local ok_nordic, nordic = pcall(require, 'nordic')

if not ok_nordic then
    return
end

local ok_nordic_palette, nordic_palette = pcall(require, 'nordic.colors')

if not ok_nordic_palette then
    return
end

nordic.setup({
    telescope = {
        -- style = 'flat'
    },
    noice = {
        style = 'classic',
    },
    override = {
        NormalFloat = {
            -- bg = '#191C24',
        },
        -- PMenuThumb = {
        --     bg = nordic_palette.orange.base,
        -- },
    },
})

vim.cmd [[colorscheme nordic]]

vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, 'PMenuThumb', { bg = nordic_palette.orange.base })
