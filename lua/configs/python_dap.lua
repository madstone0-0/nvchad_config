local M = {}

function M.setup(_)
  local dap_python = require "dap-python"
  dap_python.setup "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  dap_python.test_runner = "pytest"
  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "Run as Module",
    module = function()
      return vim.fn.input "Module name: "
    end,
  })

  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "Run as Module with Args",
    module = function()
      return vim.fn.input "Module name: "
    end,
    args = function()
      local args_string = vim.fn.input "Arguments: "
      return vim.split(args_string, " +")
    end,
  })

  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "Launch file with Args (justMyCode=false)",
    program = "${file}",
    cwd = "${fileDirname}",
    args = function()
      local args_string = vim.fn.input "Arguments: "
      return vim.split(args_string, " +")
    end,
    justMyCode = false,
  })
end

return M
