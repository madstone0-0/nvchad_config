-- First read our docs (completely) then check the example_config repo

local M = {}

local highlights = require "highlights"

M.ui = {
    theme = "material-darker",
    statusline = {
        theme = "vscode_colored",
    },

    tabufline = {
        lazyload = true,
    },
    hl_override = highlights.override,
    hl_add = highlights.add,

    nvdash = {
        load_on_startup = true,

        header = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        },

        buttons = {
            { "  Find File", "Spc f f", "Telescope find_files" },
            { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
            { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
            { "  Bookmarks", "Spc m a", "Telescope marks" },
            { "  Themes", "Spc t h", "Telescope themes" },
            { "  Mappings", "Spc c h", "NvCheatsheet" },
        },
    },
}

M.base46 = {
    integrations = {
        "blankline",
        "cmp",
        "defaults",
        "devicons",
        "git",
        "lsp",
        "mason",
        "nvcheatsheet",
        "nvdash",
        "nvimtree",
        "statusline",
        "syntax",
        "treesitter",
        "tbline",
        "telescope",
        "whichkey",
    },
}

-- M.plugins = "plugins"
-- M.mappings = require "mappings"

return M
