require ('usermod.liparadise_lib')

vim.lsp.config('clangd', {
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    on_attach = on_attach,
})
vim.lsp.enable('clangd')
