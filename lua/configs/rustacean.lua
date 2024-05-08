local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local M = {
    setup = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            loadOutDirsFromCheck = true,
                            allFeatures = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
        }
    end,
}

return M
