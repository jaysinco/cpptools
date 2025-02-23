return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup {
                exclude = {
                    filetypes = {
                      'lspinfo',
                      'packer',
                      'checkhealth',
                      'help',
                      'man',
                      'dashboard',
                      '',
                    },
                },
            }
        end,
    },
}
