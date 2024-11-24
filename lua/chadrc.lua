-- First read our docs (completely) then check the example_config repo

local M = {}

local highlights = require "highlights"

M.ui = {
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
            { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
            { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
            { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
            { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
            { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
            { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
        },
    },

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

    lsp = { signature = true },
}

M.base46 = {
    theme = "mountain",
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
}

-- M.plugins = "plugins"
-- M.mappings = require "mappings"

return M
