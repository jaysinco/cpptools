require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd" }
vim.lsp.enable(servers)

vim.diagnostic.config {
  virtual_text = false, -- disable inline diagnostics
}

-- read :h vim.lsp.config for changing options of lsp servers
