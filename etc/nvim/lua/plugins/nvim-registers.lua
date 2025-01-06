return {
    {
        "tversteeg/registers.nvim",
        config = function()
            require('registers').setup {
                system_clipboard = true,
                trim_whitespace = true,
                window = {
                    border = "double",
                    transparency = 0,
                }
            }
        end,
    },
}
