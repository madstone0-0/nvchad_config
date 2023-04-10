local overrides = require "custom.plugins.overrides"

return {
  -- Overrides

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesiter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["nvim-tree/nvim-tree.lua"] = {
    override_options = overrides.tree,
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
    override_options = overrides.blankline,
  },

  ["NvChad/ui"] = {
    override_options = overrides.ui,
  },

  -- ["hrsh7th/nvim-cmp"] = {
  --   override_options = function()
  --     require "custom.plugins.cmp"
  --   end,
  -- },

  ["L3MON4D3/LuaSnip"] = {
    override_options = overrides.luasnip,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },

  -- User Plugins

  ["wakatime/vim-wakatime"] = {},

  ["junegunn/fzf"] = {
    run = ":call fzf#install()",
  },

  ["iamcco/markdown-preview.nvim"] = {
    -- cmd = "MarkdownPreview",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  ["junegunn/fzf.vim"] = {
    cmd = { "FZF", "FZF!", "Rg" },
  },

  ["preservim/vim-markdown"] = {},

  ["sheerun/vim-polyglot"] = {},

  ["SirVer/ultisnips"] = {},

  ["honza/vim-snippets"] = {},

  ["lervag/vimtex"] = {},

  ["KeitaNakamura/tex-conceal.vim"] = {},

  ["github/copilot.vim"] = {},
  -- ["zbirenbaum/copilot.lua"] = {
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --       copilot_node_command = "\\node",
  --     }
  --   end,
  -- },
  -- ["zbirenbaum/copilot-cmp"] = {
  --   after = "copilot.lua",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  ["folke/neodev.nvim"] = {
    library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
  },

  ["smjonas/snippet-converter.nvim"] = {
    cmd = "ConvertSnippets",
    config = function()
      require "custom.plugins.snippet_converter"
    end,
  },

  ["derekwyatt/vim-fswitch"] = {
    cmd = { "FSSplitBelow" },
  },

  ["liuchengxu/vista.vim"] = {
    cmd = { "Vista!!", "Vista" },
  },

  ["ludovicchabant/vim-gutentags"] = {},

  ["jackguo380/vim-lsp-cxx-highlight"] = {},

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

  ["HiPhish/nvim-ts-rainbow2"] = {},

  ["lambdalisue/suda.vim"] = {},

  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    cmd = "Telescope",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  ["kevinhwang91/nvim-bqf"] = {
    ft = "qf",
  },

  ["mbbill/undotree"] = {
    cmd = "UndotreeToggle",
  },

  ["windwp/nvim-ts-autotag"] = {},

  ["nmac427/guess-indent.nvim"] = {
    config = function()
      require("guess-indent").setup {}
    end,
  },

  ["gelguy/wilder.nvim"] = {
    requires = "nixprime/cpsm",
    config = function()
      require "custom.plugins.wilder"
    end,
  },

  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  ["stevearc/dressing.nvim"] = {
    config = function()
      require("dressing").setup {
        require "custom.plugins.dressing",
      }
    end,
  },

  ["mrjones2014/legendary.nvim"] = {
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

  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    config = function()
      require("lsp_lines").setup {}
    end,
  },

  ["nvim-neotest/neotest"] = {
    requires = {
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

  ["anuvyklack/windows.nvim"] = {
    cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
    requires = {
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

  ["folke/persistence.nvim"] = {
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },

  -- ["henriquehbr/nvim-startup.lua"] = {
  --   lazy = false,
  --   config = function()
  --     require("nvim-startup").setup {
  --       startup_file = "/tmp/nvim-startuptime", -- sets startup log path (string),
  --       message = "Baller",
  --     }
  --   end,
  -- },
}
