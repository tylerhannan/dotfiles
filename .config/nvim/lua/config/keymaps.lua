-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape is hard to reach on my keyboards; jk leaves insert mode everywhere.
vim.keymap.set("i", "jk", "<Esc>", { desc = "Leave insert mode" })
