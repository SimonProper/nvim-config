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
    -- init = function()
    --   -- Load the colorscheme here.
    --   vim.cmd.colorscheme 'nordic'
    -- end,
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
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,

    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides =
        ---@param colors KanagawaColors
        function(colors)
          local theme = colors.theme

          colors.theme.ui.bg_gutter = theme.ui.bg

          local makeDiagnosticColor = function(color)
            local c = require 'kanagawa.lib.color'
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- TelescopeTitle = { fg = theme.ui.special, bold = true },
            -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
            -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
            -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

            NoiceCmdlineIcon = {
              bg = theme.ui.bg,
              fg = theme.ui.special,
            },

            NoiceCmdlineIconSearch = {
              bg = theme.ui.bg,
              fg = theme.ui.special,
            },

            NoiceCmdlinePopup = {
              bg = theme.ui.bg,
              fg = theme.ui.fg,
            },
            NoiceCmdlinePopupBorder = {
              bg = theme.ui.bg,
              fg = theme.ui.bg_p2,
            },

            NoicePopupBorder = {
              bg = theme.ui.bg,
              fg = colors.palette.roninYellow,
            },

            NoiceCmdlinePopupBorderSearch = {
              bg = theme.ui.bg,
              fg = colors.palette.roninYellow,
            },

            NoiceCmdlinePrompt = {
              bg = theme.ui.bg,
              fg = colors.palette.roninYellow,
            },

            LazyGitFloat = {
              bg = theme.ui.bg,
              fg = colors.palette.fujiWhite,
            },
            LazyGitBorder = {
              bg = theme.ui.bg,
              fg = theme.ui.bg_p2,
            },
          }
        end,
    },
  },
}
