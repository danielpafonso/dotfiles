vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (PackAdd user/repo)", })

--:packupdate :packupdate! :packdel :packdel! now supported in 0.13 nightly as of May 17
-- NOTE: pack delete
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)", })

-- NOTE: pack update
vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if opts.args ~= "" then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
        vim.pack.update(plugins)
    else
        -- update all
        vim.pack.update()
    end
end, { desc = "Update all plugins or specific ones", nargs = "*", })

-- NOTE: pack nonactive - show all non active plugins on disk but removed from pack.lua
vim.api.nvim_create_user_command("PackCheck", function()
    local non_active = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable()

    vim.print("Non-active plugins :")
    print(" ")
    for _, name in ipairs(non_active) do
        print(name)
    end
    print(" ")

end, { desc = "List non active plugins and select to delete"})
