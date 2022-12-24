local vim = vim

-- Leader key needs to be set before plugins load
vim.g.mapleader = " "

-- Exclude these plugins from vscode
if not vim.g.vscode then
    -- plugins first
    require("daneharnett.plugins")
end

-- options second
require("daneharnett.options")
require("daneharnett.yank")
require("daneharnett.arrowkeys")
require("daneharnett.editing")
require("daneharnett.buffers")

-- Exclude these plugin configs from vscode
if not vim.g.vscode then
    require("daneharnett.diagnostics")
    require("daneharnett.navigation")
    require("daneharnett.command-palette")
end
