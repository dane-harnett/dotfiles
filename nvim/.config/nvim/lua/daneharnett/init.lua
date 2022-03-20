local vim = vim

-- Exclude these plugins from vscode
if not vim.g.vscode then
  -- plugins first
  require'daneharnett.plugins'
end

-- options second
require'daneharnett.options'
require'daneharnett.yank'
require'daneharnett.arrowkeys'
require'daneharnett.editing'

-- Exclude these plugin configs from vscode
if not vim.g.vscode then
  -- lsp third
  require'daneharnett.lsp'
  require'daneharnett.lspsaga'
  require'daneharnett.null-ls'
  -- the rest
  require'daneharnett.completion'
  require'daneharnett.diagnostics'
  require'daneharnett.floaterm'
  require'daneharnett.gitsigns'
  require'daneharnett.navigation'
  require'daneharnett.telescope'
  require'daneharnett.tests'
  require'daneharnett.treesitter'

  require'daneharnett.command-palette'
end
