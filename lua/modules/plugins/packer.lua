return require('packer').startup({function(use)
      -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
    -- Package manager
    use 'wbthomason/packer.nvim'

    use({ 'lewis6991/impatient.nvim' })

    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = { -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        'j-hui/fidget.nvim', -- Additional lua configuration, makes nvim stuff amazing
        'folke/neodev.nvim'}
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'}
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update {
                with_sync = true
            })
        end
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'

    --[[ use 'navarasu/onedark.nvim' -- Theme inspired by Atom ]]
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1
    }

    -----------------
    -- My plugins under
    -----------------

    use({
        "nvim-tree/nvim-tree.lua",
        requires = {"nvim-tree/nvim-web-devicons" -- optional, for file icons
        },
        tag = "nightly" -- optional, updated every week. (see issue #1193)
    })

    -- null-ls
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {"nvim-lua/plenary.nvim"}
    })

    -- Autopairs
    use {"windwp/nvim-autopairs"}

    -- Auto tags
    use {"windwp/nvim-ts-autotag"}

    -- Diffview
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Cattppuccin color theme
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }

    use {
        'sainnhe/sonokai',
        as = 'sonokai'
    }

    use 'AlexvZyl/nordic.nvim'

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }
    -- Delete buffer
    use {'famiu/bufdelete.nvim'}

    -- Comment context
    use {'JoosepAlviste/nvim-ts-context-commentstring'}

    -- Noice
    use {
        "folke/noice.nvim",
        requires = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim", -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify"}
    }

    use {'stevearc/dressing.nvim'}

    use {'fladson/vim-kitty'}

    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-buffer'}
end})
