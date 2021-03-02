local treesitter_configs = require'nvim-treesitter.configs'
treesitter_configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25
  }
}
