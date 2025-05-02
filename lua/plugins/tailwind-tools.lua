return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {
    server = {
      settings = {
        classFunctions = { 'cva', 'cx', 'createEditorTheme' },
        experimental = {
          classRegex = {
            [[class:\s*'([^']*)']],
            [[ClassName=\s*'([^']*)']],
            [[ClassName=\s*"([^"]*)"]],
            [[className:\s*'([^']*)']],
            "tw\\('([^']*)'\\)",
          },
        },
      },
    },
  },
}
