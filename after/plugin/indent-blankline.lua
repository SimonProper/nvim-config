local ok, indentBlankline = pcall(require, 'ibl')
if not ok then
    return
end

indentBlankline.setup({
    indent = {
    char = '┊',
    },
})
