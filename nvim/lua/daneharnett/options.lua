vim.g.mapleader = ' '
vim.g.colors_name = 'gloombuddy'

local o = vim.o
local bo = vim.bo
local wo = vim.wo

-- global options --
-- do i want to keep these settings?
-- o.errorbells = false
-- o.smartcase = true
-- o.showmode = false
o.backup = false
o.completeopt='menuone,noinsert,noselect'
o.expandtab = true
o.hidden = true
o.incsearch = true
o.shiftwidth = 2
o.softtabstop = 2
o.syntax = 'on'
o.termguicolors = true
o.tabstop = 2
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true

-- buffer options --
bo.autoindent = true
bo.smartindent = true
bo.swapfile = false

-- window options --
wo.colorcolumn = '80'
wo.number = true
wo.relativenumber = true
wo.scrolloff = 8
wo.signcolumn = 'yes'
wo.wrap = false
