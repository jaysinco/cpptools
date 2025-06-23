require "nvchad.autocmds"

-- open nvim-tree on start
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- Check if Neovim was opened with a directory argument (e.g., `nvim .` or `nvim /path/to/dir`)
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 1 then
      -- Change the current directory to the provided directory
      vim.cmd("cd " .. vim.fn.fnameescape(arg))
      -- If nvim-tree is loaded, refresh or change its root
      local nvim_tree = require("nvim-tree.api")
      if nvim_tree then
        nvim_tree.tree.change_root(arg)
        vim.schedule(function()
          vim.cmd("%bwipeout")
          nvim_tree.tree.open({ focus = false })
          vim.cmd("wincmd l")
        end)
      end
    end
  end,
})

-- quickfix window shortcut
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR><C-w>p", { buffer = true, silent = true })
    vim.keymap.set("n", "o", "<CR><C-w>p", { buffer = true, silent = true })
  end,
})

-- auto format on save
local format_on_save = true

local function toggle_format_on_save()
  format_on_save = not format_on_save
  print("format on save:", format_on_save and "on" or "off")
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if format_on_save then
      require("conform").format({
        bufnr = args.buf,
        timeout_ms = 500,
        lsp_format = "fallback",
      })
    end
  end
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})

-- hide buffers from buffer list and tabs
vim.api.nvim_create_autocmd({ "BufNew", "BufWinEnter" }, {
  callback = function(args)
    local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")
    if buftype:match("nofile") then
      vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
    end
  end,
})
