require("bufferline").setup {
    options = {
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        right_mouse_command = "bp|bd#",
        offsets = {
            {
                filetype = "NvimTree",
                text = vim.fn.getcwd,
                highlight = "Directory",
                text_align = "left",
                separator = false, -- use a "true" to enable the default, or set your own character
            }
        },
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "dap-repl" then
                return true
            end
        end
    }
}
