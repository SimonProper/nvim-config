return {
  -- nordic
  {
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
  },

  -- sonokai
  {
    'sainnhe/sonokai',
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = 'andromeda'
    end,
  },

  -- catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        'akinsho/bufferline.nvim',
        priority = 1000,
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ''):find 'catppuccin' then
            opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
          end
        end,
      },
    },
  },
}
