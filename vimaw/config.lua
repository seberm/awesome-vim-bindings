local awful = require("awful")

local config = {}

-- Default terminal [xterm]
config.TERMINAL = "xterm"

-- Default editor [vi]
config.EDITOR = os.getenv("EDITOR") or "vi"


config.EDITOR_CMD = config.TERMINAL .. " -e " .. config.EDITOR

-- Active window in insert mode (boder color) [#00C000]
config.WIN_BORDER_ACTIVE_INSERT_MODE = "#00C000"

-- Active window in normal mode (boder color) [#ff0d11]
config.WIN_BORDER_ACTIVE_NORMAL_MODE = "#ff0d11"

-- Active window in visual mode (boder color) [#00C000]
config.WIN_BORDER_ACTIVE_VISUAL_MODE = "#00C000"

-- Active window in visual mode (boder color) [#00C000]
config.WIN_MARKED_BORDER = "#FF8000"

-- Window border size [3]
config.WIN_BORDER_SIZE = 3

-- Command history size
config.COMMAND_PROMPT_HISTORY_SIZE = 50

-- Table of layouts to cover with awful.layout.inc, order matters.
config.layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

return config
