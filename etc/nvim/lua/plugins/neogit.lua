return {
    {
        "TimUntersberger/neogit",
        config = function()
            require('neogit').setup {
                disable_builtin_notifications = true,
                integrations = {
                    diffview = true,
                }
            }
        end,
    },
}
