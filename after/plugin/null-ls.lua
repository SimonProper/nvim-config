local snip_status_ok, null_ls = pcall(require, 'null-ls')
if not snip_status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local builtin = null_ls.builtins

local sources = {
    builtin.formatting.prettier.with({
            extra_filetypes = { "astro" },
        }),
    builtin.formatting.rustfmt
}

null_ls.setup({
    sources = sources,
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
                end
            })
        end
    end
})
