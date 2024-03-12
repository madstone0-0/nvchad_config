local M = {}
local nvim_rocks = require "nvim_rocks"

function M.setup()
    nvim_rocks.ensure_installed "pcre2"
end

return M
