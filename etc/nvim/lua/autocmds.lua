require "nvchad.autocmds"

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
        nvim_tree.tree.open()
      end
    end
  end,
})
