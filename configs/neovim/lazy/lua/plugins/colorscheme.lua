return {
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup{
        style = "warm"
      }
      vim.cmd.colorscheme "onedark"
    end,
  },
  {
    "catppuccin/nvim",
    -- config = function()
    --   vim.cmd.colorscheme "catppuccin-macchiato"
    -- end,
  },
}