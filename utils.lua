local dbg = require("dbg")

-- Utilities
function isNumber(key)
    if tonumber(key) then
        return true
    end

    return false
end


function inTable(table, item)
    for key, value in pairs(table) do
        if value == item then return key end
    end

    return false
end


function tableKeys(tab)
    local keyset = {}
    local n = 0

    for k in pairs(tab) do
      n = n + 1
      keyset[n] = k
    end

    return keyset
end
--------------------------

