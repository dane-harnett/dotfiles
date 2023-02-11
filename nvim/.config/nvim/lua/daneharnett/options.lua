local M = {}

function M.init()
    local o = vim.o
    local bo = vim.bo
    local wo = vim.wo

    -- global options --
    -- do i want to keep these settings?
    -- o.errorbells = false
    -- o.smartcase = true
    -- o.showmode = false
    o.backup = false
    o.completeopt = "menuone,noinsert,noselect"
    o.expandtab = true
    o.filetype = "on"

    -- folds
    -- customize chars and start open
    o.fillchars = "foldopen:,foldclose:"
    o.foldcolumn = "auto"
    o.foldlevelstart = 99
    o.foldnestmax = 3
    o.foldminlines = 1

    o.hidden = true
    o.incsearch = true
    o.listchars = [[tab:▸ ,trail:·,space:·]]
    o.scrolloff = 8
    o.shiftwidth = 2
    o.softtabstop = 2
    o.syntax = "on"
    o.tabstop = 2
    o.undodir = vim.fn.stdpath("data") .. "/undodir"
    o.undofile = true

    -- buffer options --
    bo.autoindent = true
    bo.smartindent = true
    bo.swapfile = false

    -- window options --
    wo.colorcolumn = "80,100,120"
    wo.cursorcolumn = true
    wo.cursorline = true
    wo.list = true
    wo.number = true
    wo.numberwidth = 5
    wo.relativenumber = true
    wo.signcolumn = "yes"
    wo.wrap = false
end

return M
