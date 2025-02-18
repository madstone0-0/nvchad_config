local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities
local on_init = configs.on_init
local lspconfig = require "lspconfig"
-- local navic = require "nvim-navic"
-- capabilities.offsetEncoding = "utf-8"

-- Language server configuration presets grouped by language
local lsp_configs = {
    --[[ Python LSPs ]]
    --
    ruff_lsp = {
        hoverProvider = false,
    },
    pyright = {
        renameProvider = true,
        signatureHelp = true,
        signatureProvider = true,
        -- signatureHelpProvider = {},
        completionProvider = {
            resolveProvider = true,
        },
    },
    pylsp = {
        completionProvider = {
            resolveProvider = false,
        },
        signatureHelp = true,
    },

    --[[ C/C++ LSPs ]]
    --
    clangd = {
        hoverProvider = true,
        renameProvider = true,
        documentHighlightProvider = false,
        completionProvider = {
            resolveProvider = false,
            -- Uncomment to customize trigger characters
            -- triggerCharacters = { ".", "<", ">", ":", '"', "/", "*" }
        },
        implementationProvider = true,
        signatureProvider = true,
        -- Uncomment to disable semantic highlighting
        -- textDocument = {
        --     semanticHighlightingCapabilities = {
        --         semanticHighlighting = false
        --     }
        -- }
    },
    ccls = {
        hoverProvider = false,
        documentHighlightProvider = false,
        renameProvider = false,
        completionProvider = {
            resolveProvider = true,
        },
        implementationProvider = false,
        signatureProvider = false,
    },

    --[[ PHP LSPs ]]
    --
    intelephense = {
        hoverProvider = true,
        documentHighlightProvider = true,
        renameProvider = false,
        completionProvider = {
            resolveProvider = true,
        },
        implementationProvider = true,
        signatureProvider = true,
    },
    phpactor = {
        hoverProvider = false,
        documentHighlightProvider = false,
        renameProvider = true,
        completionProvider = {
            resolveProvider = false,
        },
        implementationProvider = false,
        signatureProvider = false,
    },
}

-- Special setup functions for specific LSPs
local special_setups = {
    --[[ Java LSP ]]
    --
    jdtls = function()
        local jdtls = require "jdtls"
        jdtls.setup.add_commands()
        jdtls.setup_dap { hotcodereplace = "auto" }
        jdtls.dap.setup_dap_main_class_configs()
    end,
}

---@param client table LSP client instance
---@param bufnr number Buffer number
local user_attach = function(client, bufnr)
    -- Disable formatting by default for all clients
    local cs = client.server_capabilities
    cs.documentFormattingProvider = false
    cs.documentRangeFormattingProvider = false

    -- Apply server-specific configurations
    if lsp_configs[client.name] then
        for key, value in pairs(lsp_configs[client.name]) do
            if type(value) == "table" then
                cs[key] = vim.tbl_extend("force", cs[key] or {}, value)
            else
                cs[key] = value
            end
        end
    end

    -- Update server capabilities
    client.server_capabilities = cs

    -- Run special setup if exists
    if special_setups[client.name] then
        special_setups[client.name]()
    end

    -- Call the original on_attach if it exists
    if on_attach then
        on_attach(client, bufnr)
    end
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
    -- Latex
    marksman = {},
    texlab = {},
    -- ltex = {
    --     settings = {
    --         ltex = {
    --             language = "en-GB",
    --         },
    --     },
    -- },

    -- Cpp / C
    -- "cmake",
    neocmake = {},
    ccls = {
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
    },

    clangd = {
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
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        },
    },

    -- Arduino
    arduino_language_server = {
        cmd = {
            "arduino-language-server",
            "-cli-config='" .. vim.fn.getcwd() .. "/sketch.yml'",
            -- "-cli",
            -- "/home/mads/Downloads/Compressed/arduino-ide_2.3.2_Linux_64bit/",
        },
    },

    -- VHDL
    vhdl_ls = {},

    -- Web
    svelte = {},
    html = {},
    jsonls = {},
    eslint = {},
    denols = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    },
    -- ts_ls = {
    --     root_dir = lspconfig.util.root_pattern "package.json",
    --     single_file_support = true,
    --     filetypes = {
    --         "javascript",
    --         "javascriptreact",
    --         "javascript.jsx",
    --         "typescript",
    --         "typescriptreact",
    --         "typescript.tsx",
    --     },
    -- },
    cssls = {},
    tailwindcss = {},

    -- Zig
    zls = {},

    -- SQL
    -- "sqlls",
    lemminx = {},

    -- ASM
    asm_lsp = {},

    -- PHP
    intelephense = {},
    phpactor = {},

    -- Rust
    -- rust_analyzer = {
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
    -- },

    -- Haskell
    hls = {
        settings = {
            haskell = {
                formattingProvider = "fourmolu",
            },
        },
    },

    -- R
    r_language_server = {
        root_dir = lspconfig.util.root_pattern("DESCRIPTION", "DESCRIPTION.in", "R", ".git", ".lintr"),
    },

    -- Lua
    lua_ls = {
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
    },

    -- Bash
    bashls = {
        single_file_support = true,
    },

    -- Python
    ruff = {
        init_options = {
            settings = {
                args = { "--line-length 120", "--extend-select I", "--extend-select PL" },
                interpreter = string.gsub(vim.fn.system "pyenv which python3", "\n", ""),
            },
        },
    },

    pyright = {
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
    },

    -- pylsp = {
    --     settings = {
    --         pylsp = {
    --             plugins = {
    --                 pycodestyle = {
    --                     enabled = false,
    --                     maxLineLength = 120,
    --                 },
    --                 pyflakes = {
    --                     enabled = false,
    --                 },
    --             },
    --         },
    --     },
    -- },

    -- Go
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            },
        },
    },
}

for lsp, opts in pairs(servers) do
    opts.on_init = on_init
    opts.on_attach = user_attach
    opts.capabilities = user_capabilities(lsp)
    lspconfig[lsp].setup(opts)
end

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false,
})

vim.g.virtual_lines = true

vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = vim.g.virtual_lines,
    update_in_insert = true,
}
