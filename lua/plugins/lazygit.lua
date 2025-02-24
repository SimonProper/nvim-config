return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').load_extension 'lazygit'
  end,
  keys = {
    { '<leader>gd', ':LazyGit<CR>', { silent = true, mode = 'n' } },
  },
}
