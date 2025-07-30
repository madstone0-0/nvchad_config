return {
    { url = "https://github.com/sheerun/vim-polyglot", event = "BufReadPre" },

    -- [[ Markdown ]]
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

    -- [[ Markdown ]]

    -- [[ Latex ]]

    { "lervag/vimtex", ft = { "tex", "markdown", "lhaskell" } },

    { "KeitaNakamura/tex-conceal.vim", ft = "tex" },

    {
        "preservim/vim-pencil",
        ft = { "tex", "markdown" },
        cmd = { "Pencil", "TogglePencil" },
    },

    -- [[ Latex ]]

    -- [[ C++ ]]

    {
        "derekwyatt/vim-fswitch",
        cmd = { "FSSplitBelow" },
    },

    -- [[ C++ ]]

    -- [[ Zig ]]

    { "ziglang/zig.vim", ft = { "zig" } },

    -- [[ Zig ]]

    -- [[ Haskell ]]

    {
        "enomsg/vim-haskellConcealPlus",
        ft = { "haskell", "lhaskell" },
    },

    -- [[ Haskell ]]

    -- [[ Rust ]]

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
    -- [[ Rust ]]

    -- [[ Web shit ]]

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

    -- [[ Web shit ]]

    -- [[ Lisp Adjacent]]

    {
        "Olical/conjure",
        ft = { "clojure", "fennel", "scheme" }, -- etc
        init = function()
            -- Set configuration options here
            -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
            -- This is VERY helpful when reporting an issue with the project
            -- vim.g["conjure#debug"] = true
            vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
            vim.g["conjure#client#guile#socket#pipename"] = "/tmp/guile-repl.socket"
            vim.g["conjure#mapping#prefix"] = "<leader>"
        end,

        -- Optional cmp-conjure integration
        dependencies = {
            {
                "PaterJason/cmp-conjure",
                config = function()
                    local cmp = require "cmp"
                    local config = cmp.get_config()
                    table.insert(config.sources, { name = "conjure" })
                    return cmp.setup(config)
                end,
            },
            {
                "gpanders/nvim-parinfer",
                ft = { "scheme" },
            },
        },
    },
    -- [[ Lisp Adjacent]]

    -- [[ Go ]]
    -- {
    --     "ray-x/go.nvim",
    --     dependencies = { -- optional packages
    --         "ray-x/guihua.lua",
    --         "neovim/nvim-lspconfig",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     opts = {
    --         -- lsp_keymaps = false,
    --         -- other options
    --     },
    --     event = { "CmdlineEnter" },
    --     ft = { "go", "gomod" },
    --     build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    -- },

    {
        "maxandron/goplements.nvim",
        ft = "go",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    -- [[ Go ]]
}
