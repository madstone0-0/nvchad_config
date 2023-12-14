local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"
-- local navic = require "nvim-navic"
-- capabilities.offsetEncoding = "utf-8"

local user_attach = function(client, bufnr)
  local cs = client.server_capabilities
  cs.documentFormattingProvider = false
  cs.documentRangeFormattingProvider = false

  -- Python

  if client.name == "ruff_lsp" then
    cs.hoverProvider = false
  end

  if client.name == "pyright" then
    cs.renameProvider = false
    cs.signatureHelp = false
    cs.signatureProvider = false
    cs.signatureHelpProvider = {}
    cs.completionProvider.resolveProvider = true
  end

  if client.name == "pylsp" then
    cs.completionProvider.resolveProvider = false
    cs.signatureHelp = true
  end

  -- Python

  -- C++

  if client.name == "clangd" then
    cs.hoverProvider = true
    cs.renameProvider = true
    cs.documentHighlightProvider = false
    cs.completionProvider.resolveProvider = false
    -- cs.completionProvider.triggerCharacters = {}
    -- cs.completionProvider.triggerCharacters = { ".", "<", ">", ":", '"', "/", "*" }
    cs.implementationProvider = true
    cs.signatureProvider = true
    cs.textDocument.semanticHighlightingCapabilities.semanticHighlighting = false
  end

  if client.name == "ccls" then
    cs.hoverProvider = false
    cs.documentHighlightProvider = false
    cs.renameProvider = false
    cs.completionProvider.resolveProvider = true
    cs.implementationProvider = false
    cs.signatureProvider = false
  end
  -- C++
  client.server_capabilities = cs

  -- Java
  if client.name == "jdtls" then
    require("jdtls").setup_dap { hotcodereplace = "auto" }
  end
  -- Java

  on_attach(client, bufnr)
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
  "jsonls",
  "marksman",
  "texlab",
  "cmake",
  "svelte",
  "hls",
  "zls",
  "sqlls",
  "lemminx",
}

local lspconfig = require "lspconfig"

-- lspconfig.java_language_server.setup {
--   on_attach = on_attach,
--   capabilities = user_capabilities "java_language_server",
--   root = lspconfig.util.root_pattern("pom.xml", "gradle.build", "*.iml"),
--   cmd = { "java-language-server" },
-- }

lspconfig.jdtls.setup {
  on_attach = user_attach,
  capabilities = user_capabilities "jdtls",
  init_options = {
    bundles = {
      vim.fn.glob "/home/mads/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
    },
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.RETURNS_DEEP_STUBS",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk/",
          },
        },
      },
    },
  },
}

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

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "eslint",
  packageManager = "yarn",
}

lspconfig.denols.setup {
  on_attach = on_attach,
  capabilities = user_capabilities "denols",
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
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
      comments = 2,
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
    "--clang-tidy",
    "--inlay-hints",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=bundled",
    "--folding-ranges",
    "--header-insertion=iwyu",
    "--ranking-model=decision_forest",
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
      interpreter = string.gsub(vim.fn.system "pyenv which python3", "\n", ""),
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
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
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
          maxLineLength = 120,
        },
        pyflakes = {
          enabled = false,
        },
      },
    },
  },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = user_capabilities(lsp),
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = true,
})
vim.diagnostic.config { virtual_text = false, virtual_lines = { only_current_line = true } }
