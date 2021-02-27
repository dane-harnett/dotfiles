--------------------------------------------------------------
-- config inspired by:
-- https://bryankegley.me/posts/nvim-getting-started/
--------------------------------------------------------------
local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- add you plugins here like:
  -- use 'neovim/nvim-lspconfig'

  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'sheerun/vim-polyglot'
  -- these are optional themes but I hear good things about gloombuddy ;)
  -- colorbuddy allows us to run the gloombuddy theme
  use 'tjdevries/colorbuddy.nvim'
  use 'bkegley/gloombuddy'

  -- js/ts 
  use 'leafgarland/typescript-vim'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
  use {'prettier/vim-prettier', run = 'yarn install' }

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp-status.nvim'
  use 'anott03/nvim-lspinstall'

  -- nerdtree
  use 'preservim/nerdtree'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'
  end
)

vim.g.mapleader = ' '
vim.g.colors_name = 'gloombuddy'

local o = vim.o
local bo = vim.bo
local wo = vim.wo

-- global options --
o.termguicolors = true
o.syntax = 'on'
-- do i want to keep these settings?
-- o.errorbells = false
-- o.smartcase = true
-- o.showmode = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- buffer options --
bo.swapfile = false
bo.autoindent = true
bo.smartindent = true

-- window options --
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = false

-- my options - decide if i want to keep these
-- set colorcolumn=80
-- set guicursor=n-v-c-sm:block,i-ci-ve:ver25-blinkwait5-blinkon5-blinkoff5,r-cr-o:hor20-blinkwait0-blinkon50-blinkoff50
-- set hidden
-- set nowrap
-- set scrolloff=8



local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- format on save
vim.cmd[[autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx,*.svelte,*.yml,*yaml :Prettier]]

-- disable the arrow keys
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')


-- lsp keys
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- completion keys
vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]

-- diagnostics keys
key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')




local treesitter_configs = require'nvim-treesitter.configs'
treesitter_configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25
  }
}



local lspconfig = require'lspconfig'
local completion = require'completion'
local lsp_status = require'lsp-status'
lsp_status.register_progress()

-- Diagnostics
vim.cmd [[au! CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

local function custom_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
  lsp_status.on_attach(client)
end
local default_config = {
  on_attach = custom_on_attach,
  capabilities = lsp_status.capabilities
}
-- setup language servers here
lspconfig.tsserver.setup(default_config)


-- diag completion settings
vim.g.completion_matching_strategy_list = {'substring', 'exact', 'fuzzy', 'all'}
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_insert_delay = 1
vim.g.completion_chain_complete_list = {
  {complete_items = {'lsp', 'snippet'}},
  {mode = '<c-p>'},
  {mode = '<c-n>'},
}

-- nerdtree
key_mapper('n', '<leader>ne', ':NERDTreeToggle<CR>')
vim.g.NERDTreeIgnore = {'^.git$', '^node_modules$'}
vim.g.NERDTreeShowHidden=1
vim.g.NERDTreeWinPos="right"



-- telescope
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')




