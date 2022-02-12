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
  -- use 'leafgarland/typescript-vim'
  -- use 'pangloss/vim-javascript'
  -- use 'peitalin/vim-jsx-typescript'
  -- use {
  --   'prettier/vim-prettier',
  --   run = 'yarn install'
  -- }

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'nvim-lua/lsp-status.nvim'
  use 'anott03/nvim-lspinstall'
  use 'tami5/lspsaga.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- nerdtree
  use 'preservim/nerdtree'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  -- use 'jremmen/vim-ripgrep'

  use "kyazdani42/nvim-web-devicons"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  -- airline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- editorconfig
  use 'editorconfig/editorconfig-vim'

  -- vim-smoothie for smooth scrolling
  use 'psliwka/vim-smoothie'

  -- comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- autopairs
  use 'jiangmiao/auto-pairs'

  -- terminal
  use 'akinsho/toggleterm.nvim'
  -- use 'voldikss/vim-floaterm'

  use 'vim-test/vim-test'

  use 'norcalli/nvim-colorizer.lua'

  use "lewis6991/gitsigns.nvim"
  end
)

