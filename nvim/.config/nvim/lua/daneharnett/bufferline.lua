local M = {}

function M.init()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
        return
    end

    bufferline.setup({
        options = {
            max_name_length = 30,
            max_prefix_length = 30,
            tab_size = 21,
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            show_buffer_close_icons = false,
            show_close_icon = false,
            enforce_regular_tabs = true,
        },
    })
end

return M
