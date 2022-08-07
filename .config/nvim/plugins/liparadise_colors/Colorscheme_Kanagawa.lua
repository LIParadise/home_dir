local overrides = {
    -- symbols e.g.  is too dim by default
    NonText = { fg = "#6D846E" }
}
require'kanagawa'.setup({ overrides = overrides, colors = my_colors })
vim.cmd("colorscheme kanagawa")
