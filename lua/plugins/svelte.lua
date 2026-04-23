return {
  {
    'leafOfTree/vim-svelte-plugin',
    ft = 'svelte',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
      vim.g.vim_svelte_plugin_use_typescript = 1
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
