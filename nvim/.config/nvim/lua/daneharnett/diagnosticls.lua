local M = {}

function M.init()
    local status_ok, diagnosticls = pcall(require, "diagnosticls-configs")
    if not status_ok then
        return
    end
    local eslint_status_ok, eslint = pcall(require, "diagnosticls-configs.linters.eslint")
    if not eslint_status_ok then
        return
    end
    local prettier_status_ok, prettier = pcall(require, "diagnosticls-configs.formatters.prettier")
    if not prettier_status_ok then
        return
    end

    diagnosticls.init({})

    diagnosticls.setup({
        javascript = {
            linter = eslint,
        },
        typescript = {
            linter = eslint,
        },
        typescriptreact = {
            linter = eslint,
        },
    })
end

return M
