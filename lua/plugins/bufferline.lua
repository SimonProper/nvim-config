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
    { '<TAB>', ':BufferLineCycleNext<CR>', { silent = true, mode = 'n' } },
    { '<S-TAB>', ':BufferLineCyclePrev<CR>', { silent = true, mode = 'n' } },
    { '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', { silent = true, mode = 'n' } },
    { '<leader>]', ':BufferLineMoveNext<CR>', { silent = true, mode = 'n' } },
    { '<leader>[', ':BufferLineMovePrev<CR>', { silent = true, mode = 'n' } },
  },
}
