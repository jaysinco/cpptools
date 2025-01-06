return {
    {
        "nvim-pack/nvim-spectre",
        config = function()
            require('spectre').setup {
                open_cmd = 'below new',
                highlight = {
                    ui = "String",
                    search = "DiffChange",
                    replace = "DiffDelete"
                },
            }
        end,
    },
}
