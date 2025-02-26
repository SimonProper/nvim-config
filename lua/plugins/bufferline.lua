-- Bufferline
return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  opts = {
    options = {

      -- adds the prefix path when multiple buffers with the same name are open
      view = 'multieview',
      -- offsets the bufferline from NvimTree sidebar
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true, -- use a "true" to enable the default, or set your own character
        },
      },
      separator_style = 'slant',
      diagnostics = 'nvim_lsp',
    },
  },
  keys = {
    { '<TAB>', ':BufferLineCycleNext<CR>', mode = 'n', silent = true },
    { '<S-TAB>', ':BufferLineCyclePrev<CR>', mode = 'n', silent = true },
    { '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', mode = 'n', silent = true },
    { '<leader>]', ':BufferLineMoveNext<CR>', mode = 'n', silent = true },
    { '<leader>[', ':BufferLineMovePrev<CR>', mode = 'n', silent = true },
  },
}
