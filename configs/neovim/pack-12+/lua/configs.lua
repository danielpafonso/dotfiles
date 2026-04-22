------  Configs  ------
vim.cmd.colorscheme "catppuccin-frappe"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Save undo history
vim.opt.undofile = true

-- tabs & indentation
vim.opt.tabstop = 4 -- spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- spaces for indent width
vim.opt.expandtab = false -- expand tab to spaces

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- Number of lines offscreen to keep above and bellow cursor
vim.opt.scrolloff = 5

-- set netrw style to tree, use key "i" to change
vim.cmd("let g:netrw_liststyle = 3")
