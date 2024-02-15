local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    local spectre_status_ok, spectre = pcall(require, "spectre")
    if not spectre_status_ok then
        return
    end

    spectre.setup({
        result_padding = '',
    })

    utils.key_mapper('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>')
    utils.key_mapper('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
    utils.key_mapper('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>')
    utils.key_mapper('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>')
end

return M
