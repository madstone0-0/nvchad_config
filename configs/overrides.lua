local M = {}

M.treesiter = {
  ensure_installed = {
    "lua",
    "bash",
    "css",
    "javascript",
    "json",
    "html",
    "python",
    "yaml",
    "toml",
    "cpp",
    "markdown",
    "latex",
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = "rainbow-parens",
    -- Highlight the entire buffer all at once
    -- strategy = require "ts-rainbow.lib",
  },
  autotag = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",

    -- webdev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "eslint_d",
    "prettier",
    "json-lsp",

    -- shell
    "shfmt",
    "shellcheck",
    "bash-language-server",

    --python
    "black",
    "ruff",
    "python-lsp-server",
    "pyright",
    "ruff-lsp",
    "debugpy",

    -- markdown
    "remark-cli",
    "cbfmt",
    "cspell",
    "marksman",
    "grammarly-languageserver",

    -- latex
    "texlab",

    -- c++
    "clang-format",
    "cpptools",
  },
}

M.tree = {
  filters = {
    -- exclude = { vim.fn.stdpath "config" },
    custom = { "^.git$", "^node_modules$", "^venv$", "^__pycache__$" },
  },
  git = {
    enable = false,
  },

  trash = {
    cmd = "del",
  },

  view = {
    hide_root_folder = false,
  },

  renderer = {
    -- highlight_git = true,
    root_folder_label = false,

    icons = {
      show = {
        git = true,
      },
    },

    special_files = {
      "README.md",
      "readme.md",
      "package.json",
      "yarn.lock",
      "pyproject.toml",
      "poetry.lock",
      "ruff.toml",
    },
  },
}

M.blankline = {
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
  space_char_blankline = " ",
  -- char = "",
  -- char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  -- },
  -- space_char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  -- },
  -- show_trailing_blankline_indent = false,
}

M.ui = {
  statusline = {
    separator_style = "round",
    overriden_modules = function()
      return require "custom.status"
    end,
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    overriden_modules = nil,
  },
}

M.luasnip = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

M.telescope = {
  defaults = {
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },

    extensions_list = { "fzf", "themes", "terms" },
  },
}

return M
