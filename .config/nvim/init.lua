--[[
-- General Settings
--]]

vim.g.mapleader = " "
local nvim_set_keymap = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }
nvim_set_keymap('n', '<leader>n', ':noh<CR>', opts)
nvim_set_keymap('n', '<leader>N', ':set nu!<CR>', opts)
nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)
nvim_set_keymap('n', '<leader>r', ':LspRestart<CR>', opts)
nvim_set_keymap('n', '<C-Up>', '', opts)
nvim_set_keymap('n', '<C-Down>', '', opts)
nvim_set_keymap('i', '', '<C-w>', opts)
nvim_set_keymap('c', '', '<C-w>', opts)
nvim_set_keymap('c', 'Q', 'tabc', opts)
nvim_set_keymap('n', 'Q', ':tabc<CR>', opts)

vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
vim.opt.wildignore:append { "*.pyc", "node_modules" }

nvim_set_keymap = nil

local nvim_set = vim.opt
nvim_set.number = true
nvim_set.autoindent = true
nvim_set.expandtab = true
nvim_set.tabstop = 4
nvim_set.shiftwidth = 4
nvim_set.history = 10000
nvim_set.cursorline = true
nvim_set.laststatus = 2
nvim_set.ignorecase = true
nvim_set.smartcase = true
nvim_set.showcmd = true
nvim_set.termguicolors = true
nvim_set.backspace = {'indent', 'eol', 'start'}
nvim_set.encoding = 'utf-8'
nvim_set.fileencodings = {'utf-8'}
nvim_set.compatible = false
nvim_set.ttimeoutlen = 5
nvim_set.mouse = 'a'
nvim_set.undodir = '~/.vim/.undo//'
nvim_set.backupdir = '~/.vim/.backup//'
nvim_set.directory = '~/.vim/.swp//'
nvim_set.syntax = on
nvim_set.statusline:append('%<%F\\ %h%m%r%=%-16.(%l,%c%V%)\\ %P')
if vim.fn.has('termguicolors') == 1 then
    nvim_set.termguicolors = true
end
nvim_set = nil

-- remove scratch window upon completion
vim.api.nvim_create_autocmd('CompleteDone', {
    pattern = '*',
    command = 'pclose',
})

--[[
-- vim-plug
--]]

local Plug = require('usermod.vimplug')
Plug.begin()

Plug 'neovim/nvim-lspconfig'
-- Plug ('nvim-treesitter/nvim-treesitter', {do = ':TSUpdate'})
Plug 'Yggdroot/indentLine'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox'
Plug 'webdevel/tabulous'
if vim.fn.has('nvim-0.8') then
    Plug 'rebelot/kanagawa.nvim'
else
    -- https://github.com/rebelot/kanagawa.nvim/issues/79#issuecomment-1285054740
    Plug ('rebelot/kanagawa.nvim', {commit = 'fc2e308'})
end
-- Plug 'sonph/onehalf', { 'rtp': 'vim' }

--[[
Plug('junegunn/goyo.vim', {ft = 'markdown'})
Plug('echasnovski/mini.comment', {
    config = function()
        require('mini.comment').setup()
    end
})
--]]

Plug.ends()
Plug = nil

--[[
-- Apply colorscheme from plugins
--]]
if not vim.opt.diff:get() then
    if vim.fn.has('nvim-0.5') == 1 then
        vim.cmd('luafile ~/.config/nvim/plugins/liparadise_colors/Colorscheme_Kanagawa.lua')
        -- runtime plugins/liparadise_colors/Colorscheme_Everforest.vim
    else
        vim.cmd('runtime plugins/liparadise_colors/Colorscheme_Gruvbox.vim')
    end
end

--[[
-- LSP: rust-analyzer
--]]

local nvim_lsp = require('lspconfig')

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end,

    flags = {
        debounce_text_changes = 150,
    },

    settings = {
        ['rust-analyzer'] = {
            check = {
                allTargets = {}
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
