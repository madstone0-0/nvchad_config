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
end

local user_capabilities = function(name)
  local user_cap = capabilities
  if name == "cssls" then
    user_cap.textDocument.completion.completionItem.snippetSupport = true
  end
  user_cap.offsetEncoding = "utf-16"
  user_cap.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return user_cap
end

-- local servers = { "html", "cssls", "tsserver", "eslint", "pylsp", "bashls", "sumneko_lua", "jsonls", "yamlls" }
local servers = {
  "html",
  "tsserver",
  "jsonls",
  "yamlls",
  "marksman",
  "texlab",
  "cmake",
}

-- Neodev Setup
require("neodev").setup {
  library = {
    plugins = { "dap", "nvim-dap-ui", "neotest", "nvim-treesitter", "plenary.nvim", "telescope.nvim", "lazy.nvim" },
  },
}

local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "cssls",
}

lspconfig.grammarly.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "",
  init_options = {
    clientId = "client_S7ht7UbDxdnrnQ8cs269cG",
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "bashls",
  single_file_support = true,
}

-- lspconfig.ccls.setup {
--   on_attach = user_attach,
--   capabilities = user_capabilities "ccls",
--   init_options = {
--     highlight = {
--       lsRanges = true,
--     },
--   },
-- }

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "clangd",
}

lspconfig.ruff_lsp.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "",
  init_options = {
    settings = {
      args = { "--line-length 120", "--extend-select I", "--extend-select PL" },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "",
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
  capabilities = user_capabilities "",
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
    capabilities = user_capabilities(lsp),
  }
end

vim.diagnostic.config { virtual_text = false, virtual_lines = { only_current_line = true } }
