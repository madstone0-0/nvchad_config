local wilder = require "wilder"

wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer {
    highlighter = wilder.basic_highlighter(),
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },
  }
)

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.python_file_finder_pipeline {
      -- to use ripgrep : {'rg', '--files'}
      -- to use fd      : {'fd', '-tf'}
      file_command = { "rg", "--files" },
      -- to use fd      : {'fd', '-td'}
      dir_command = { "fd", "-td" },
      -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
      -- found at https://github.com/nixprime/cpsm
      filters = { "cpsm_filter", "difflib_sorter" },
    },
    wilder.cmdline_pipeline(),
    wilder.python_search_pipeline()
  ),
})

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      language = "python",
      fuzzy = 1,
    },
    wilder.python_search_pipeline {
      pattern = wilder.python_fuzzy_pattern(),
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = "re",
    }
  ),
})

wilder.setup { modes = { ":", "/", "?" } }
