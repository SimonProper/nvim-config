
local snip_status_ok, null_ls = pcall(require, 'null-ls')
if not snip_status_ok then
    return
end

null_ls.setup({
    sources = {null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.rustywind -- null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.lua_format,
    },
    debug = true,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end
                    })
                    -- vim.lsp.buf.formatting_sync()
                end
            })
        end
    end
})
