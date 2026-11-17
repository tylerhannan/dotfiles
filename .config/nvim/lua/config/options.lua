-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.o.background = "dark"

-- Don't rewrite AI-generated files on save; format on demand with <leader>cf.
vim.g.autoformat = false

-- "en" accepts British and American spellings alike.
vim.opt.spelllang = { "en" }

-- Plain line numbers, and wrap long lines so AI-written SQL fits a narrow split.
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.opt.breakindent = true
