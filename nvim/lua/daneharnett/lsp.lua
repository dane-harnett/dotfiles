local utils = require'daneharnett.utils'
local load_mappings = function()
-- lsp keys
utils.key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
utils.key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
utils.key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
utils.key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
utils.key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
utils.key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
utils.key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
utils.key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
utils.key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
utils.key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
utils.key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- diagnostics keys
utils.key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
utils.key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
end
load_mappings()

-- lsp config and setup
local lspconfig = require'lspconfig'
local completion = require'completion'
local lsp_status = require'lsp-status'
lsp_status.register_progress()

-- Diagnostics

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

-- setup language servers here

-- typescript
lspconfig.tsserver.setup({
  on_attach = function (client)
    print('Attaching to ' .. client.name)
    lsp_status.on_attach(client)
    client.resolved_capabilities.document_formatting = false
    vim.cmd[[autocmd CursorHold <buffer> :lua vim.lsp.diagnostic.show_line_diagnostics()]]
  end,
  capabilities = lsp_status.capabilities
})

-- eslint via efm-langserver
-- @see: https://github.com/mattn/efm-langserver
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

lspconfig.efm.setup {
  on_attach = function(client)
    print('Attaching to ' .. client.name)
    lsp_status.on_attach(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
  end,
  capabilities = lsp_status.capabilities,
  root_dir = function()
    if not eslint_config_exists() then
      print('no eslint config found')
      return nil
    end
    print('eslint config found')
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}
