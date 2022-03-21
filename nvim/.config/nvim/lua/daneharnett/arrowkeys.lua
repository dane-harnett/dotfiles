local utils = require("daneharnett.utils")

local load_mappings = function()
    -- disable the arrow keys
    utils.key_mapper("", "<up>", "<nop>")
    utils.key_mapper("", "<down>", "<nop>")
    utils.key_mapper("", "<left>", "<nop>")
    utils.key_mapper("", "<right>", "<nop>")
end
load_mappings()
