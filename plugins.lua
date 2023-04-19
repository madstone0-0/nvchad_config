local overrides = require "custom.configs.overrides"

local plugins = {
  -- Overrides

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/nvim-ts-rainbow2",
    },
    opts = overrides.treesiter,
    event = "BufRead",
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.tree,
  },

  {
    "mfussenegger/nvim-dap",
    enabled = true,
    lazy = true,
    event = "BufReadPre",
    module = { "dap" },
    dependencies = {
      { "mfussenegger/nvim-dap-python", module = "dap-python" },
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require("custom.configs.dap").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.blankline,
  },

  {
    "L3MON4D3/LuaSnip",
    opts = overrides.luasnip,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    opts = overrides.telescope,
  },

  -- User Plugins

  { "wakatime/vim-wakatime", lazy = false },

  {
    "junegunn/fzf",
    build = ":call fzf#install()",
    lazy = false,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },

  {
    "junegunn/fzf.vim",
    lazy = false,
  },

  { "preservim/vim-markdown", ft = "markdown" },

  { url = "https://github.com/sheerun/vim-polyglot", event = "BufReadPre" },

  { "SirVer/ultisnips", lazy = false },

  { "honza/vim-snippets" },

  { "lervag/vimtex", ft = "tex" },

  { "KeitaNakamura/tex-conceal.vim", ft = "tex" },

  { "github/copilot.vim", event = "BufRead" },

  {
    "folke/neodev.nvim",
    event = "BufReadPre *.lua",
  },

  {
    "smjonas/snippet-converter.nvim",
    cmd = "ConvertSnippets",
    config = function()
      require "custom.configs.snippet_converter"
    end,
  },

  {
    "derekwyatt/vim-fswitch",
    cmd = { "FSSplitBelow" },
  },

  {
    "liuchengxu/vista.vim",
    event = "BufReadPost",
  },

  { "ludovicchabant/vim-gutentags", event = "BufReadPost" },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },

  { "wellle/targets.vim", event = "BufReadPre" },

  {
    "edluffy/specs.nvim",
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

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
      }
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "RunCode",
    config = function()
      require("code_runner").setup {
        filetype = {
          python = "python3 -u",
        },
      }
    end,
  },

  {
    "ojroques/nvim-bufdel",
    cmd = "BufDel",
    config = function()
      require("bufdel").setup {
        quit = false,
      }
    end,
  },

  {
    "lambdalisue/suda.vim",
    lazy = false,
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "nmac427/guess-indent.nvim",
    cmd = "GuessIndent",
    config = function()
      require("guess-indent").setup {}
    end,
  },

  {
    "gelguy/wilder.nvim",
    dependencies = "nixprime/cpsm",
    config = function()
      require "custom.configs.wilder"
    end,
    lazy = false,
  },

  {
    "kylechui/nvim-surround",
    -- lazy = false,
    event = "BufRead",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup {
        require "custom.configs.dressing",
      }
    end,
    lazy = false,
  },

  {
    "mrjones2014/legendary.nvim",
    cmd = "Legendary",
    config = function()
      require("legendary").setup {
        which_key = {
          auto_register = true,
        },
        extensions = {
          nvim_tree = true,
        },
      }
    end,
  },

  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
    event = "BufReadPost",
  },

  {
    "nvim-neotest/neotest",
    module = "neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
          },
        },
      }
    end,
  },

  {
    "anuvyklack/windows.nvim",
    cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },

  { url = "https://github.com/imsnif/kdl.vim", ft = { "kdl" } },

  {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  },

  {
    "kevinhwang91/nvim-ufo",
    -- lazy = false,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },

  { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup()
    end,
  },
}

return plugins
