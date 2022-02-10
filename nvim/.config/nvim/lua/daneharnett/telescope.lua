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
