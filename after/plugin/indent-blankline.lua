local ok, indentBlankline = pcall(require, 'ibl')
if not ok then
    return
end

indentBlankline.setup({
    indent = {
    char = '┊',
    },
    show_trailing_blankline_indent = false
})
