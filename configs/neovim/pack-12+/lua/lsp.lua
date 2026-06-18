vim.lsp.config("clangd", {
    cmd = { "clangd-20" },
    filetypes = { "c", "h" },
    root_markers = {
        ".clangd",
    },
})

vim.lsp.enable("clangd")
