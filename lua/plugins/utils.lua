return {
    { "wakatime/vim-wakatime", lazy = false },

    { "SirVer/ultisnips", event = { "LspAttach", "InsertEnter" } },

    { "honza/vim-snippets" },

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

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    {
        "gelguy/wilder.nvim",
        -- dependencies = { "nixprime/cpsm" },
        config = function()
            require("configs.wilder").setup()
        end,
        -- event = "BufEnter",
        keys = { "/", ":", "?" },
        lazy = true,
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
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup {
                options = { "buffers", "curdir", "winsize", "folds", "tabpages" },
            }
        end,
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

    { url = "https://github.com/lbrayner/vim-rzip", event = "LspAttach" },

    {
        "skywind3000/asyncrun.vim",
        cmd = { "AsyncRun", "AsyncStop", "AsyncTask" },
    },

    {
        "folke/todo-comments.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
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
        event = "BufReadPre",
        opts = {
            bigfile = {
                -- enabled = true,
                size = 1 * 1024 * 1024, -- 1MB
            },
        },
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

    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git" },
    },

    {
        "tpope/vim-abolish",
        cmd = { "S" },
    },
}
