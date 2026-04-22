-----  Plugins  ------
-- comment lines and blocks
vim.pack.add({"https://github.com/numToStr/Comment.nvim"})

-- Detect tabstop and shiftwidth automatically
vim.pack.add({"https://github.com/tpope/vim-sleuth"})

-- Color Theme
vim.pack.add({{src = "https://github.com/catppuccin/nvim", name = "catppuccin"}})
-- vim.pack.add({"https://github.com/navarasu/onedark.nvim"})

-- Status line
vim.pack.add({"https://github.com/nvim-lualine/lualine.nvim"})
require("lualine").setup({
  options = {
   icons_enabled = true,
    -- theme = "onedark",
    theme = "auto",
    component_separators = "|",
  },
  sections = {
    lualine_c = {{ "filename", path = 1 }}
  },
  inactive_sections = {
    lualine_a = {{ "filename", path = 1 }},
    lualine_c = {"filesize"},
    lualine_x = {},
  }
})

-- Fuzzy finder
vim.pack.add(
  -- {"https://github.com/nvim-tree/nvim-web-devicons"},
  {"https://github.com/ibhagwan/fzf-lua"}
)
require("fzf-lua").setup({
  fzf_colors = true,
  fzf_opts = {
    -- ["--no-scrollbar"] = false,
    ["--cycle"] = true,
  },
  defaults = {
    formatter = "path.dirname_first", -- show greyed-out directory before filename
  },
  keymap = {
    fzf = {
      ["ctrl-k"] = "up",
      ["ctrl-j"] = "down",
      ["ctrl-b"] = "preview-page-up",
      ["ctrl-f"] = "preview-page-down",
      ["ctrl-u"] = "half-page-up", -- in list of search results
      ["ctrl-d"] = "half-page-down", -- in list of search results
      ["ctrl-c"] = "abort",
      ["ctrl-q"] = "select-all+accept",
    },
  },
})


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

-- fzf
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", {desc = "[F]uzzy [f]ind files in cwd" })
vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", {desc = "[F]uzzy find [s]tring in cwd" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>", { desc = "[F]uzzy find string under [c]ursor in cwd" })
vim.keymap.set('n', '<leader>fb', "<cmd>FzfLua buffers<cr>", { desc = "[F]uzzy find existing [b]uffers" })
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "[F]uzzy find LSP [d]ocument symbols" })
-- vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<cr>", {desc = "fuzzy find by using ripgrep in project directory" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua lgrep_curbuf<cr>", {desc = "[f]ind (grep) in [c]urrent buffer" })
