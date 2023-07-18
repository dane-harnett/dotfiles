local M = {}

function M.init()
    local status_ok, efmls = pcall(require, "efmls-configs")
    if not status_ok then
        return
    end
    local eslint_status_ok, eslint = pcall(require, "efmls-configs.linters.eslint")
    if not eslint_status_ok then
        return
    end
    local prettier_status_ok, prettier = pcall(require, "efmls-configs.formatters.prettier")
    if not prettier_status_ok then
        return
    end

    local function on_attach(_, bufnr)
        local utils = require("daneharnett.utils")
        -- Set the timeout to 10s as it kept timing out for me.
        utils.create_format_on_save_autocmd("Efmls", bufnr, 10000)
    end

    efmls.init({
        on_attach = on_attach,
        init_options = {
            documentFormatting = true,
        },
    })

    efmls.setup({
        javascript = {
            linter = eslint,
            formatter = prettier,
        },
        typescript = {
            linter = eslint,
            formatter = prettier,
        },
        typescriptreact = {
            linter = eslint,
            formatter = prettier,
        },
    })
end

return M
