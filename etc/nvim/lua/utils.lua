local M = {}

function M.has_gui()
    return os.getenv('NVIM_GUI') == '1';
end

function M.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function M.buf_only()
    local del_non_modifiable = false
    local cur = vim.api.nvim_get_current_buf()
    local deleted, modified = 0, 0
    for _, n in ipairs(vim.api.nvim_list_bufs()) do
        -- If the iter buffer is modified one, then don't do anything
        if vim.api.nvim_buf_get_option(n, "modified") then
            -- iter is not equal to current buffer
            -- iter is modifiable or del_non_modifiable == true
            -- `modifiable` check is needed as it will prevent closing file tree ie. NERD_tree
            modified = modified + 1
        elseif n ~= cur and (vim.api.nvim_buf_get_option(n, "modifiable") or del_non_modifiable) then
            vim.api.nvim_buf_delete(n, {})
            deleted = deleted + 1
        end
    end
    print("BufOnly: " .. deleted .. " deleted buffers, " .. modified .. " modified buffers")
end

return M
