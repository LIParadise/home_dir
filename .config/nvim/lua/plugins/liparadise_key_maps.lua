--[[
--
-- default mappings as of neovim v0.11
-- grn in Normal mode maps to vim.lsp.buf.rename()
-- grr in Normal mode maps to vim.lsp.buf.references()
-- gri in Normal mode maps to vim.lsp.buf.implementation()
-- gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
-- gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
-- CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
--
-- [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)
-- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
-- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
-- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
-- [a, ]a, [A, ]A navigate through the argument list
-- [b, ]b, [B, ]B navigate through the buffer list
-- [<Space>, ]<Space> add an empty line above and below the cursor
--]]
function key_maps (client, bufnr)
    -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- local function lsp_buf_code_action_quick_fix()
    --     vim.lsp.buf.code_action({
    --         filter = function(x) return x.isPreferred end,
    --         apply  = true
    --     })
    -- end
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set(
        'n',
        '<leader>d',
        function()
            vim.diagnostic.open_float({scope = "line"})
        end
    )
    vim.keymap.set(
        'n',
        '<leader>v',
        function()
            local new_config = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config({ virtual_lines = new_config })
            print(string.format("virtual_lines set to %s", new_config))
        end,
        { desc = 'Toggle diagnostic virtual_lines' }
    )
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
    vim.keymap.set(
        'n',
        '<leader>wl',
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
    )
    -- buf_set_keymap('n', '<leader>ll', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- https://stackoverflow.com/questions/67988374
    -- buf_set_keymap('n', '<leader>qf', '<Cmd>lua vim.lsp.buf.code_action({ filter = function(a) return a.isPreferred end, apply = true })<CR>', opts)
end
