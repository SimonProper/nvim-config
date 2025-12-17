return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },

  config = function()
    vim.keymap.set('n', '<leader>fb', function()
      require('telescope').extensions.file_browser.file_browser()
    end, { desc = '[F]ile [B]rows' })

    local get_select_for = function(for_builtin)
      local ts_select_dir_for_grep = function(prompt_bufnr)
        local action_state = require 'telescope.actions.state'
        local fb = require('telescope').extensions.file_browser
        local builtin = require('telescope.builtin')[for_builtin]
        local current_line = action_state.get_current_line()

        fb.file_browser {
          files = false,
          depth = false,
          attach_mappings = function(prompt_bufnr)
            require('telescope.actions').select_default:replace(function()
              local entry_path = action_state.get_selected_entry().Path
              local dir = entry_path:is_dir() and entry_path or entry_path:parent()
              local relative = dir:make_relative(vim.fn.getcwd())
              local absolute = dir:absolute()

              builtin {
                results_title = relative .. '/',
                cwd = absolute,
                default_text = current_line,
              }
            end)

            return true
          end,
        }
      end

      return ts_select_dir_for_grep
    end

    local fb_actions = require('telescope').extensions.file_browser.actions

    ---@module "telescope"
    require('telescope').setup {
      pickers = {

        find_files = {
          mappings = {
            i = {
              ['<C-f>'] = get_select_for 'find_files',
            },
            n = {
              ['<C-f>'] = get_select_for 'find_files',
            },
          },
        },
        live_grep = {
          mappings = {
            i = {
              ['<C-f>'] = get_select_for 'live_grep',
            },
            n = {
              ['<C-f>'] = get_select_for 'live_grep',
            },
          },
        },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              -- your custom insert mode mappings
            },
            ['n'] = {
              -- your custom normal mode mappings
              l = fb_actions.open_dir,
            },
          },
        },
      },
    }
  end,
}
