vim.g.mapleader = ' '

-- Exclude these options from vscode
if not vim.g.vscode then
  --vim.g.material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'v
  vim.g.material_theme_style = 'ocean'
  vim.cmd[[colorscheme material]]
  vim.g.colors_name = 'material'
end

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
o.listchars = [[tab:▸ ,trail:·,space:·]]
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
wo.colorcolumn = '80,100,120'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.scrolloff = 8
wo.signcolumn = 'yes'
wo.wrap = false
