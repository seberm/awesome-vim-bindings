local naughty = require("naughty")

local dbg = {}


function dbg.msg(m)
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "VimAw Debug message!",
                     text = m
                   })
end


return dbg
