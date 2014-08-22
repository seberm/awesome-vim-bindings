local naughty = require("naughty")

local config = require("vimaw.config")


local logging = {}

local function showMessage(title, msg)
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = title,
                     text = msg
    })
end


function logging.debug(msg)
    if config.LOGGING_MODE == "debug" then
        showMessage("VimAw Debug message", msg)
    end
end


function logging.info(msg)
    showMessage("VimAw info message", msg)
end

return logging
