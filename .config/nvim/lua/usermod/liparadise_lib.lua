function on_attach (client, bufnr)
    -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	-- local function lsp_buf_code_action_quick_fix()
	-- 	vim.lsp.buf.code_action({
	-- 		filter = function(x) return x.isPreferred end,
	-- 		apply  = true
	-- 	})
	-- end
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>F', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float({scope = "line"})<CR>', opts)
    -- buf_set_keymap('n', '<leader>ll', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- https://stackoverflow.com/questions/67988374
    -- buf_set_keymap('n', '<leader>qf', '<Cmd>lua vim.lsp.buf.code_action({ filter = function(a) return a.isPreferred end, apply = true })<CR>', opts)
end
