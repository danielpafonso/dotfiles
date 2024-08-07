return {
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
    }
}