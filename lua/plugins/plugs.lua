local overrides = require "configs.overrides"

local plugins = {
    -- Overrides
    {
        "mfussenegger/nvim-lint",
        event = { "BufEnter", "InsertEnter", "TextChanged" },
        config = function()
            require("configs.lint").setup()
        end,
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("configs.conform").setup()
        end,
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = true,
        -- event = { "BufReadPost", "BufNewFile" },
        event = { "LspAttach" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {},
        config = function()
            -- require "nvchad.configs.lspconfig"
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "InsertEnter",
        dependencies = {
            -- {
            --   "andymass/vim-matchup",
            --   init = function()
            --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
            --   end,
            -- },
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup {
                        opts = {
                            -- Defaults
                            enable_close = true, -- Auto close tags
                            enable_rename = true, -- Auto rename pairs of tags
                            enable_close_on_slash = false, -- Auto close on trailing </
                        },
                    }
                end,
            },
            -- {
            --   "nvim-treesitter/nvim-treesitter-context",
            --   config = function()
            --     require("nvim-treesitter.configs").setup {
            --       enable = true,
            --     }
            --   end,
            -- },
            { url = "https://git.sr.ht/~p00f/nvim-ts-rainbow" },
        },
        opts = overrides.treesitter,
    },

    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeRefresh", "NvimTreeFindFile" },
        opts = overrides.tree,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = overrides.autopairs,
    },

    {
        "mfussenegger/nvim-dap",
        enabled = true,
        module = { "dap" },
        dependencies = {
            { "Joakker/lua-json5", build = "./install.sh" },
            { "mfussenegger/nvim-dap-python", ft = { "python" }, module = "dap-python" },
            { "leoluz/nvim-dap-go", ft = { "go" }, module = "dap-go" },
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
            {
                "Weissle/persistent-breakpoints.nvim",
                config = function()
                    require("persistent-breakpoints").setup {
                        load_breakpoints_event = { "BufReadPre" },
                    }
                end,
            },
            {
                "nvim-neotest/nvim-nio",
            },
        },
        ft = function()
            local filetypes = require("configs.dap").available_langs
            return filetypes
        end,
        config = function()
            require("configs.dap").setup()
        end,
    },

    { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre" },
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

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "quangnguyen30192/cmp-nvim-ultisnips" },
        },
        opts = overrides.cmp(),
    },

    {
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        event = { "BufReadPre", "BufRead" },
        opts = overrides.color,
    },

    -- { "folke/which-key.nvim", opts = overrides.key },

    {
        "lewis6991/gitsigns.nvim",
        opts = overrides.signs,
    },

    -- User Plugins

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("configs.saga").setup()
        end,
    },

    { "wakatime/vim-wakatime", lazy = false },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function(plugin)
            if vim.fn.executable "npx" then
                vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.cmd [[Lazy load markdown-preview.nvim]]
                vim.fn["mkdp#util#install"]()
            end
        end,
        init = function()
            if vim.fn.executable "npx" then
                vim.g.mkdp_filetypes = { "markdown" }
            end
        end,
    },

    { "preservim/vim-markdown", ft = "markdown" },
    { url = "https://github.com/sheerun/vim-polyglot", event = "BufReadPre" },

    { "SirVer/ultisnips", event = { "LspAttach", "InsertEnter" } },

    { "honza/vim-snippets" },

    { "lervag/vimtex", ft = { "tex", "markdown", "lhaskell" } },
    { "KeitaNakamura/tex-conceal.vim", ft = "tex" },

    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            require("copilot").setup {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-Space>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    markdown = true,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
            }
            vim.cmd "Copilot disable"
        end,
    },

    -- {
    --     "folke/neodev.nvim",
    --     event = "BufReadPre *.lua",
    --     config = function()
    --         -- Neodev Setup
    --         require("neodev").setup {
    --             library = {
    --                 plugins = {
    --                     "dap",
    --                     "nvim-dap-ui",
    --                     "neotest",
    --                     "nvim-treesitter",
    --                     "plenary.nvim",
    --                     "telescope.nvim",
    --                     "lazy.nvim",
    --                 },
    --             },
    --         }
    --     end,
    -- },

    -- {
    --   "smjonas/snippet-converter.nvim",
    --   cmd = "ConvertSnippets",
    --   config = function()
    --     require "configs.snippet_converter"
    --   end,
    -- },

    {
        "derekwyatt/vim-fswitch",
        cmd = { "FSSplitBelow" },
    },

    -- { "ludovicchabant/vim-gutentags", event = "BufReadPost" },

    {
        "folke/trouble.nvim",
        event = "BufReadPre",
        cmd = { "Trouble" },
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                {
                    modes = {
                        diagnostics_buffer = {
                            mode = "diagnostics", -- inherit from diagnostics mode
                            filter = { buf = 0 }, -- filter diagnostics to the current buffer
                        },
                    },
                },
            }
        end,
    },

    { "wellle/targets.vim", event = "BufReadPre" },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("configs.better_escape").setup()
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
                    zig = "zig run",
                    haskell = "runghc",
                    lhaskell = "runghc",
                    r = "\\R -f",
                    go = "go run",
                    lua = "lua ",
                },
            }
        end,
    },

    -- {
    --   "ojroques/nvim-bufdel",
    --   cmd = "BufDel",
    --   config = function()
    --     require("bufdel").setup {
    --       quit = false,
    --     }
    --   end,
    -- },

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

    -- {
    --   "nmac427/guess-indent.nvim",
    --   cmd = "GuessIndent",
    --   config = function()
    --     require("guess-indent").setup {}
    --   end,
    -- },

    {
        "gelguy/wilder.nvim",
        dependencies = { "nixprime/cpsm" },
        config = function()
            require "configs.wilder"
        end,
        -- event = "BufEnter",
        keys = { "/", ":", "?" },
        -- lazy = false,
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
                require("configs.dressing").options,
            }
        end,
        event = "BufEnter",
    },

    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
        event = "BufReadPre",
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

    -- {
    --     "anuvyklack/windows.nvim",
    --     cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
    --     dependencies = {
    --         "anuvyklack/middleclass",
    --         "anuvyklack/animation.nvim",
    --     },
    --     config = function()
    --         vim.o.winwidth = 10
    --         vim.o.winminwidth = 10
    --         vim.o.equalalways = false
    --         require("windows").setup()
    --     end,
    -- },

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup {
                options = { "buffers", "currdir", "winsize", "folds" },
            }
        end,
    },

    -- {
    --     "rmagatti/auto-session",
    --     even = "BufReadPre",
    --     cmd = { "SessionSave", "SessionRestore" },
    --     -- lazy = false,
    --     config = function()
    --         require("auto-session").setup {
    --             log_level = "error",
    --             suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    --             auto_restore_enabled = false,
    --         }
    --     end,
    -- },

    -- { url = "https://github.com/imsnif/kdl.vim", ft = { "kdl" } },

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
            require("configs.diffview").setup()
        end,
    },

    { "jghauser/mkdir.nvim" },

    -- {
    --   "karb94/neoscroll.nvim",
    --   event = "BufReadPre",
    --   config = function()
    --     require("neoscroll").setup()
    --   end,
    -- },

    -- {
    --   "stevearc/overseer.nvim",
    --   cmd = { "OverseerRun", "OverseerToggle" },
    --   config = function()
    --     require("overseer").setup()
    --   end,
    -- },

    {
        "theHamsta/nvim_rocks",
        event = "VeryLazy",
        build = "pyenv exec hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
        config = function()
            require("configs.rocks").setup()
        end,
    },

    -- {
    --     "TimUntersberger/neogit",
    --     cmd = { "Neogit" },
    --     keys = { "<leader>go" },
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     -- config = function()
    --     --   require("configs.neo").setup()
    --     -- end,
    --     config = true,
    -- },

    { url = "https://github.com/lbrayner/vim-rzip", event = "LspAttach" },

    { "ziglang/zig.vim", ft = { "zig" } },

    {
        "skywind3000/asyncrun.vim",
        cmd = { "AsyncRun", "AsyncStop", "AsyncTask" },
    },

    -- {
    --   "MrcJkb/haskell-tools.nvim",
    --   ft = { "haskell", "lhaskell" },
    -- },

    {
        "enomsg/vim-haskellConcealPlus",
        ft = { "haskell", "lhaskell" },
    },

    {
        "lark-parser/vim-lark-syntax",
        ft = { "lark" },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPre",
        config = function()
            local rainbow_delimiters = require "rainbow-delimiters"
            rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        event = "BufReadPre",
        ft = { "rust" },
        init = function()
            require("configs.rustacean").setup()
        end,
    },

    {
        "pmizio/typescript-tools.nvim",
        ft = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
        },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            local lspconfig = require "lspconfig"
            local configs = require "nvchad.configs.lspconfig"
            local on_attach = configs.on_attach

            return require("typescript-tools").setup {
                on_attach = on_attach,
                cmd = { "typescript-language-server", "--stdio" },
                settings = {
                    single_file_support = true,
                    -- root_dir = lspconfig.util.root_pattern "package.json",
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                    },
                },
            }
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = function()
            require("configs.fidget").setup()
        end,
    },

    {
        "danymat/neogen",
        event = "BufReadPre",
        config = true,
    },

    {
        "stevearc/aerial.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("aerial").setup {}
        end,
    },

    {
        "folke/snacks.nvim",
        opts = {
            bigfile = {
                -- enabled = true,
                size = 1 * 1024 * 1024, -- 1MB
            },
        },
    },

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "BufReadPre",
        config = function()
            require("ts_context_commentstring").setup {
                enable_autocmd = false,
            }

            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                        and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end,
    },

    {
        "ThePrimeagen/harpoon",
        event = "BufReadPre",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("configs.harpoon").setup()
        end,
    },
}

return plugins
