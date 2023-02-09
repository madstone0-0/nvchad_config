return {
  ["wakatime/vim-wakatime"] = {},

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
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

  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      local cmp = require "cmp"

      -- local cmp_ultisnips_mappings = require "cmp_nvim_ultisnips.mappings"
      return {
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- local copilot_keys = vim.fn["copilot#Accept"]()
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            -- elseif require("cmp_nvim_ultisnips").expand_or_jumpable() then
            --   cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            -- elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
            --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        -- formatters = {
        --   insert_text = require("copilot_cmp.format").remove_existing,
        -- },
        -- sources = {
        --   { name = "copilot" },
        -- },
      }
    end,
  },

  ["quangnguyen30192/cmp-nvim-ultisnips"] = {
    config = function()
      require("cmp_nvim_ultisnips").setup {}
    end,
  },

  ["nvim-tree/nvim-tree.lua"] = {
    override_options = {
      filters = {
        exclude = { vim.fn.getcwd() .. "/node_modules/" },
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
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

  -- ["luochen1990/rainbow"] = {},
  ["godlygeek/tabular"] = {},

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
  --     }
  --   end,
  -- },
  --
  -- ["zbirenbaum/copilot-cmp"] = {
  --   after = { "copilot.lua", "nvim-cmp" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  ["folke/which-key.nvim"] = {
    disable = false,
  },

  ["folke/neodev.nvim"] = {},

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

  -- ["puremourning/vimspector"] = {},

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

  ["andymass/vim-matchup"] = {},

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      matchup = {
        enabled = true,
      },
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
}
