require("plugins")
require("configs")
require("keybinds")

-- build in undotree
vim.keymap.set("n", "<leader>ut", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, {desc = "Toogle [U]ndo[tree]"})
