require ('usermod.liparadise_lib')
vim.lsp.config("gopls", {} --[[ {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gosum' },
    root_dir = vim.lsp.util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        }
    }
}--]]
)
vim.lsp.enable('gopls')
