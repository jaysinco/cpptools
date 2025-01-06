local groups = {
    nightfox = {
        DiffAdd = { bg = "#6f9a88", fg = "bg0" },
        DiffChange = { bg = "#bea86a", fg = "bg0" },
        DiffDelete = { bg = "#ac4863", fg = "bg0" },
        DiffText = { bg = "#ffcb19", fg = "bg0" },
    },
}

require("nightfox").setup {
    groups = groups
}

vim.o.background = 'dark'
vim.cmd [[colorscheme nightfox]]
