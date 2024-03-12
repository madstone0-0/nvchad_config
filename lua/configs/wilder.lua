local wilder = require "wilder"

-- wilder.set_option(
--   "renderer",
--   wilder.popupmenu_renderer {
--     -- highlighter = wilder.basic_highlighter(),
--     highlighter = {
--       wilder.lua_pcre2_highlighter(),
--     },
--
-- highlights = {
--   accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#90EE90" } }),
-- },
--
--     left = { " ", wilder.popupmenu_devicons() },
--     right = { " ", wilder.popupmenu_scrollbar() },
--   }
-- )

wilder.set_option("pipeline", {
    wilder.branch(
        wilder.python_file_finder_pipeline {
            file_command = { "rg", "--files" },
            dir_command = { "fd", "-td" },
            filters = { "cpsm_filter", "difflib_sorter" },
        },
        wilder.cmdline_pipeline(),
        wilder.python_search_pipeline()
    ),
})

local highlighters = {
    wilder.lua_pcre2_highlighter(),
    wilder.basic_highlighter(),
}

local highlights = {
    accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#90EE90" } }),
}

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    border = "rounded",
    empty_message = " ",
    highlighter = highlighters,
    left = {
        " ",
        wilder.popupmenu_devicons(),
        wilder.popupmenu_buffer_flags {
            flags = " a + ",
            icons = { ["+"] = "", a = "", h = "" },
        },
    },
    right = {
        " ",
    },
    highlights = highlights,
})

local wildmenu_renderer = wilder.wildmenu_renderer {
    highlighter = highlighters,
    separator = " · ",
    left = { " ", wilder.wildmenu_spinner(), " " },
    right = { " ", wilder.wildmenu_index() },
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

wilder.set_option("pipeline", {
    wilder.branch(
        wilder.cmdline_pipeline {
            language = "python",
            fuzzy = 1,
        },

        wilder.substitute_pipeline {
            pipeline = wilder.python_search_pipeline {
                skip_cmdtype_check = 1,
                pattern = wilder.python_fuzzy_pattern {
                    start_at_boundary = 0,
                },
            },
        },

        wilder.python_search_pipeline {
            pattern = wilder.python_fuzzy_pattern {
                pattern = wilder.python_fuzzy_pattern {
                    start_at_boundary = 0,
                },
            },
            sorter = wilder.python_difflib_sorter(),
            -- engine = "re2",
        }
    ),
})

wilder.setup { modes = { ":", "/", "?" } }
