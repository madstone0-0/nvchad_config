local M = {}

function M.Set(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end

function M.findStringInTable(str, table)
    for _, i in ipairs(table) do
        if str == i then
            return true
        end
    end
    return false
end

local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

--- Generic Telescope wrapper
---@param title string
---@param finder table|function  A finder table or thunk returning one
---@param on_select fun(entry:string, bufnr:number)
function M.CustomPicker(title, finder, on_select)
    local finder_spec = type(finder) == "function" and finder() or finder

    pickers
        .new({}, {
            prompt_title = title,
            finder = finder_spec,
            sorter = require("telescope.sorters").get_fzy_sorter {},
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local entry = action_state.get_selected_entry()[1]
                    actions.close(prompt_bufnr)
                    on_select(entry, prompt_bufnr)
                end)
                return true
            end,
        })
        :find()
end

return M
