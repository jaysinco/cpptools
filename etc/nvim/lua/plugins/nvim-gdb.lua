vim.g.nvimgdb_disable_start_keymaps = 1
vim.cmd [[
    function! NvimGdbNoKeymaps()
    endfunction

    let g:nvimgdb_config_override = {
        \ 'set_tkeymaps': "NvimGdbNoKeymaps",
        \ 'set_keymaps': "NvimGdbNoKeymaps",
        \ 'unset_keymaps': "NvimGdbNoKeymaps",
        \ }
]]
