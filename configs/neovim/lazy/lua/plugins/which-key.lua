return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- trigger after config loading and auto commands
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500 -- in milliseconds
  end,
  opts = {}
}
