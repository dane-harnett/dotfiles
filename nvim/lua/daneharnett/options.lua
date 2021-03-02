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
