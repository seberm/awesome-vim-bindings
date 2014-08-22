local log = require("vimaw.logging")

-- Utilities
local utils = {}

function utils.isNumber(key)
    if tonumber(key) then
        return true
    end

    return false
end


function utils.inTable(table, item)
    for key, value in pairs(table) do
        if value == item then return key end
    end

    return false
end


function utils.tableKeys(tab)
    local keyset = {}
    local n = 0

    for k in pairs(tab) do
      n = n + 1
      keyset[n] = k
    end

    return keyset
end


return utils
