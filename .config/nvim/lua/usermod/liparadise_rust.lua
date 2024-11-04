--[[
-- LSP (rust-analyzer), treesitter, and hrsh7th nvim-cmp
--]]

require ('usermod.liparadise_lib')

local hrsh7th = require('cmp')
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
local capabilities = prequire('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = prequire('lspconfig')
-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
prequire('nvim-treesitter.configs', {
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
})

