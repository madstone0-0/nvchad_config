return {

  -- Overrides

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      matchup = {
        enable = true,
      },
    },
  },

  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- webdev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",

        -- shell
        "shfmt",
        "shellcheck",
        "bash-language-server",

        --python
        "black",
        "pylint",
        "python-lsp-server",
        "mypy",

        -- markdown
        "remark-cli",
        "markdownlint",
        "marksman",
      },
    },
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["nvim-tree/nvim-tree.lua"] = {
    override_options = {
      filters = {
        exclude = { vim.fn.stdpath "config" },
        custom = { vim.fn.getcwd() .. "/node_modules/" },
      },
      git = {
        enable = true,
      },

      trash = {
        cmd = "del",
      },

      renderer = {
        -- highlight_git = true,

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
        },
      },
    },
  },

  ["folke/which-key.nvim"] = {
    disable = false,
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["mfussenegger/nvim-dap"] = {
    disable = false,
    opt = true,
    event = "BufReadPre",
    module = { "dap" },
    requires = {
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require("custom.plugins.dap").setup()
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = {
      char = "",
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      show_trailing_blankline_indent = false,
    },
  },

  ["NvChad/ui"] = {
    override_options = {
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
    },
  },

  -- User Plugins

  ["wakatime/vim-wakatime"] = {},

  ["quangnguyen30192/cmp-nvim-ultisnips"] = {
    config = function()
      require("cmp_nvim_ultisnips").setup {}
    end,
  },

  ["junegunn/fzf"] = {
    run = ":call fzf#install()",
  },

  ["iamcco/markdown-preview.nvim"] = {
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  ["junegunn/fzf.vim"] = {},

  ["godlygeek/tabular"] = {},

  ["preservim/vim-markdown"] = {},

  ["sheerun/vim-polyglot"] = {},

  ["SirVer/ultisnips"] = {},

  ["honza/vim-snippets"] = {},

  ["lervag/vimtex"] = {},

  ["KeitaNakamura/tex-conceal.vim"] = {},

  ["github/copilot.vim"] = {},

  ["folke/neodev.nvim"] = {
    library = { plugins = { "nvim-dap-ui" }, types = true },
  },

  ["smjonas/snippet-converter.nvim"] = {
    config = function()
      local template = {
        sources = {
          ultisnips = {
            vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips/markdown.snippets",
          },
        },

        output = {
          vscode_luasnip = {
            vim.fn.stdpath "config" .. "/lua/custom/snippets/LuaSnip",
          },
        },
      }

      require("snippet_converter").setup {
        templates = { template },
      }
    end,
  },

  ["derekwyatt/vim-fswitch"] = {},

  ["liuchengxu/vista.vim"] = {},

  ["ludovicchabant/vim-gutentags"] = {},

  ["jackguo380/vim-lsp-cxx-highlight"] = {},

  -- ["m-pilia/vim-ccls"] = {},

  ["andymass/vim-matchup"] = {},

  ["folke/trouble.nvim"] = {
    requires = "nvim-tree/nvim-web-devicons",
    config = {
      require("trouble").setup {},
    },
  },

  -- ["numirias/semshi"] = {
  --   run = ":UpdateRemotePlugins",
  -- },
}
