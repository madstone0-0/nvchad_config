local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"
-- capabilities.offsetEncoding = "utf-8"

local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls", "tsserver", "eslint", "pylsp", "bashls", "sumneko_lua", "jsonls", "yamlls" }
local servers = {
  "html",
  "cssls",
  "tsserver",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
  "texlab",
  "lua_ls",
  "grammarly",
  "cmake",
}

-- Neodev Setup
require("neodev").setup()

lspconfig.ccls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  offset_encoding = "utf-8",
  init_options = {
    highlight = {
      lsRanges = true,
    },
  },
}

local user_attach = function(client, bufnr)
  local sc = client.server_capabilities
  sc.documentFormattingProvider = false
  sc.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if client.name == "ruff_lsp" then
    sc.hover = false
  end

  if client.name == "pyright" then
    sc.rename = false
    sc.signatureHelp = false
  end
end

lspconfig.ruff_lsp.setup {
  on_attach = user_attach,
  capabilities = capabilities,
  init_options = {
    settings = {
      args = { "--line-length 120", "--extend-select I", "--extend-select PL" },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = user_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = "none",
          reportOptionalMemberAccess = "none",
          reportOptionalSubscript = "none",
          reportPrivateImportUsage = "none",
        },
      },

      linting = { pylintEnabled = false },
    },
  },
}

lspconfig.pylsp.setup {
  on_attach = user_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = false,
        },
      },
    },
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
