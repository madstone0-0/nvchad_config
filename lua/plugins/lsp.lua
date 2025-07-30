return {
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
                    gitcommit = true,
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
}
