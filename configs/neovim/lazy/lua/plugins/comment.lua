return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("Comment").setup()
    end,
    --[[
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring"
    },
    config = function()
        local comment = require("Comment")
        local ts_context = require("nvim_context_commentstring.integration.comment_nvim")
        comment.setup({
            pre_hook = ts_context.create_pre_hook(),
        })
    end,
    --]]
}
