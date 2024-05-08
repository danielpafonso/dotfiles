return {
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1001,
    config = function()
      require("onedark").setup{
        style = "warm"
      }
      vim.cmd.colorscheme "onedark"
    end,
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
      },
      inactive_sections = {
        lualine_a = {"filename"},
        lualine_c = {"filesize"},
        lualine_x = {},
      },
    },
  },
  {
    "catppuccin/nvim",
    -- config = function()
    --   vim.cmd.colorscheme "catppuccin-macchiato"
    -- end,
  },
}