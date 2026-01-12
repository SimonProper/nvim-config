local pipe_path = '/tmp/nvim-' .. vim.loop.os_getpid() .. '.pipe'

-- 1. Remove stale pipe if it exists from a previous crash
if vim.fn.filereadable(pipe_path) == 1 or vim.fn.getftype(pipe_path) == 'socket' then
  os.remove(pipe_path)
end

-- 2. Start the server with error handling
local success, server_err = pcall(function()
  vim.fn.serverstart(pipe_path)
end)

if not success then
  print('Failed to start nvim server: ' .. tostring(server_err))
else
  vim.env.NVIM_LISTEN_ADDRESS = pipe_path
end

-- 3. Cleanup on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if vim.fn.getftype(pipe_path) == 'socket' then
      os.remove(pipe_path)
    end
  end,
})

-- Sync CWD to the directory of the first file opened
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Get the path of the current buffer
    local path = vim.fn.expand '%:p:h'

    -- If it's a valid directory, set it as CWD
    if vim.fn.isdirectory(path) == 1 then
      pcall(vim.api.nvim_set_current_dir, path)
    end
  end,
})

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.lazy'

require('lazy').setup 'plugins'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
