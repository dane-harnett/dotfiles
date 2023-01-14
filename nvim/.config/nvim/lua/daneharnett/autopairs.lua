local M = {}

function M.init()
    local autopairs_status_ok, autopairs = pcall(require, "nvim-autopairs")
    if not autopairs_status_ok then
        return
    end
    autopairs.setup({
        check_ts = true,
        fast_wrap = {},
    })
end

return M
