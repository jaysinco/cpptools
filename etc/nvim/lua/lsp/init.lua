local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lsp_format = require('lsp-format')
lsp_format.setup {
    cpp = {
        sync = true,
    },
}

local on_attach = function(client, bufnr)
    lsp_format.on_attach(client, bufnr)
end

lspconfig['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--completion-style=detailed",
        "--function-arg-placeholders=0",
        "--header-insertion=never",
    },
}

-- lspconfig['pyright'].setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "openFilesOnly",
--                 typeCheckingMode = "off",
--                 useLibraryCodeForTypes = true
--             },
--         },
--     },
-- }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
