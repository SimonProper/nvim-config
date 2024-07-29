local ok, nvim_tree = pcall(require, 'nvim-tree')

if not ok then
    return
end

local function custom_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close level'))
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Edit file'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end


nvim_tree.setup({
    on_attach = custom_on_attach,
    hijack_cursor = true,
    view = {
        adaptive_size = true
    }
})

--[[ local function open_nvim_tree(data)
    -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
]]
