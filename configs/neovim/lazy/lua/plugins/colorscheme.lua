return {
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
	name = "onedark.theme",
	-- uncomment for default
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
	name = "catppuccin.theme",
	--[[
    config = function()
      vim.cmd.colorscheme "catppuccin-macchiato"
    end,
	--]]
  },
}
