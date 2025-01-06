return {
    {
        "nvimdev/dashboard-nvim",
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                config = {
                    theme = 'hyper',
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            icon = ' ',
                            desc = 'Load latest session',
                            key = ',sa',
                            action ='SessionManager load_last_session'
                        },
                        {
                            icon = ' ',
                            desc = 'Select and load session',
                            action =  'SessionManager load_session',
                            key = ',sl'
                        },
                        {
                            icon = ' ',
                            desc = 'Select and delete session',
                            action = 'SessionManager delete_session',
                            key = ',sd'
                        },
                    },
                    footer = {},
                },
            }
        end,
    },
}
