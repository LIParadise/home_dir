--[[
-- LSP (rust-analyzer), treesitter, and hrsh7th nvim-cmp
--]]

local hrsh7th = require'cmp'
hrsh7th.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        -- completion = hrsh7th.config.window.bordered(),
        -- documentation = hrsh7th.config.window.bordered(),
    },
    mapping = hrsh7th.mapping.preset.insert({
        ['<C-b>'] = hrsh7th.mapping.scroll_docs(-4),
        ['<C-f>'] = hrsh7th.mapping.scroll_docs(4),
        ['<C-Space>'] = hrsh7th.mapping.complete(),
        ['<C-e>'] = hrsh7th.mapping.abort(),
        ['<CR>'] = hrsh7th.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-y>'] = hrsh7th.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = hrsh7th.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ hrsh7th.setup.filetype('gitcommit', {
    sources = hrsh7th.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
)
equire("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--[[
hrsh7th.setup.cmdline({ '/', '?' }, {
    mapping = hrsh7th.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
--]]

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--[[
hrsh7th.setup.cmdline(':', {
    mapping = hrsh7th.mapping.preset.cmdline(),
    sources = hrsh7th.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})
--]]

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require('lspconfig')
-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
        buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float({scope = "line"})<CR>', opts)
        buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<leader>F', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
    end,

    flags = {
        debounce_text_changes = 150,
    },

    settings = {
        ['rust-analyzer'] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
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

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "rust", "toml" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true }, 
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

