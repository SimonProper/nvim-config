local nvim_autopairs_ok, nvim_autopairs = pcall(require, 'nvim-autopairs')

if not nvim_autopairs_ok then
    return
end

nvim_autopairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
        lua = {"string"}, -- don't add pairs in lua string treesitter nodes
        javascript = {"template_string"}, -- don't add pairs in javscript template_string treesitter nodes
        java = false -- don't check treesitter on java
    }
})
