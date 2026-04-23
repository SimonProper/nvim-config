return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'windwp/nvim-ts-autotag', opts = { enable = true, filetypes = { 'html', 'xml', 'tsx', 'svelte' } } },
  },
  build = ':TSUpdate',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'lua',
      'rust',
      'typescript',
      'tsx',
      'typescript',
      'json',
      'vimdoc',
      'css',
      'html',
      'svelte',
      'javascript',
      'markdown',
      'bash',
      'diff',
      'luadoc',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,

    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'python' } },
  },
  config = function(_, opts)
    require('nvim-treesitter.config').setup(opts)

    -- Incremental selection using native Neovim 0.12 treesitter API
    local select = require('vim.treesitter._select')

    vim.keymap.set('n', '<C-space>', function()
      select.select_parent(1)
    end, { desc = 'Init treesitter selection' })

    vim.keymap.set('x', '<C-space>', function()
      select.select_parent(vim.v.count1)
    end, { desc = 'Expand treesitter selection' })

    vim.keymap.set('x', '<C-backspace>', function()
      select.select_child(vim.v.count1)
    end, { desc = 'Shrink treesitter selection' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
