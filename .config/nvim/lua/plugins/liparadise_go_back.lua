vim.api.nvim_create_user_command("MyGoBack", function (args)
    if nil ~= tonumber(args.args) then
        vim.cmd(':e +' .. args.args .. 'buf')
    else
        vim.cmd(':echo "Wrong usage! argv shall be a number from `:ls`"')
    end
end, { desc = "go back to certain buf by num", nargs = 1 })
