return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = '┊',
      },
      -- shows the scope of the current cursor position
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        injected_languages = false,
        highlight = { 'Function', 'Label' },
        priority = 500,
      },
    },
  },
}
