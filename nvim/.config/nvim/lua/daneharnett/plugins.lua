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

  -- theme, icons and lines
  use 'kyazdani42/nvim-web-devicons'
  use 'kaicataldo/material.vim'

  use {
    'vim-airline/vim-airline',
    config = function()
      require'daneharnett.airline'
    end,
    requires = {
      'vim-airline/vim-airline-themes'
    }
  }

  use {
    'akinsho/bufferline.nvim',
    config = function()
      require'daneharnett.bufferline'
    end
  }

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

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require'daneharnett.nvim-tree'
    end,
  }

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use 'jremmen/vim-ripgrep'

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end
  }

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
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require'daneharnett.toggleterm'
    end,
  }

  use 'vim-test/vim-test'

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup({
        typescriptreact={css=true}
      })
    end
  }

  use 'lewis6991/gitsigns.nvim'

  use 'tpope/vim-fugitive'
  use {
    'APZelos/blamer.nvim',
    config = function()
      vim.g.blamer_enabled = 1
    end
  }
end)
