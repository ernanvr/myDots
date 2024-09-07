-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- better up/down
map("i", "jj", "<Esc>", { desc = "Escape", remap = true })
map("i", "<C-l>", "<C-o>a", { desc = "Move one char forward", remap = true })
map("i", "<C-h>", "<C-o>h", { desc = "Move one char forward", remap = true })
map({ "i", "n", "v" }, "<A-j>", "<cmd>:TmuxResizeDown<cr>", { remap = true })
map({ "i", "n", "v" }, "<A-k>", "<cmd>:TmuxResizeUp<cr>", { remap = true })
map({ "n", "v" }, "<leader>tn", "<cmd>:TestNearest<cr>", { remap = true })
map({ "n", "v" }, "<leader>tf", "<cmd>:TestFile<cr>", { remap = true })
map({ "n", "v" }, "<leader>tl", "<cmd>:TestLast<cr>", { remap = true })
map({ "n", "v" }, "<leader>tv", "<cmd>:TestVisit<cr>", { remap = true })
map({ "n", "v" }, "<leader>ts", "<cmd>:TestSuite<cr>", { remap = true })
