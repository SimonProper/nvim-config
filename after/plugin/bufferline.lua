local ok, bufferline = pcall(require, 'bufferline')
if not ok then
    return
end

bufferline.setup({
    options = {
      -- adds the prefix path when multiple buffers with the same name are open
      view = 'multieview',
      -- offsets the bufferline from NvimTree sidebar
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true -- use a "true" to enable the default, or set your own character
        }
      },
      separator_style = 'slant',
      diagnostics = "nvim_lsp",
    }
  })