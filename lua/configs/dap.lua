local M = {}

local python_present, dap_python = pcall(require, "dap-python")
-- local dap_present, dap = pcall(require, "dap")
M.available_langs = { "cpp", "python", "sh", "javascript", "typescript", "java", "c", "rust", "lua" }

-- if not dap_present then
--   function M.setup()
--     print "DAP not loaded"
--   end
--
--   return M
-- end

local function configure()
    local dap = require "dap"
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
            -- text = "⭐️",
            text = "->",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

    dap.defaults.fallback.external_terminal = {
        command = "/usr/bin/kitty",
        args = { "--hold", "-- bash -i -l -c" },
    }

    require("dap.ext.vscode").json_decode = require("json5").parse
end

local function configure_exts()
    local dap = require "dap"
    local dap_virtual_present, dap_virtual = pcall(require, "nvim-dap-virtual-text")
    if dap_virtual_present then
        dap_virtual.setup {
            commented = true,
            only_first_definition = true,
            -- all_references = true,
            all_frames = false,
            virt_text_win_col = 30,
            highlight_changed_variables = true,
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
                        -- {
                        --     id = "terminal",
                        --     size = 0.25,
                        -- },
                    },
                    position = "left",
                    size = 35,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.3,
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
        require("configs.python_dap").setup()
    end
    require("configs.java_dap").setup()
    require("configs.cpp_dap").setup()
    require("configs.bash_dap").setup()
    require("configs.node_dap").setup()
end

function M.setup()
    configure() -- Configuration
    configure_exts() -- Extensions
    configure_debuggers() -- Debugger
    -- end
end

-- configure_debuggers()

return M
