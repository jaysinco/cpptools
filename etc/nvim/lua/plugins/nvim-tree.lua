return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require('nvim-tree').setup {
                hijack_netrw = true,
                view = {
                    side = 'left',
                },
                git = {
                    enable = false,
                    ignore = false,
                },
                renderer = {
                    root_folder_label = false,
                },
            }
        end,
    },
}
