-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- LazyVim already soft-wraps and spell-checks markdown and text; blog posts also live in HTML.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("prose_html", { clear = true }),
  pattern = { "html" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
