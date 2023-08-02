local ok_nordic, nordic = pcall(require, 'nordic')

if not ok_nordic then
    return
end

local ok_nordic_palette, p = pcall(require, 'nordic.colors')

if not ok_nordic_palette then
    return
end

nordic.setup({
    telescope = {
        style = 'classic',
    },
    noice = {
        style = 'flat',
    },
    override = {
        FloatBorder = {
            bg = p.gray0,
            fg = p.white0
        },
        NoiceCmdlineIcon = {
            bg = p.gray0,
        },
        NoiceCmdlineIconSearch = {
            bg = p.gray0,
        },
        NoiceCmdlinePopup = {
            bg = p.gray0
        },
        NormalFloat = {
            bg = p.gray0,
            fg = p.white0,
        },
        NoicePopupBorder = {
            bg = p.gray0,
            fg = p.white0,
        },
        PMenuThumb = {
            bg = p.orange.base,
        },
        MatchParen = {
            bg = p.orange.bright
        },
        Visual = {
            bg = p.gray2
        },
    },
    reduced_blue = true,
})

vim.cmd [[colorscheme nordic]]

-- vim.opt.termguicolors = true
