local M = {}

-- local rainbow = require "ts-rainbow"

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
  },
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = { "latex", "markdown" },
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = "rainbow-parens",
    -- Highlight the entire buffer all at once
    -- strategy = rainbow.strategy.global,
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

M.luasnip = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

M.telescope = {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = { "node_modules", ".git", "venv" },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },

    extensions_list = { "frecency", "fzf", "themes", "terms" },
  },
}

require("telescope").setup {
  extensions = {
    frecency = {
      ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*/venv/*" },
    },
  },
}

M.cmp = {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    -- { name = "rg",      keyword_length = 3 },
    { name = "path" },
    { name = "git" },
  },
}

M.color = {
  user_default_options = {
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    mode = "background", -- Set the display mode.
    -- parsers can contain values used in |user_default_options|
  },
}

-- M.icons = {
--   override = {
--     zsh = {
--       icon = "",
--       color = "#428840",
--       cterm_color = "65",
--       name = "Zsh",
--     },
--   },
--   override_by_filename = {
--     ["Dockerfile"] = {
--       icon = "",
--       name = "Dockerfile",
--     },
--   },
-- }

return M
