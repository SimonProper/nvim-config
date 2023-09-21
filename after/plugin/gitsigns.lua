local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    return
end

-- Gitsigns
-- See `:help gitsigns.txt`
gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = 'right_align', 
    delay = 0,
  },
}
