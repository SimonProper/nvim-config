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
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup({
    view = {
      mappings = {
        list = {
          { key = "h", action = "close_node" },
          { key = "l", action = "edit" },
        },
      },
    },
  })

  -- null-ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.formatting.lua_format,
        },
        debug = true,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
                -- vim.lsp.buf.formatting_sync()
              end,
            })
          end
        end,
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { "string" }, -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
      })
    end,
  })

  -- Packer
  use { 'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim' }

  -- Telescope ignore node_modules
  require('telescope').setup({
    defaults = { file_ignore_patterns = { "node_modules" } }
  })


  use { 'folke/tokyonight.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        }
      })
    end
  }
  vim.cmd [[colorscheme tokyonight-night]]
end
