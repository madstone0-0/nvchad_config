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
    cs.hoverProvider = false
  end

  if client.name == "pyright" then
    cs.renameProvider = false
    cs.signatureHelp = false
  end

  if client.name == "clangd" then
    cs.hoverProvider = true
    -- cs.renameProvider = false
  end

  if client.name == "ccls" then
    cs.hoverProvider = false
    cs.renameProvider = false
  end

  -- if client.name == "pylsp" then
  --
  -- end
end

local user_capabilities = function(name)
  local user_cap = capabilities
  if name == "cssls" then
    user_cap.textDocument.completion.completionItem.snippetSupport = true
  end

  -- user_cap.offsetEncoding = "utf-16"
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

lspconfig.ccls.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "ccls",
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  init_options = {
    highlight = {
      lsRanges = true,
    },
    compilationDatabaseDirectory = "build",
    index = {
      threads = 4,
    },
    -- clang = {
    --   includeArgs = { "-I .src/_includes" },
    -- },
  },
}

lspconfig.clangd.setup {
  on_attach = user_attach,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "-j=8",
    "--inlay-hints",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
  },
  capabilities = user_capabilities "clangd",
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

lspconfig.ruff_lsp.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "ruff_lsp",
  init_options = {
    settings = {
      args = { "--line-length 120", "--extend-select I", "--extend-select PL" },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "pyright",
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
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
  capabilities = user_capabilities "pylsp",
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

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = false,
--   virtual_lines = { only_current_line = true },
-- })
vim.diagnostic.config { virtual_text = false, virtual_lines = { only_current_line = true } }
