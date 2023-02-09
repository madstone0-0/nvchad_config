local st_modules = require "nvchad_ui.statusline.modules"

-- local function human_readable(size)
--   local bytes = size
--   local sizes = {"B", "KiB", "MiB", "GiB"}
--   local i = 0
--   while bytes >= 1024 do
--     bytes = bytes / 1024.0
--     i += 1
--   end
--   return p
--
-- end

return {
  mode = function()
    return st_modules.mode()
  end,
}
