--[[
    Auto Completion
    https://gpanders.com/blog/whats-new-in-neovim-0-11/#lspa
    https://vi.stackexchange.com/questions/46749

    TODO:
    https://www.reddit.com/r/neovim/comments/1jkyrnw

    UNUSED:
    Using saghen/blink.cmp instead
--]]
--[[
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        local liparadise_lib = require('usermod.liparadise_lib')
        on_attach(client, ev.buf)
    end,
})
vim.cmd('set completeopt+=noselect,menuone,preview,fuzzy')
--]]

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end
        require('plugins/liparadise_key_maps')
        key_maps(client, ev.buf)
    end,
})
