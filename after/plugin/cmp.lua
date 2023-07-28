-- nvim-cmp setup
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
    return
end

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    },
    sources = { {
        name = 'nvim_lsp',
        keyword_length = 2,
        group_index = 1,
        max_item_count = 30
    }, {
        name = 'luasnip'
    } },
    window = {
        completion = cmp.config.window.bordered({ border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None" }),
        documentation = cmp.config.window.bordered({ border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None" }),
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}
