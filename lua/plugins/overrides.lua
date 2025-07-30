local overrides = require "configs.overrides"

return {
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
        -- lazy = true,
        event = { "LspAttach", "BufEnter" },
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
            {
                "OXY2DEV/markview.nvim",
                config = function()
                    local mkv = require "markview"
                    mkv.setup {
                        preview = {
                            icon_provider = "devicons", -- "mini" or "devicons"
                        },
                    }
                end,
            },
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
        cmd = { "DapContinue" },
        lazy = true,
        enabled = true,
        module = { "dap" },
        dependencies = {
            { "Joakker/lua-json5", build = "./install.sh" },
            {
                "mfussenegger/nvim-dap-python",
                lazy = true,
                cmd = { "DapContinue" },
                ft = { "python" },
                module = "dap-python",
            },
            {
                "leoluz/nvim-dap-go",
                lazy = true,
                cmd = { "DapContinue" },
                ft = { "go" },
                module = "dap-go",
            },
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
            {
                "igorlfs/nvim-dap-view",
                ---@module 'dap-view'
                ---@type dapview.Config
                opts = {},
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
            {
                url = "https://codeberg.org/FelipeLema/cmp-async-path",
            },
            {
                "hrsh7th/cmp-cmdline",
            },
            {
                "hrsh7th/cmp-emoji",
            },
        },
        opts = overrides.cmp(),
    },

    {
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        event = { "BufReadPre", "BufRead" },
        opts = overrides.color,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = overrides.signs,
    },
}
