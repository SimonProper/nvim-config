local function term_toggle(position)
  local term = Snacks.terminal.get(nil, { create = false })
  if term then
    if term:valid() then
      term:hide()
    else
      term.opts.position = position
      term:show()
    end
  else
    Snacks.terminal.toggle(nil, { win = { position = position } })
  end
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    profiler = { enabled = true },
    terminal = {
      win = {
        on_buf = function(self)
          vim.api.nvim_create_autocmd("FocusGained", {
            buffer = self.buf,
            callback = function()
              if vim.api.nvim_get_current_buf() == self.buf then
                vim.cmd("startinsert")
              end
            end,
          })
        end,
      },
    },
    lazygit = {
      configure = false,
    },
  },
  keys = {
    {
      '<leader>pp',
      function()
        Snacks.profiler.toggle()
      end,
      desc = 'Toggle Profiler',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>bo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete Other Buffers',
    },
    {
      '<leader>gd',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit (Snacks)',
    },
    {
      '<c-/>',
      function()
        term_toggle('bottom')
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>th',
      function()
        term_toggle('right')
      end,
      desc = 'Toggle Terminal Right',
    },
    {
      '<leader>tf',
      function()
        term_toggle('float')
      end,
      desc = 'Toggle Terminal Float',
    },
  },
}
