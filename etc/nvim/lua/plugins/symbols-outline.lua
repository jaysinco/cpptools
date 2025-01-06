return {
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require('symbols-outline').setup {
                highlight_hovered_item = false,
                auto_preview = false,
                autofold_depth = 1,
                auto_unfold_hover = false,
            }
        end,
    },
}
