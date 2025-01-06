return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require('nvim-tree').setup {
                open_on_setup = false,
                open_on_setup_file = false,
                hijack_netrw = true,
                view = {
                    side = 'left',
                    hide_root_folder = true,
                },
                git = {
                    enable = false,
                    ignore = false,
                },
            }
        end,
    },
}
