function prequire (module, args)
    local module_present, module = pcall(require, module)
    if module_present then
        if args then
            module.setup(args)
        end
        return module
    end
end
