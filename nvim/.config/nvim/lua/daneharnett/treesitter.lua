local M = {}

function M.packchanged_autocmd()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "nvim-treesitter" and kind == "update" then
                if not ev.data.active then
                    vim.cmd.packadd("nvim-treesitter")
                end
                vim.cmd("TSUpdate")
            end
        end,
    })
end

function M.init()
    local ts_status_ok, ts = pcall(require, "nvim-treesitter")
    if not ts_status_ok then
        return
    end

    local parsers = {
        "bash",
        "css",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "tsx",
        "typescript",
        "vimdoc",
    }

    ts.install(parsers)
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local buf, filetype = args.buf, args.match

            local language = vim.treesitter.language.get_lang(filetype)
            if not language then
                return
            end

            -- check if parser exists and load it
            if not vim.treesitter.language.add(language) then
                return
            end
            -- enables syntax highlighting and other treesitter features
            vim.treesitter.start(buf, language)

            -- enables treesitter based folds
            -- for more info on folds see `:help folds`
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"

            -- enables treesitter based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })

    M.setup_treesitter_context()
end

M.setup_treesitter_context = function()
    local context_status_ok, tscontext = pcall(require, "treesitter-context")
    if context_status_ok then
        tscontext.setup({
            max_lines = 3,
        })
    end
end

return M
