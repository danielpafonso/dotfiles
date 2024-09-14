return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  branch = "0.1.x",
  dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make"},
      -- "nvim-tree/nvim-web-devicons",
  },
  -- Only load if `make` is available. Make sure you have the system requirements installed.
  cond = function()
    return vim.fn.executable 'make' == 1
  end,

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
	local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    telescope.load_extension("fzf")

    -- set keymaps
    --vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]uzzy [f]ind files in cwd" })
	vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ hidden = true,  no_ignore = true }) end, { desc = "[F]uzzy [f]ind files in cwd" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]uzzy find [s]tring in cwd" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "[F]uzzy find string under [c]ursor in cwd" })
 
	vim.keymap.set("n", "<leader>ft", function()
		builtin.colorscheme({ enable_preview = true, ignore_builtins = true })
	end, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[F]uzzy find existing [b]uffers" })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

	require("which-key").add({
		{"<leader>f", group = "[F]uzzy finder"}
	})
  end,
}
