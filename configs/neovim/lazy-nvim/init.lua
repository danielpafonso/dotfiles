-- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.lazy")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

require("lazy").setup({
  --"navarasu/onedark.nvim",
  {
      -- Theme inspired by Atom
      'navarasu/onedark.nvim',
      priority = 1001,
      config = function()
        require('onedark').setup{
          style = 'warm'
        }
        vim.cmd.colorscheme 'onedark'
      end,
    },
  --"nvim-lualine/lualine.nvim",
  {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
      },
    },
})
