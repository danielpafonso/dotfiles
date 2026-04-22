------  Keybinds  ------
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

-- File Explorer
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open [E]xplorer (Netrw)" })
vim.keymap.set("n", "<leader>re", ":Vexplore<CR>", { desc = "Open [E]xplorer on [R]ight split (Netrw)" })
vim.keymap.set("n", "<leader>le", ":Vexplore!<CR>", { desc = "Open [E]xplorer on [L]eft split (Netrw)" })
vim.keymap.set("n", "<leader>de", ":Hexplore<CR>", { desc = "Open [E]xplorer on [D]own split (Netrw)" })
vim.keymap.set("n", "<leader>ue", ":Hexplore!<CR>", { desc = "Open [E]xplorer on [U]p split (Netrw)" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- File yanking
vim.keymap.set("n", "<leader>yr", ":let @+ = expand(\"%\")<CR>", { desc = "[Y]ank [r]elative file path" })
vim.keymap.set("n", "<leader>yp", ":let @+ = expand(\"%:p\")<CR>", { desc = "[Y]ank full file [p]ath" })
vim.keymap.set("n", "<leader>yf", ":let @+ = expand(\"%:t\")<CR>", { desc = "[Y]ank [f]ile name" })

-- Buffer navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Toogle word wraping
vim.keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toogle word [w]wraping" })
