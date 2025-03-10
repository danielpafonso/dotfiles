local defaultTheme = "catppuccin"

return {
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    name = "theme.onedark",
    config = function()
      require("onedark").setup{
        style = "warm"
      }
      if defaultTheme == "onedark" then
	vim.cmd.colorscheme "onedark"
      end
    end,
  },
  {
    "catppuccin/nvim",
    name = "theme.catppuccin",
    config = function()
      if defaultTheme == "catppuccin" then
	vim.cmd.colorscheme "catppuccin-frappe"
      -- vim.cmd.colorscheme "catppuccin-macchiato"
      end
    end,
  },
  {
    "folke/tokyonight.nvim",
    name = "theme.tokyonight",
    config = function()
      if defaultTheme == "tokyonight" then
	vim.cmd.colorscheme "tokyonight-storm"
      end
    end
  }
}
