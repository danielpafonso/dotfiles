-- set netrw style to tree, use key "i" to change
vim.cmd("let g:netrw_liststyle = 3")

-- set color column on 100 for python files
vim.cmd("autocmd FileType python set cc=100")

-- for conciseness
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false

-- Enable mouse mode
opt.mouse = 'a'

-- Save undo history
opt.undofile = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'
opt.termguicolors = true
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- tabs & indentation
opt.tabstop = 4 -- spaces for tabs (prettier default)
opt.shiftwidth = 4 -- spaces for indent width
opt.expandtab = false -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
--opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
--opt.swapfile = false

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300
