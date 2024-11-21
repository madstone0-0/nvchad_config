local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities
local on_init = configs.on_init
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
        -- cs.textDocument.semanticHighlightingCapabilities.semanticHighlighting = false
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
        local jdtls = require "jdtls"
        jdtls.setup.add_commands()
        jdtls.setup_dap { hotcodereplace = "auto" }
        jdtls.dap.setup_dap_main_class_configs()
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
    -- "cmake",
    "neocmake",
    "svelte",
    "zls",
    -- "sqlls",
    "lemminx",
    "asm_lsp",
    "intelephense",
}

local lspconfig = require "lspconfig"

-- lspconfig.java_language_server.setup {
--   on_attach = on_attach,
--   capabilities = user_capabilities "java_language_server",
--   root = lspconfig.util.root_pattern("pom.xml", "gradle.build", "*.iml"),
--   cmd = { "java-language-server" },
-- }

-- lspconfig.rust_analyzer.setup {
--     on_attach = on_attach,
--     capabilities = user_capabilities "rust",
--     settings = {
--         ["rust-analyzer"] = {
--             cargo = {
--                 loadOutDirsFromCheck = true,
--                 allFeatures = true,
--             },
--             procMacro = {
--                 enable = true,
--             },
--         },
--     },
-- }

lspconfig.hls.setup {
    on_attach = on_attach,
    capabilities = user_capabilities "hls",
    settings = {
        haskell = {
            formattingProvider = "fourmolu",
        },
    },
}

lspconfig.r_language_server.setup {
    on_attach = on_attach,
    capabilities = user_capabilities "r",
    root_dir = lspconfig.util.root_pattern("DESCRIPTION", "DESCRIPTION.in", "R", ".git", ".lintr"),
}

-- lspconfig.jdtls.setup {
--     on_attach = user_attach,
--     capabilities = user_capabilities "jdtls",
-- }

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = user_capabilities "eslint",
    packageManager = "yarn",
}

-- lspconfig.denols.setup {
--     on_attach = on_attach,
--     capabilities = user_capabilities "denols",
--     root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- }

lspconfig.ts_ls.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern "package.json",
    single_file_support = true,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

lspconfig.cssls.setup {
    on_attach = on_attach,
    capabilities = user_capabilities "cssls",
}

-- lspconfig.ltex.setup {
--     on_attach = on_attach,
--     capabilities = user_capabilities "",
--     settings = {
--         ltex = {
--             language = "en-GB",
--         },
--     },
-- }

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

lspconfig.arduino_language_server.setup {
    on_attach = on_attach,
    -- capabilities = user_capabilities "arduino_language_server",
    cmd = {
        "arduino-language-server",
        "-cli-config='" .. vim.fn.getcwd() .. "/sketch.yml'",
        -- "-cli",
        -- "/home/mads/Downloads/Compressed/arduino-ide_2.3.2_Linux_64bit/",
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

lspconfig.ruff.setup {
    on_attach = user_attach,
    capabilities = user_capabilities "ruff",
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
        on_init = on_init,
        on_attach = on_attach,
        capabilities = user_capabilities(lsp),
    }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
})
vim.diagnostic.config { virtual_text = false, virtual_lines = { only_current_line = true } }
