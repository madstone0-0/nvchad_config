local M = {}
function M.setup()
    local wilder = require "wilder"

    -- Minimal pipeline configuration: we use one branch that covers both file-finder and cmdline.
    wilder.set_option("pipeline", {
        wilder.branch(
            -- Minimal cmdline pipeline: fuzzy matching enabled, Python support disabled.
            wilder.cmdline_pipeline {
                language = "python",
                fuzzy = 1,
                use_python = 0, -- disable Python remote to reduce overhead
            },
            -- File finder pipeline (only used when needed)
            wilder.python_file_finder_pipeline {
                file_command = { "rg", "--files" },
                dir_command = { "fd", "-td" },
                filters = { "difflib_sorter" },
            }
        ),
    })

    -- Use only the basic highlighter to keep things fast.
    local highlighters = {
        wilder.basic_highlighter(),
    }

    -- Define a minimal highlights table.
    local highlights = {
        accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#90EE90" } }),
    }

    -- Define minimal renderers:
    local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
        border = "rounded",
        empty_message = " ",
        highlighter = highlighters,
        left = { " " }, -- remove extra icons/flags
        right = { " " },
        highlights = highlights,
    })

    local wildmenu_renderer = wilder.wildmenu_renderer {
        highlighter = highlighters,
        separator = " · ",
        left = { " " }, -- keep only minimal decorations
        right = { " " },
        highlights = highlights,
    }

    wilder.set_option(
        "renderer",
        wilder.renderer_mux {
            [":"] = popupmenu_renderer,
            ["/"] = wildmenu_renderer,
            substitute = wildmenu_renderer,
        }
    )

    wilder.setup { modes = { ":", "/", "?" } }
end

return M
