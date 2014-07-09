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

-- Window border size [3]
config.WIN_BORDER_SIZE = 3

-- Command history size
config.COMMAND_PROMPT_HISTORY_SIZE = 50


return config
