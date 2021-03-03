local utils = require'daneharnett.utils'
local load_mappings = function()
-- telescope
utils.key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
utils.key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
utils.key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
utils.key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
end
load_mappings()


local telescope = require'telescope'
telescope.setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    file_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
telescope.load_extension('fzy_native')
