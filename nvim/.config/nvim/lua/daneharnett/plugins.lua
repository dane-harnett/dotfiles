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
  -- add your plugins here like:
  -- use 'neovim/nvim-lspconfig'

  -- treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'sheerun/vim-polyglot'
  use 'nvim-treesitter/completion-treesitter'

  use 'kaicataldo/material.vim'

  -- js/ts
  use 'leafgarland/typescript-vim'
  use 'pangloss/vim-javascript'
  use 'peitalin/vim-jsx-typescript'
  use {
    'prettier/vim-prettier',
    run = 'yarn install'
  }

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/lsp-status.nvim'
  use 'anott03/nvim-lspinstall'
  use 'glepnir/lspsaga.nvim'

  -- nerdtree
  use 'preservim/nerdtree'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  -- use 'jremmen/vim-ripgrep'

  -- airline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- editorconfig
  use 'editorconfig/editorconfig-vim'

  -- vim-smoothie for smooth scrolling
  use 'psliwka/vim-smoothie'

  -- comments
  use 'b3nj5m1n/kommentary'

  -- autopairs
  use 'jiangmiao/auto-pairs'

  -- terminal
  use 'voldikss/vim-floaterm'

  use 'vim-test/vim-test'

  use 'norcalli/nvim-colorizer.lua'
  end
)

