return {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    opts = {
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
      },
    }
}
