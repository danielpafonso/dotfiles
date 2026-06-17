-- set netrw style to tree, use key "i" to change
vim.cmd("let g:netrw_liststyle = 3")

-- set color column on 100 for python files
vim.cmd("autocmd FileType python set cc=100")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Save undo history
vim.opt.undofile = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- tabs & indentation
vim.opt.tabstop = 4 -- spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- spaces for indent width
vim.opt.expandtab = false -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
--opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
--opt.swapfile = false

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Number of lines offscreen to keep above and bellow cursor
vim.opt.scrolloff = 5

-- add float to diagnostic jumps
vim.diagnostic.config({ jump = { float = true }})
