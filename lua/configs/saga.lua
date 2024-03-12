local M = {}

local lspsaga = require "lspsaga"

function M.setup()
  lspsaga.setup {
    preview = {
      lines_above = 0,
      lines_below = 10,
    },

    request_timeout = 2000,

    symbol_in_winbar = {
      enable = false,
      show_file = false,
    },

    outline = {
      keys = {
        expand_or_jump = "<enter>",
      },
    },

    lightbulb = {
      enable = false,
    },

    ui = {
      title = true,
      border = "single",
      winblend = 0,
      expand = "",
      collapse = "",
      code_action = "💡",
      incoming = " ",
      outgoing = " ",
      hover = " ",
      kind = {},
    },
  }
end

return M
