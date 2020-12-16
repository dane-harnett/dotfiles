local nvim_lsp = require'nvim_lsp'
local nvim_completion = require'completion'
local nvim_diagnostic = require'diagnostic'

local lsp_status = require'lsp-status'
lsp_status.register_progress()

local function default_on_attach(client)
  nvim_completion.on_attach(client)
  lsp_status.on_attach(client)
  nvim_diagnostic.on_attach(client)
end

local default_config = {
  on_attach = default_on_attach,
  capabilities = lsp_status.capabilities
}

nvim_lsp.tsserver.setup(default_config)

vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
