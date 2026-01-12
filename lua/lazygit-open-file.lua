return function(filename, line_number)
  local clean_path = filename:gsub('^"', ''):gsub('"$', ''):gsub('\\%$', '$')
  line_number = tonumber(line_number) or 1
  local lazygit_win = vim.api.nvim_get_current_win()

  -- Using schedule ensures the code runs after any current terminal/plugin
  -- callback logic finishes, preventing focus "stickiness".
  vim.schedule(function()
    local status, err = pcall(function()
      local escaped_path = vim.fn.fnameescape(clean_path)

      -- 1. Close the floating Lazygit window first
      if vim.api.nvim_win_is_valid(lazygit_win) then
        vim.api.nvim_win_close(lazygit_win, true)
      end

      -- 2. Open the file in the remaining (main) window
      vim.cmd('edit ' .. escaped_path)

      -- 3. Jump to line and center
      vim.api.nvim_win_set_cursor(0, { line_number, 0 })
      vim.cmd 'normal! zz'
    end)

    if not status then
      vim.notify('Lazygit Open Error: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end
