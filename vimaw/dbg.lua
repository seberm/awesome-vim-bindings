local naughty = require("naughty")

local config = require("vimaw.config")


local dbg = {}

local function showMessage(title, msg)
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = title,
                     text = msg
    })
end


function dbg.dbg(msg)
    if config.LOGGING_MODE == "debug" then
        showMessage("VimAw Debug message", msg)
    end
end


function dbg.info(msg)
    showMessage("VimAw info message", msg)
end

return dbg
