local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"
-- local navic = require "nvim-navic"
-- capabilities.offsetEncoding = "utf-8"

local user_attach = function(client, bufnr)
  local cs = client.server_capabilities
  cs.documentFormattingProvider = false
  cs.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if cs.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if client.name == "ruff_lsp" then
    cs.hover = false
  end

  if client.name == "pyright" then
    cs.rename = false
    cs.signatureHelp = false
  end

  -- if cs.documentSymbolProvider then
  --   navic.attach(client, bufnr)
  -- end
end

-- local servers = { "html", "cssls", "tsserver", "eslint", "pylsp", "bashls", "sumneko_lua", "jsonls", "yamlls" }
local servers = {
  "html",
  "cssls",
  "tsserver",
  "jsonls",
  "yamlls",
  "marksman",
  "texlab",
  "lua_ls",
  "cmake",
}

-- Neodev Setup
require("neodev").setup()

local lspconfig = require "lspconfig"

lspconfig.grammarly.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    clientId = "client_S7ht7UbDxdnrnQ8cs269cG",
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

lspconfig.ccls.setup {
  on_attach = user_attach,
  capabilities = capabilities,
  offset_encoding = "utf-8",
  init_options = {
    highlight = {
      lsRanges = true,
    },
  },
}

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
