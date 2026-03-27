return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    profiler = { enabled = true },
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
    -- Optional: Delete other buffers except current
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
  },
}
