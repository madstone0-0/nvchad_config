local M = {}
local dap = require "dap"

function M.setup(_)
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
  }

  dap.adapters.codelldb = {
    id = "codelldb",
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/adapter/codelldb",
      args = { "--port", "${port}" },
    },
    -- name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch file (GDB)",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerPath = "/usr/bin/gdb",
      justMyCode = true,
      -- program = function()
      --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
      -- end,
      program = vim.fn.getcwd() .. "/build" .. "/${fileBasenameNoExtension}",
      cwd = "${workspaceFolder}",
      stopAtEntry = false,
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },

    {
      name = "Attach to gdbserver :1234",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/gdb",
      cwd = "${workspaceFolder}",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
      end,

      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
  }
end

return M
