local st_modules = require "nvchad_ui.statusline.modules"

-- local function CurrentVistaFunction()
--   local method = vim.fn["vista#GetCurrentMethod"]()
--   if method ~= "" then
--     return "  " .. method
--   end
--   return method
-- end

return {
  mode = function()
    return st_modules.mode()
  end,
}
