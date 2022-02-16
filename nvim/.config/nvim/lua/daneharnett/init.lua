local vim = vim
if not vim.g.vscode then
  -- plugins first
  require'daneharnett.plugins'
end

-- options second
require'daneharnett.options'
require'daneharnett.yank'
require'daneharnett.arrowkeys'
require'daneharnett.editing'


if not vim.g.vscode then
  -- lsp third
  require'daneharnett.lsp'
  require'daneharnett.lspsaga'
  require'daneharnett.null-ls'
  -- the rest
  require'daneharnett.airline'
  require'daneharnett.bufferline'
  require'daneharnett.completion'
  require'daneharnett.diagnostics'
  require'daneharnett.floaterm'
  require'daneharnett.gitsigns'
  require'daneharnett.navigation'
  -- require'daneharnett.nerdtree'
  require'daneharnett.nvim-tree'
  require'daneharnett.prettier'
  require'daneharnett.telescope'
  require'daneharnett.tests'
  require'daneharnett.toggleterm'
  require'daneharnett.treesitter'

  require'colorizer'.setup({
    typescriptreact={css=true}
  })
end
