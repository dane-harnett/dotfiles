local vim = vim
if not vim.g.vscode then
  -- plugins first
  require'daneharnett.plugins'
end

-- options second
require'daneharnett.options'
require'daneharnett.yank'
require'daneharnett.arrowkeys'

if not vim.g.vscode then
  -- lsp third
  require'daneharnett.lsp'
  -- require'daneharnett.lspsaga'
  -- the rest
  require'daneharnett.airline'
  require'daneharnett.completion'
  require'daneharnett.diagnostics'
  -- require'daneharnett.nerdtree'
  require'daneharnett.prettier'
  require'daneharnett.telescope'
  require'daneharnett.treesitter'
  require'daneharnett.floaterm'
  require'daneharnett.tests'

  require'colorizer'.setup({
    typescriptreact={css=true}
  })
end
