local ok_nordic, nordic = pcall(require, 'nordic')

if not ok_nordic then
    return
end

nordic.setup({
    telescope = {
        style = 'classic',
    },
    noice = {
        style = 'flat',
    },
    on_highlight = function(highlights, p)
        highlights.FloatBorder = {
            bg = p.gray0,
            fg = p.white0
        }

        highlights.NoiceCmdlineIcon = {
            bg = p.gray0,
        }

        highlights.NoiceCmdlineIconSearch = {
            bg = p.gray0,
        }

        highlights.NoiceCmdlinePopup = {
            bg = p.gray0
        }

        highlights.NormalFloat = {
            bg = p.gray0,
            fg = p.white0,
        }
        highlights.NoicePopupBorder = {
            bg = p.gray0,
            fg = p.white0,
        }

        highlights.PMenuThumb = {
            bg = p.orange.base,
        }

        highlights.MatchParen = {
            bg = p.orange.bright
        }
        highlights.Visual = {
            bg = p.gray2
        }
    end,
    reduced_blue = true,
})

vim.cmd [[colorscheme nordic]]

-- vim.opt.termguicolors = true
