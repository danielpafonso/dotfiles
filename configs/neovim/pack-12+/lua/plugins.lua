-----  Plugins  ------


vim.pack.add({
  -- comment lines and blocks
  { src = "https://github.com/numToStr/Comment.nvim" },

  -- Detect tabstop and shiftwidth automatically
  { src = "https://github.com/tpope/vim-sleuth" },

  -- Color Themes
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  -- { src = "https://github.com/navarasu/onedark.nvim" },

  -- Status line
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  -- Fuzzy finder
  -- { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- option dependency for fzf-lua
  { src = "https://github.com/ibhagwan/fzf-lua" }
})


-----  Plugins configs  ------

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

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", {desc = "[F]uzzy [f]ind files in cwd" })
vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", {desc = "[F]uzzy find [s]tring in cwd" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>", { desc = "[F]uzzy find string under [c]ursor in cwd" })
vim.keymap.set('n', '<leader>fb', "<cmd>FzfLua buffers<cr>", { desc = "[F]uzzy find existing [b]uffers" })
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "[F]uzzy find LSP [d]ocument symbols" })
-- vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<cr>", {desc = "fuzzy find by using ripgrep in project directory" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua lgrep_curbuf<cr>", {desc = "[f]ind (grep) in [c]urrent buffer" })
