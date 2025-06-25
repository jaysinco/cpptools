require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', '<C-i>', '<C-i>', { noremap = true })  -- force <C-i> to jump forward
map('n', '<C-o>', '<C-o>', { noremap = true })  -- force <C-o> to jump backward
map('x', 'y', 'ygv<Esc>', { noremap = true })   -- preserve cursor position
map('x', 'p', '"_dP', { noremap = true })       -- preserve yank register
map('n', 'q', '<Nop>', { noremap = true })      -- disable macro recording

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

map('n', '<leader>q', '<cmd>qa<CR>', { noremap = true, desc = "close all buffers" })
map('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
map('n', '<C-w>c', '<C-w>c<C-w>p', { noremap = true })
