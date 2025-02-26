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
}
