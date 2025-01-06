return {
    {
        "glepnir/dashboard-nvim",
        config = function()
            local db = require('dashboard')

            local ver = vim.version()
            local ver_str = "[ version : v"..ver.major.."."..ver.minor.."."..ver.patch.." ]"
            db.custom_header = {
                '',
                '',
                '',
                '',
                '',
                '',
                ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
                ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
                ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
                ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
                ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
                ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
                '',
                '                 ' .. ver_str .. '                 ',
            }

            db.custom_center = {
                {
                    icon = '  ',
                    desc = 'Load recently latest session             ',
                    shortcut = ',sa',
                    action ='SessionManager load_last_session'
                },
                {
                    icon = '  ',
                    desc = 'Select and load session                  ',
                    action =  'SessionManager load_session',
                    shortcut = ',sl'
                },
                {
                    icon = '  ',
                    desc = 'Select and delete session                ',
                    action =  'SessionManager delete_session',
                    shortcut = ',sd'
                },
            }

            db.center_pad = 3
        end,
    },
}
