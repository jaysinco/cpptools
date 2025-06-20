require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', '<C-i>', '<C-i>', { noremap = true })  -- Force <C-i> to jump forward
map('n', '<C-o>', '<C-o>', { noremap = true })  -- Force <C-o> to jump backward

map('n', '<leader>X', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  require("nvim-tree.api").tree.open({ focus = false })
  vim.cmd("wincmd l")
end, { desc = "buffer only" })
