local M = {}

function M.packchanged_autocmd()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "fff.nvim" and (kind == "install" or kind == "update") then
                if not ev.data.active then
                    vim.cmd.packadd("fff.nvim")
                end
                require("fff.download").download_or_build_binary()
            end
        end,
    })
end

function M.init()
    local utils = require("daneharnett.utils")
    local status_ok, fff = pcall(require, "fff")
    if not status_ok then
        return
    end

    vim.g.fff = {
        lazy_sync = true,
        debug = { enabled = true, show_scores = true },
    }

    utils.keymap("n", "<C-p>", function()
        fff.find_files()
    end, "FFF find files")

    utils.keymap("n", "<leader>ff", function()
        fff.find_files()
    end, "[F]FF find [f]iles")

    utils.keymap("n", "<leader>fg", function()
        fff.live_grep()
    end, "[F]FF live [g]rep")

    utils.keymap("n", "<leader>fz", function()
        fff.live_grep({ grep = { modes = { "fuzzy", "plain" } } })
    end, "[F]FF live fu[z]zy grep")

    utils.keymap("n", "<leader>fc", function()
        fff.live_grep({ query = vim.fn.expand("<cword>") })
    end, "[F]FF find [c]urrent word")
end

return M
