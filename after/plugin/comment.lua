local ok, comment = pcall(require, 'Comment')
if not ok then
    return
end

-- Enable Comment.nvim
comment.setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
})
