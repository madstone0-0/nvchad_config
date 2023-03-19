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
    cmd = "MarkdownPreview",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  ["junegunn/fzf.vim"] = {},

  ["godlygeek/tabular"] = {},

  ["preservim/vim-markdown"] = {
    cond = function()
      if vim.fn.expand "%:e" == "md" then
        return true
      else
        return false
      end
    end,
  },

  ["sheerun/vim-polyglot"] = {},

  ["SirVer/ultisnips"] = {},

  ["honza/vim-snippets"] = {},

  ["lervag/vimtex"] = {
    cond = function()
      if vim.fn.expand "%:e" == "md" or vim.fn.expand "%:e" == "tex" then
        return true
      else
        return false
      end
    end,
  },

  ["KeitaNakamura/tex-conceal.vim"] = {
    cond = function()
      if vim.fn.expand "%:e" == "md" or vim.fn.expand "%:e" == "tex" then
        return true
      else
        return false
      end
    end,
  },

  ["github/copilot.vim"] = {},

  ["folke/neodev.nvim"] = {
    library = { plugins = { "nvim-dap-ui" }, types = true },
  },

  -- ["smjonas/snippet-converter.nvim"] = {
  --   cmd = "ConvertSnippets",
  --   config = function()
  --     local template = {
  --       sources = {
  --         ultisnips = {
  --           vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips/markdown.snippets",
  --         },
  --       },
  --
  --       output = {
  --         vscode_luasnip = {
  --           vim.fn.stdpath "config" .. "/lua/custom/snippets/LuaSnip",
  --         },
  --       },
  --     }
  --
  --     require("snippet_converter").setup {
  --       templates = { template },
  --     }
  --   end,
  -- },

  ["derekwyatt/vim-fswitch"] = {
    cmd = { "FSSplitBelow" },
  },

  ["liuchengxu/vista.vim"] = {
    -- cmd = { "Vista!!", "Vista" },
  },

  ["ludovicchabant/vim-gutentags"] = {
    cond = function()
      if vim.fn.expand "%:e" == "cpp" or vim.fn.expand "%:e" == "h" or vim.fn.expand "%:e" == "c" then
        return true
      else
        return false
      end
    end,
  },

  ["jackguo380/vim-lsp-cxx-highlight"] = {

    -- cond = function()
    --   if vim.fn.expand "%:e" == "cpp" or vim.fn.expand "%:e" == "h" then
    --     return true
    --   else
    --     return false
    --   end
    -- end,
  },

  -- ["m-pilia/vim-ccls"] = {},

  ["andymass/vim-matchup"] = {},

  ["folke/trouble.nvim"] = {
    cmd = { "Trouble", "TroubleToggle" },
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },

  ["wellle/targets.vim"] = {},

  ["edluffy/specs.nvim"] = {
    config = function()
      require("specs").setup {
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          winhl = "PMenu",
          fader = require("specs").linear_fader,
          resizer = require("specs").shrink_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
          nofile = true,
        },
      }
    end,
  },

  ["max397574/better-escape.nvim"] = {
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
        -- example(recommended)
        -- keys = function()
        --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        -- end,
      }
    end,
  },

  ["CRAG666/code_runner.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    cmd = "RunCode",
    config = function()
      require("code_runner").setup {
        filetype = {
          python = "python3 -u",
        },
      }
    end,
  },

  ["ojroques/nvim-bufdel"] = {
    cmd = "BufDel",
    config = function()
      require("bufdel").setup {
        quit = false,
      }
    end,
  },

  ["nvim-treesitter/nvim-treesitter-context"] = {},
}
