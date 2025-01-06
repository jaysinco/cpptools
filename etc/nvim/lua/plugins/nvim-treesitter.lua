return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "c", "lua", "cpp", "javascript", "typescript", "python", "glsl" },
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
            -- vim.cmd [[
            --     set foldmethod=expr
            --     set foldexpr=nvim_treesitter#foldexpr()
            -- ]]
        end,
    },
}
