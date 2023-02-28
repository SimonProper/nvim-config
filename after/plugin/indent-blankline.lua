local ok, indentBlankline = pcall(require, 'indent_blankline')
if not ok then
    return
end

indentBlankline.setup({
    char = '┊',
    show_trailing_blankline_indent = false
})
