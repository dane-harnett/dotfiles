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
    local status_ok, fff = pcall(require, "fff")
    if not status_ok then
        return
    end

    vim.g.fff = {
        lazy_sync = true,
        debug = { enabled = true, show_scores = true },
    }

    vim.keymap.set("n", "ff", function()
        fff.find_files()
    end, { desc = "FFFind files" })

    vim.keymap.set("n", "fg", function()
        fff.live_grep()
    end, { desc = "LiFFFe grep" })

    vim.keymap.set("n", "fz", function()
        fff.live_grep({ grep = { modes = { "fuzzy", "plain" } } })
    end, { desc = "Live FFFuzzy grep" })

    vim.keymap.set("n", "fc", function()
        fff.live_grep({ query = vim.fn.expand("<cword>") })
    end, { desc = "FFFind current word" })
end

return M
