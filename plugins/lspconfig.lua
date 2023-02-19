local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls", "tsserver", "eslint", "pylsp", "bashls", "sumneko_lua", "jsonls", "yamlls" }
local servers = {
  "html",
  "cssls",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
  "texlab",
  "lua_ls",
  "grammarly",
}

-- Neodev Setup
require("neodev").setup()

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
