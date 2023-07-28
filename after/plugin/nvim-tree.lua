local ok, nvim_tree = pcall(require, 'nvim-tree')

if not ok then
    return
end

nvim_tree.setup({
    hijack_cursor = true,
    view = {
        mappings = {
            list = {{
                key = "h",
                action = "close_node"
            }, {
                key = "l",
                action = "edit"
            }}
        }
    }
})

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

