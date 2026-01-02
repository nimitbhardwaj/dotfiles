-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local posting = require("tools.posting")
local terminal = require("tools.terminal")

vim.keymap.set("n", "<leader>tp", posting.toggle, { desc = "Posting TUI" })
vim.keymap.set({ "n", "t" }, "<C-/>", terminal.toggle_current, {
  desc = "Toggle terminal (smart)",
})
