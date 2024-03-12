local M = {}
local dap = require "dap"
local jdtls = require "jdtls"

function M.setup(_)
  jdtls.setup_dap { hotcodereplace = "auto" }
  require("jdtls.dap").setup_dap_main_class_configs()

  dap.configurations.java = {
    {
      type = "java",
      request = "launch",
      name = "Debug (Attach)",
      stopOnEntry = true,
      console = "integratedTerminal",
      hostName = "localhost",
      port = 5005,
    },
  }
end

return M
