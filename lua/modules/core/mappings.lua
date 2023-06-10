-----------------
-- Keybindings --
-----------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Move and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})

-- Nvim Tree
vim.keymap.set('n', '<leader>ee', ':NvimTreeFocus<CR>', { silent = true })
vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', { silent = true })

-- Format
vim.keymap.set('n', '<leader>f', ':Format<CR>', { silent = true })

-- Git diff view
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', { silent = true })


-- Buffer
vim.keymap.set('n', '<TAB>', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { silent = true })
vim.keymap.set('n', '<leader>bd', ':lua require("bufdelete").bufdelete(0, true)<CR>', { silent = true })
vim.keymap.set('n', '<leader>]', ':BufferLineMoveNext<CR>', { silent = true })
vim.keymap.set('n', '<leader>[', ':BufferLineMovePrev<CR>', { silent = true })

vim.keymap.set('n', '<leader>ss', ':w<CR>', { silent = true })

-- Tab managment
vim.keymap.set('n', '<leader>td', ':tabc<CR>', { silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { silent = true })

-- lsp
vim.keymap.set({ 'v', 'n' }, '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { silent = true })

vim.keymap.set("n", 'gf', ':LspDiagLine<CR>', { silent = true })

--gitsigns
vim.keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk)
vim.keymap.set('n', '<leader>hr', require('gitsigns').reset_hunk)
vim.keymap.set('v', '<leader>hs', function() require('gitsigns').stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set('v', '<leader>hr', function() require('gitsigns').reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer)
vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk)
vim.keymap.set('n', '<leader>hR', require('gitsigns').reset_buffer)
vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk)
vim.keymap.set('n', '<leader>hb', function() require('gitsigns').blame_line{full=true} end)
vim.keymap.set('n', '<leader>tb', require('gitsigns').toggle_current_line_blame)
vim.keymap.set('n', '<leader>hd', require('gitsigns').diffthis)
vim.keymap.set('n', '<leader>hD', function() require('gitsigns').diffthis('~') end)
vim.keymap.set('n', '<leader>td', require('gitsigns').toggle_deleted)

