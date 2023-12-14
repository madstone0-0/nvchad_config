local M = {}

-- function M.setup(_)
--   require("dap-vscode-js").setup {
--     adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
--     debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
--     debugger_cmd = { "js-debug-adapter" },
--   }
--
--   for _, language in ipairs { "typescript", "javascript" } do
--     require("dap").configurations[language] = {
--       {
--         {
--           type = "pwa-node",
--           request = "launch",
--           name = "Launch file",
--           program = "${file}",
--           cwd = "${workspaceFolder}",
--         },
--
--         {
--           type = "pwa-node",
--           request = "attach",
--           name = "Attach",
--           processId = require("dap.utils").pick_process,
--           cwd = "${workspaceFolder}",
--         },
--       },
--     }
--   end
-- end
function M.setup(_)
  -- require("dap-vscode-js").setup {
  --   debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
  --   adapters = { "pwa-node" },
  -- }

  local dap = require "dap"

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
    },
  }

  -- language config
  for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
      {
        name = "Launch (Node)",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        -- sourceMaps = true,
        -- skipFiles = { "<node_internals>/**" },
        -- protocol = "inspector",
        -- console = "integratedTerminal",
      },

      {
        name = "Launch (Deno)",
        type = "pwa-node",
        request = "launch",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "run",
          "--inspect-wait",
          "--allow-all",
        },
        program = "${file}",
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },

      {
        name = "Attach to node process",
        type = "pwa-node",
        request = "attach",
        rootPath = "${workspaceFolder}",
        processId = require("dap.utils").pick_process,
      },
    }
  end
end

return M
