local lint = require "lint"
local M = {}

function M.setup()
  local mypy = lint.linters.mypy
  local eslint_d = lint.linters.eslint_d
  local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_DEFAULT_ENV" or "/usr"

  -- mypy.args = {
  --   "--show-column-numbers",
  --   "--show-error-end",
  --   "--hide-error-codes",
  --   "--hide-error-context",
  --   "--no-color-output",
  --   "--no-error-summary",
  --   "--no-pretty",
  --   "--python-executable",
  --   virtual .. "/bin/python3",
  --   "-",
  -- }

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
    markdown = { "cspell" },

    python = { "ruff" },
    yaml = { "yamllint" },
  }
end

return M
