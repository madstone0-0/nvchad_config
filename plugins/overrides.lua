local M = {}

M.treesiter = {
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

M.telescope = function()
  return {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
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
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        },
      },
    },

    extensions_list = { "fzf", "themes", "terms" },
  }
end

return M
