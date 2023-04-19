local M = {}

local python_present, dap_python = pcall(require, "dap-python")
local dap_present, dap = pcall(require, "dap")

if not dap_present then
  function M.setup()
    print "DAP not loaded"
  end

  return M
end

local function configure()
  local dap_breakpoint = {
    error = {
      text = "🟥",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  local dap_virtual_present, dap_virtual = pcall(require, "nvim-dap-virtual-text")
  if dap_virtual_present then
    dap_virtual.setup {
      commented = true,
    }
  end

  local dapui_present, dapui = pcall(require, "dapui")
  if dapui_present then
    dapui.setup {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 35,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.7,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    }
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
end

local function configure_debuggers()
  if python_present then
    require("custom.configs.python_dap").setup()
  end
  require("custom.configs.cpp_dap").setup()
end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  -- end
end

configure_debuggers()

return M
