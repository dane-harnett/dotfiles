
-- format on save
vim.cmd[[autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx,*.svelte :silent Prettier]]
