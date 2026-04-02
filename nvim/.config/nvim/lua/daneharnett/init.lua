-- these settings need to be set before the plugins are loaded
require("daneharnett.pre-plugins").init()

require("daneharnett.plugins")

-- load these settings after the plugins
require("daneharnett.options").init()
require("daneharnett.yank").init()
require("daneharnett.arrowkeys").init()
require("daneharnett.editing").init()
require("daneharnett.buffers").init()
require("daneharnett.diagnostics").init()
require("daneharnett.navigation").init()
require("daneharnett.command-palette").init()
require("daneharnett.panel").init()
