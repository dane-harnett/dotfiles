local treesitter_configs = require'nvim-treesitter.configs'
treesitter_configs.setup {
  ensure_installed = {
    "bash",
    "css",
    "html",
    "java",
    "javascript",
    "lua",
    "tsx",
    "typescript",
  },
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25
  }
}
