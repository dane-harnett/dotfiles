local status_ok, null_ls = pcall(require, "floaterm")
if not status_ok then
	return
end

vim.g.floaterm_width = 0.95
vim.g.floaterm_keymap_new = '<leader>ft'
