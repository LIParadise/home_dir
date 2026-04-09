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
nvim_set_keymap('n', 'Q', ':tabc<CR>', opts)
nvim_set_keymap('n', '<leader>%"', [[:redir @" | echon getreg('%') | redir END<CR>]], opts)

vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
vim.opt.wildignore:append { "*.pyc", "node_modules" }

nvim_set_keymap = nil

local nvim_set = vim.opt
nvim_set.number = false
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

if vim.fn.has('termguicolors') == 1 then
    nvim_set.termguicolors = true
end
nvim_set = nil

vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/lukas-reineke/indent-blankline.nvim',
    'https://github.com/neanias/everforest-nvim',
    'https://github.com/webdevel/tabulous',
    'https://github.com/ziglang/zig.vim',
    {
        src = 'https://github.com/saghen/blink.cmp',
        -- Version constraint, see |vim.version.range()|
        version = vim.version.range('1'),
    },
})

-- colorscheme
local everforest_options = {
    background = "hard",
    italics = true,
    disable_italic_comments = false,
    inlay_hints_background = "dimmed",
}
require("everforest").setup(everforest_options)
vim.opt.background = 'light'
vim.cmd.colorscheme('everforest')

vim.diagnostic.config({
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})

vim.o.winborder = 'rounded'
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')
vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('zls')

require('plugins/blink_cmp')
require('plugins/liparadise_go_back')
require('plugins/liparadise_lsp_attach')

--[[
-- show identation lines
--]]
require("ibl").setup()
