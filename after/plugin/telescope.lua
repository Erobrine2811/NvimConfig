local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
local themes = require('telescope.themes')
local opts = { ... } -- picker options
vim.keymap.set('n', '<leader>pf', function() builtin.find_files(themes.get_ivy(opts)) end, {desc = "Find files"})
vim.keymap.set('n', '<leader>pb', function() builtin.buffers(themes.get_ivy(opts)) end, {})
vim.keymap.set('n', '<leader>pr', function() extensions.live_grep_args.live_grep_args(themes.get_ivy(opts)) end, {desc = "Find in files"})
vim.keymap.set('n', '<leader>pc', function() builtin.commands(themes.get_ivy(opts)) end, {desc = "Nvim commands"})
vim.keymap.set('n', '<leader>vh', function() builtin.help_tags(themes.get_ivy(opts)) end, {desc = "Help tags"})

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            }
        },
        path_display = {
            "smart"
        },

    },
    extensions = {
        ["ui-select"] = {
              require("telescope.themes").get_dropdown {
                }
          },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
vim.keymap.set('n', '<leader>fl', require('telescope').extensions.flutter.commands, { desc = 'Open command Flutter' })
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'Code action' })

