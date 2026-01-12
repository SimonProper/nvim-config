-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>ee', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>et', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    window = {
      mappings = {
        -- ['h'] = 'parent_or_close',
        -- ['l'] = 'child_or_open',
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<S-CR>'] = 'set_root',
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
      hijack_netrw_behavior = 'open_default',
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  event_handlers = {
    {
      event = 'dir_changed',
      handler = function(args)
        -- args.cwd is the new directory neo-tree is looking at
        pcall(vim.api.nvim_set_current_dir, args.cwd)
        -- Optional: notify so you know it worked
        -- vim.notify("CWD updated to: " .. args.cwd)
      end,
    },
  },
}
