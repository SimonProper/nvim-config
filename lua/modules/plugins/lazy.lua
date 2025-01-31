-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },

    { 'Bilal2453/luvit-meta', lazy = true },

    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       opts = {} },
        },

    },

    -- Cmp
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }
    },
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update {
                with_sync = true
            })
        end
    },

    { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    },

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',

    'nvim-lualine/lualine.nvim',           -- Fancier statusline
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    'numToStr/Comment.nvim',               -- "gc" to comment visual regions/lines
    'tpope/vim-sleuth',                    -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1
    },

    -----------------
    -- My plugins under
    -----------------

    ({
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
            }
        end,
    }),

    -- none-ls previously null-ls
    ({
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" }
    }),

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    -- Auto tags
    {
        "windwp/nvim-ts-autotag",
        lazy = false
    },

    -- Surround
    {
        "kylechui/nvim-surround",
    },

    -- Diffview
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim'
    },

    -- Cattppuccin color theme
    {
        "catppuccin/nvim",
        as = "catppuccin"
    },

    {
        'sainnhe/sonokai',
        as = 'sonokai'
    },

    'AlexvZyl/nordic.nvim',
    'folke/tokyonight.nvim',

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    -- Delete buffer
    'famiu/bufdelete.nvim',

    -- Comment context
    'JoosepAlviste/nvim-ts-context-commentstring',

    -- Noice
    {
        "folke/noice.nvim",
        dependencies = {            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim", -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to  the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify" }
    },

    'stevearc/dressing.nvim',

    'fladson/vim-kitty',

    -- Astro
    'wuelnerdotexe/vim-astro',

    -- Markdown
    ({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }),

    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },

    -- LazyGit
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "karb94/neoscroll.nvim",
        opts = {
            mappings = { -- Keys to be mapped to their corresponding default scrolling animation
                '<C-u>', '<C-d>',
                '<C-b>', '<C-f>',
                '<C-y>', '<C-e>',
                'zt', 'zz', 'zb',
            },
            hide_cursor = true, -- Hide cursor while scrolling
            stop_eof = true,   -- Stop at <EOF> when scrolling downwards
            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            duration_multiplier = 1.0, -- Global duration multiplier
            easing = 'linear', -- Default easing function
            pre_hook = nil,    -- Function to run before the scrolling animation starts
            post_hook = nil,   -- Function to run after the scrolling animation ends
            performance_mode = false, -- Disable "Performance Mode" on all buffers.
            ignored_events = { -- Events ignored while scrolling
                'WinScrolled', 'CursorMoved'
            },
        },
    }

})
