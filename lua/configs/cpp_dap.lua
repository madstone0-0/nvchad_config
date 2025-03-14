local M = {}
local dap = require "dap"

function parseExecPath()
    local buildPath = vim.fn.getcwd() .. "/build/"
    local fullPath = vim.fn.expand "%:h"
    local srcIdx = string.find(fullPath, "src")
    if srcIdx == nil then
        return ""
    end
    local execPath = string.sub(fullPath, srcIdx, string.len(fullPath))
    local path = buildPath .. execPath .. "/${fileBasenameNoExtension}"
    return path
end

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

    local type = "cppdbg"

    dap.configurations.cpp = {
        {
            name = "Launch file (Learning) (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            program = parseExecPath(),
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
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
            name = "Launch file with args (Learning) (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            program = parseExecPath(),
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            cwd = "${workspaceFolder}",
            args = function()
                local args = vim.fn.input "Arguments: "
                return vim.split(args, " +")
            end,
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
            name = "Launch file (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            -- program = function()
            --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
            -- end,
            program = function()
                return vim.fn.getcwd()
                    .. "/build_debug/src/"
                    .. "/"
                    .. vim.fn.expand "%:h:t"
                    .. "/${fileBasenameNoExtension}"
            end,
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
            name = "Find file (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            program = function()
                return vim.fn.input { prompt = "Path to executable: ", default = vim.fn.getcwd() .. "/build" }
            end,
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
            name = "Launch file with args (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build")
            end,
            args = function()
                local args = vim.fn.input "Arguments: "
                return vim.split(args, " +")
            end,
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
            name = "Find file with args (GDB)",
            type = type,
            request = "launch",
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build")
            end,
            args = function()
                local args = vim.fn.input "Arguments: "
                return vim.split(args, " +")
            end,
            -- externalConsole = true,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
            setupCommands = {
                {
                    text = "-enable-pretty-printing",
                    description = "enable pretty printing",
                    ignoreFailures = false,
                },
            },
        },

        {
            name = "Attach to gdbserver :9090",
            type = type,
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:9090",
            miDebuggerPath = "/usr/bin/gdb",
            serverLaunchTimeout = 5000,
            postRemoteConnectCommands = {
                {
                    text = "monitor reset",
                    ignoreFailures = false,
                },
                {
                    text = "load",
                    ignoreFailures = false,
                },
            },
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

        {
            name = "Find attach file",
            type = type,
            request = "attach",
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            justMyCode = true,
            processId = require("dap.utils").pick_process,
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
            setupCommands = {
                {
                    text = "-enable-pretty-printing",
                    description = "enable pretty printing",
                    ignoreFailures = false,
                },
            },
        },
    }

    dap.configurations.c = dap.configurations.cpp
end

return M
