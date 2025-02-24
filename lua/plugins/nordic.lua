return {
  'AlexvZyl/nordic.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    telescope = {
      style = 'classic',
    },
    noice = {
      style = 'flat',
    },
    on_highlight = function(highlights, p)
      highlights.FloatBorder = {
        bg = p.gray0,
        fg = p.white0,
      }

      highlights.NoiceCmdlineIcon = {
        bg = p.gray0,
      }

      highlights.NoiceCmdlineIconSearch = {
        bg = p.gray0,
      }

      highlights.NoiceCmdlinePopup = {
        bg = p.gray0,
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
        bg = p.orange.bright,
      }
      highlights.Visual = {
        bg = p.gray2,
      }
    end,
    reduced_blue = true,
  },
  init = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'nordic'
  end,
}
