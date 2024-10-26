require('kanagawa').setup({
    compile = true,
    overrides = function(colors)
    -- symbols e.g.  is too dim by default
        return {
            NonText = { fg = "#6D846E" }
        }
    end,
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "dragon"
    },
})
vim.cmd("colorscheme kanagawa")
