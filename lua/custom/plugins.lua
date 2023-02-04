return function(use)
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })

  -- null-ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Autopairs
  use { "windwp/nvim-autopairs" }

  -- Auto tags
  use { "windwp/nvim-ts-autotag" }

  -- Diffview
  use { 'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim' }


  -- Cattppuccin color theme
  use { "catppuccin/nvim", as = "catppuccin" }

  use { 'sainnhe/sonokai', as = 'sonokai' }

  use 'AlexvZyl/nordic.nvim'

  -- Bufferline
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
  -- Delete buffer
  use { 'famiu/bufdelete.nvim' }

  -- Comment context
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }

  -- Noice
  use { "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }

  use {
    'stevearc/dressing.nvim',
  }

  use {'fladson/vim-kitty'}

end
