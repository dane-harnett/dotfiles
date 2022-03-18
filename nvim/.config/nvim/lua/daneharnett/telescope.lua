local load_mappings = function()
  vim.keymap.set('n', '<C-p>', '<CMD>Telescope find_files<CR>')
  vim.keymap.set('n', '<LEADER>dl', '<CMD>Telescope diagnostics<CR>')
  vim.keymap.set('n', '<LEADER>fb', '<CMD>Telescope file_browser<CR>')
  vim.keymap.set('n', '<LEADER>fg', '<CMD>Telescope git_files<CR>')
  vim.keymap.set('n', '<LEADER>fh', '<CMD>Telescope help_tags<CR>')
  vim.keymap.set('n', '<LEADER>fs', '<CMD>Telescope grep_string<CR>')
  vim.keymap.set('n', '<LEADER>lb', '<CMD>Telescope buffers<CR>')
  vim.keymap.set('n', '<LEADER>lg', '<CMD>Telescope live_grep<CR>')
end
load_mappings()

local telescope_actions = require("telescope.actions.set")
-- FileType event doesn't fire when opening from telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
-- workaround from:
-- https://github.com/David-Kunz/vim/blob/master/init.lua#L205-L232
local fixfolds = {
  hidden = true,
  attach_mappings = function(_)
    telescope_actions.select:enhance({
      post = function()
        vim.cmd(":normal! zx")
      end,
    })
    return true
  end,
}

local telescope = require'telescope'
telescope.setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    path_display = {
      truncate = true,
    },
    prompt_prefix = ' >',
    color_devicons = true,
    layout_config = {
      horizontal = {
        preview_width = 40,
        width = 0.9,
      },
    },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    buffers = fixfolds,
    find_files = fixfolds,
    git_files = fixfolds,
    grep_string = fixfolds,
    live_grep = fixfolds,
    oldfiles = fixfolds,
  },
}
telescope.load_extension('fzf')
