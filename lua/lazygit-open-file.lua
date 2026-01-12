return function(filename, line_number)
  -- 1. Clean the path strings
  local clean_path = filename:gsub('^"', ''):gsub('"$', ''):gsub('\\%$', '$')
  line_number = tonumber(line_number) or 1

  -- 2. Identify the window running Lazygit
  local lazygit_win = vim.api.nvim_get_current_win()

  local status, err = pcall(function()
    local escaped_path = vim.fn.fnameescape(clean_path)

    -- 3. Force the file to open in a "normal" window
    -- We jump to the previous window (the one behind the plugin)
    -- before opening the file to ensure we aren't "trapped" in a float.
    vim.cmd 'wincmd p'
    vim.cmd('edit ' .. escaped_path)

    -- 4. Get the new window handle and focus it explicitly
    local target_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(target_win)

    -- 5. Set the line and center it
    vim.api.nvim_win_set_cursor(target_win, { line_number, 0 })
    vim.cmd 'normal! zz'

    -- 6. Close the Lazygit window if it's still open
    if vim.api.nvim_win_is_valid(lazygit_win) then
      vim.api.nvim_win_close(lazygit_win, true)
    end
  end)

  if not status then
    vim.notify('Lazygit Open Error: ' .. tostring(err), vim.log.levels.ERROR)
  end
end
