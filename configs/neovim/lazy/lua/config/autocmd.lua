local api = vim.api -- for conciseness

-- Terminal
local terminal_group = api.nvim_create_augroup("neovim_termianl", { clear = true})

api.nvim_create_autocmd("TermOpen", {
  group = terminal_group,
  pattern = { "" },
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.cmd("startinsert")
  end,
})

api.nvim_create_autocmd("TabEnter", {
  group = terminal_group,
  pattern = { "" },
  callback = function()
    local buf = api.nvim_win_get_buf(0)
    if api.nvim_buf_get_option(buf, "buftype") == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})
