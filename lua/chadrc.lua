local highlights = require "highlights"

return {
    ui = {
        statusline = {
            theme = "vscode_colored",
        },

        tabufline = {
            lazyload = true,
        },

        cmp = {
            lspkind_text = true,
            style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
        },

        telescope = { style = "borderless" }, -- borderless / bordered
    },

    lsp = { signature = true },

    term = {
        winopts = { number = false },
        sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
        float = {
            row = 1,
            col = 1,
            width = 1,
            height = 1,
            border = "single",
        },
    },

    base46 = {
        theme = "chadtain",
        hl_override = highlights.override,
        hl_add = highlights.add,
        integrations = {
            "blankline",
            "cmp",
            "defaults",
            "devicons",
            "git",
            "lsp",
            "mason",
            "nvcheatsheet",
            "nvimtree",
            "statusline",
            "syntax",
            "treesitter",
            "tbline",
            "telescope",
            "whichkey",
        },

        transparency = false,
    },

    nvdash = {
        load_on_startup = true,
        header = {
            "                            ",
            "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
            "   ▄▀███▄     ▄██ █████▀    ",
            "   ██▄▀███▄   ███           ",
            "   ███  ▀███▄ ███           ",
            "   ███    ▀██ ███           ",
            "   ███      ▀ ███           ",
            "   ▀██ █████▄▀█▀▄██████▄    ",
            "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
            "                            ",
            "     Powered By  eovim    ",
            "                            ",
        },

        buttons = {
            { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
            { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
            { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
            { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
            { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

            { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

            {
                txt = function()
                    local stats = require("lazy").stats()
                    local ms = math.floor(stats.startuptime) .. " ms"
                    return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
                end,
                hl = "NvDashFooter",
                no_gap = true,
            },

            { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
        },
    },

    cheatsheet = {
        theme = "grid", -- simple/grid
        excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
    },
}
