local eval = vim.api.nvim_eval
local utils = {}

function utils.math()
  return eval "vimtex#syntax#in_mathzone" == 1
end

function utils.comment()
  return eval "vimtex#syntax#in_comment()" == 1
end

function utils.env(name)
  local x, y = eval("vimtex#env#is_inside('" .. name .. "')")
  return x ~= 0 and y ~= 0
end

return utils
