local st_modules = require "nvchad_ui.statusline.modules"

-- local function CurrentVistaFunction()
--   local method = vim.fn["vista#GetCurrentMethod"]()
--   if method ~= "" then
--     return "  " .. method
--   end
--   return method
-- end

local function customSections(sections)
  return table.concat(sections, " ")
end

-- local function autoSession()
--   if require("auto-session-library").current_session_name(),
-- end

local sections = {
  -- CurrentVistaFunction(),
}

return {
  mode = function()
    return st_modules.mode()
  end,

  git = function()
    return st_modules.git() .. " " .. customSections(sections)
  end,
}
