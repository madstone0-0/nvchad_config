return {
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
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = function()
            require("configs.fidget").setup()
        end,
    },
}
