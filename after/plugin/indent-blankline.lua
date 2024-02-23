local ok, indentBlankline = pcall(require, 'ibl')
if not ok then
    return
end

indentBlankline.setup({
    indent = {
    char = '┊',
    },
    scope= {
       enabled = true,
       show_start = true,
       show_end = true,
       injected_languages = false,
       highlight = { "Function", "Label" },
       priority = 500,
    }
})
