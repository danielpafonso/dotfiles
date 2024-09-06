-- for conciseness
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open [E]xplorer (Netrw)" })
keymap.set("n", "<leader>re", ":Vexplore!<CR>", { desc = "Open [E]xplorer on [R]ight split (Netrw)" })
keymap.set("n", "<leader>le", ":Vexplore<CR>", { desc = "Open [E]xplorer on [L]eft split (Netrw)" })
keymap.set("n", "<leader>de", ":Hexplore<CR>", { desc = "Open [E]xplorer on [D]own split (Netrw)" })
keymap.set("n", "<leader>ue", ":Hexplore!<CR>", { desc = "Open [E]xplorer on [U]p split (Netrw)" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
--[[
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
]]--
