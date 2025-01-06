local telescopeConfig = require("telescope.config")
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

require("telescope").setup {
    defaults = {
        vimgrep_arguments = vimgrep_arguments,
        scroll_strategy = "limit",
    },
    pickers = {
        live_grep = {
            theme = "ivy",
        },
        find_files = {
            theme = "ivy",
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        }
    },
}
