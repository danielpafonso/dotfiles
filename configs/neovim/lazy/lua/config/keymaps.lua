-- for conciseness
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

local keymap = vim.keymap -- for conciseness

-- File Explorer
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open [E]xplorer (Netrw)" })
keymap.set("n", "<leader>re", ":Vexplore!<CR>", { desc = "Open [E]xplorer on [R]ight split (Netrw)" })
keymap.set("n", "<leader>le", ":Vexplore<CR>", { desc = "Open [E]xplorer on [L]eft split (Netrw)" })
keymap.set("n", "<leader>de", ":Hexplore<CR>", { desc = "Open [E]xplorer on [D]own split (Netrw)" })
keymap.set("n", "<leader>ue", ":Hexplore!<CR>", { desc = "Open [E]xplorer on [U]p split (Netrw)" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new empty tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

keymap.set("n", "<leader>tt", "<cmd>tabnew | term<CR>", { desc = "Open terminal in new tab" })

-- Terminal management when in <termianl> mode
keymap.set("t", "<A-x>", "<cmd>tabclose<CR>", { desc = "Close terminal tab" })
keymap.set("t", "<A-n>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("t", "<A-p>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Diagnostics -> errors and warnings
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

-- File yanking
keymap.set("n", "<leader>yr", ":let @+ = expand(\"%\")<CR>", { desc = "[Y]ank [r]elative file path" })
keymap.set("n", "<leader>yp", ":let @+ = expand(\"%:p\")<CR>", { desc = "[Y]ank full file [p]ath" })
keymap.set("n", "<leader>yf", ":let @+ = expand(\"%:t\")<CR>", { desc = "[Y]ank [f]ile name" })

-- Buffer navigation
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
