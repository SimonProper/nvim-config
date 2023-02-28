-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        -- Relative path, to include the parent directory
        path = 1,
        -- Shortens path to leave X spaces in the window
        -- for other components.
        shortening_target = 40,
      }
    }
  }
  
}