local M = {}

local dap = require "dap"
local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/bash-debug-adapter"
local DB_DIR = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir"

function M.setup()
  dap.adapters.sh = {
    type = "executable",
    command = DEBUGGER_PATH,
  }

  dap.configurations.sh = {
    {
      name = "Launch Bash debugger",
      type = "sh",
      request = "launch",
      program = "${file}",
      cwd = "${fileDirname}",
      pathBashdb = DB_DIR .. "/bashdb",
      pathBashdbLib = DB_DIR,
      pathBash = "bash",
      pathCat = "bat",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      env = {},
      args = {},
      -- showDebugOutput = true,
      -- trace = true,
    },
  }
end

return M
