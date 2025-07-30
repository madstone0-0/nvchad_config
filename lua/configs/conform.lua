local M = {}
local conform = require "conform"

function M.setup()
    local slow_format_filetypes = {
        "lua",
        "html",
        "python",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "sh",
        "yaml",
        "markdown",
        "latex",
        "cpp",
        "zig",
        "go",
    }

    conform.setup {

        format_on_save = function(bufnr)
            if slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end
            local function on_format(err)
                if err and err:match "timeout$" then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
            end

            return { timeout_ms = 2000, lsp_fallback = true }, on_format
        end,

        format_after_save = function(bufnr)
            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end
            return { lsp_fallback = true }
        end,

        formatters = {
            clang_format = {
                prepend_args = { "--style=file" },
            },
            yamlfmt = {
                prepend_args = { "-global_conf" },
            },
        },

        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format", "ruff_fix" },
            go = { "gofmt" },
            haskell = { "fourmolu" },

            json = { "biome" },
            jsonc = { "biome" },
            javascript = { "biome" },
            typescript = { "biome" },
            typescriptreact = { "biome", "rustywind" },
            javascriptreact = { "biome", "rustywind" },
            sh = { "shfmt" },

            r = { "styler" },
            rust = { "rustfmt" },

            yaml = { "yamlfmt" },
            markdown = { "cbfmt", "codespell" },
            tex = { "latexindent" },

            cpp = { "clang_format" },
            c = { "clang_format" },
            cmake = { "gersemi" },
            -- vhdl = { "vsg" },

            proto = { "buf" },

            zig = { "zigfmt" },
        },
    }
end

return M
