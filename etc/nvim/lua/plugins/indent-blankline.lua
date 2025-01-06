return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup {
                show_current_context = true,
                show_current_context_start = false,
                filetype_exclude = {
                    "dashboard"
                },
            }

        end,
    },
}
