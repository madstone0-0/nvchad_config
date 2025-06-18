local lint = require "lint"
local M = {}

function M.setup()
    lint.linters_by_ft = {
        -- javascript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
        vue = {},
        css = {},
        scss = {},
        less = {},
        html = {},
        json = {},
        jsonc = {},
        graphql = {},
        handlebars = {},
        svelte = {},
        -- markdown = { "cspell" },

        python = { "ruff" },
        yaml = { "yamllint" },
        proto = { "buf_lint" },
    }
end

return M
