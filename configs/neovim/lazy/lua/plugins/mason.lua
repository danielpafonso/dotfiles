return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local lspconfig = require("mason-lspconfig")
    local installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })

    lspconfig.setup({
      -- list of language servers to install
      ensure_installed = {
        --[[
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        --]]
        -- "lua_ls"
        "terraformls",
        "gopls",
        "pyright",
      },
    })
    
    installer.setup({
      ensure_installed = {
        -- formatters
        "prettier", -- prettier formatter
        "isort", -- python formatter
        "black", -- python formatter
        -- Linters
        "pylint",
      },
    })
  end
}
