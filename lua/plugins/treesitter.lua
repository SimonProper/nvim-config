-- Highlight, edit, and navigate code.
-- NOTE: the `main` branch is a full rewrite; `setup()` only takes `install_dir`.
-- Parsers are installed explicitly and highlighting is started per-buffer.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    { 'windwp/nvim-ts-autotag', opts = { enable = true, filetypes = { 'html', 'xml', 'tsx', 'svelte' } } },
  },
  config = function()
    local Parsers = {
      'bash',
      'css',
      'diff',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'rust',
      'svelte',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter').install(Parsers)

    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Start treesitter highlighting and indentation',
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then return end
        local ok, added = pcall(vim.treesitter.language.add, lang)
        if not ok or not added then return end

        vim.treesitter.start(ev.buf, lang)

        -- Treesitter indentation is experimental; python indents better without it.
        if ev.match ~= 'python' then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

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
