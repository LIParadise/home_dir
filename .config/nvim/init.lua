--[[
-- General Settings
--]]

vim.g.mapleader = " "
vim.g.editorconfig = false
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
nvim_set_keymap('c', 'Q', ':tabc<CR>', opts)
nvim_set_keymap('n', 'Q', ':tabc<CR>', opts)
nvim_set_keymap('n', '<leader>%"', [[:redir @" | echon getreg('%') | redir END<CR>]], opts)

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
nvim_set.undodir = vim.fn.expand '~/.vim/.undo//'
nvim_set.backupdir = vim.fn.expand '~/.vim/.backup//'
nvim_set.directory = vim.fn.expand '~/.vim/.swp//'
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
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug ('neanias/everforest-nvim', { branch = 'main' })
Plug 'morhetz/gruvbox'
-- Plug 'NLKNguyen/papercolor-theme'
Plug 'webdevel/tabulous'
if vim.fn.has('nvim-0.8') then
    Plug 'rebelot/kanagawa.nvim'
    Plug 'EdenEast/nightfox.nvim'
    Plug ('sainnhe/sonokai', {as = 'sonokai.nvim'})
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

require('usermod.liparadise_lib')

--[[
-- Apply colorscheme from plugins
--]]
if not vim.opt.diff:get() then
    if vim.fn.has('nvim-0.8') == 1 then
        -- vim.opt.background = 'light'
        -- vim.cmd.colorscheme('PaperColor')
        -- local groups = {
        --     nightfox = {
        --         NonText = { fg = "#ad86a3" },
        --     }
        -- }
        -- prequire('nightfox', { groups = groups })
        local everforest_options = {
            background = "hard",
            italics = true,
            disable_italic_comments = false,
            inlay_hints_background = "dimmed",
        }
        require("everforest").setup(everforest_options)
        vim.opt.background = 'light'
        vim.cmd.colorscheme('everforest')
    else
        vim.cmd.colorscheme('desert')
    end
    --[[
    if vim.fn.has('nvim-0.5') == 1 then
        vim.cmd('luafile ~/.config/nvim/plugins/liparadise_colors/Colorscheme_Kanagawa.lua')
        -- runtime plugins/liparadise_colors/Colorscheme_Everforest.vim
    else
        vim.cmd('runtime plugins/liparadise_colors/Colorscheme_Gruvbox.vim')
    end
    --]]
end

--[[
-- LSP: rust-analyzer
--]]

local liparadise_rust_analyzer = require('usermod.liparadise_rust')
local liparadise_go_pls = require('usermod.liparadise_go')
local liparadise_clangd = require('usermod.liparadise_clangd')
local liparadise_go_back = require('usermod.liparadise_go_back')

--[[
-- show identation lines
--]]
require("ibl").setup()

