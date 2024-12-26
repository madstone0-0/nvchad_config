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

return M
