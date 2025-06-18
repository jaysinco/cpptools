require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd", "pyright" }
vim.lsp.enable(servers)

vim.diagnostic.config {
  virtual_text = false, -- disable inline diagnostics
}

-- read :h vim.lsp.config for changing options of lsp servers
vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
    '--completion-style=detailed',
    '--function-arg-placeholders=0',
    '--header-insertion=never',
  },
}
