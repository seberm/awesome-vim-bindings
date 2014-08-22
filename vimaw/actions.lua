local awful = require("awful")

local utils = require("vimaw.utils")
local config = require("vimaw.config")
local dbg = require("vimaw.dbg")
local commandMode = require("vimaw.command_mode")

local actions = {}


-- Simple actions
local function switchToInsertMode()
    insertMode()
end

local function switchToVisualMode()
    visualMode()
end

local function goLeft()
    awful.client.focus.bydirection("left")
    if client.focus then client.focus:raise() end
end

local function goDown()
    awful.client.focus.bydirection("down")
    if client.focus then client.focus:raise() end
end

local function goUp()
    awful.client.focus.bydirection("up")
    if client.focus then client.focus:raise() end
end

local function goRight()
    awful.client.focus.bydirection("right")
    if client.focus then client.focus:raise() end
end


local function runCommand()
    -- TODO Multiple run does not work (for example: 4r)

    awful.prompt.run(
      { prompt = "<span>Run: </span>" },
      mypromptbox[mouse.screen].widget,
      awful.util.spawn,
      awful.completion.shell,
      awful.util.getdir("cache") .. "/history",
      config.RUN_PROMPT_HISTORY_SIZE,

      -- Prompt automatically switches desktop into INSERT mode when we
      -- cancel input, so... we must explicitly switch it back into NORMAL mode
      -- It the same like in command mode.
      normalMode -- Done callback
   )
end


local function toogleFullscreen()
    local c = awful.client.next(0)
    if c == nil then return end

    c.fullscreen = not c.fullscreen
end

local function toogleOnTop()
    local c = awful.client.next(0)
    if c == nil then return end

    c.ontop = not c.ontop
end

local function toogleMaximalize()
    local c = awful.client.next(0)
    if c == nil then return end

    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical

    if c.focus then c.focus:raise() end
end

local function minimize()
    local c = awful.client.next(0)
    if c == nil then return end

    c.minimized = true
end

local function restore()
    awful.client.restore()
end

local function goNext()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end

local function goPrevious()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end

local function switchWindows()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
end

local function runTerminal()
    awful.util.spawn(config.TERMINAL)
    switchToInsertMode()
end

local function runEditor()
    awful.util.spawn(config.EDITOR_CMD)
    switchToInsertMode()
end

local function markCurrentWindow()
    if currentMode(VISUAL_MODE) then
        if not awful.client.ismarked() then
            awful.client.mark()
        else
            awful.client.unmark()
        end

        redrawBorders()
    end
end


--  Multi actions
local function closeWindow(direction)
    if direction then
        awful.client.focus.bydirection(direction)
    end

    local c = awful.client.next(0)
    if c then c:kill() end

    -- Switch to next window
    goNext()
end


local function closeWindowDown()    closeWindow("down")             end
local function closeWindowUp()      closeWindow("up")               end
local function closeWindowLeft()    closeWindow("left")             end
local function closeWindowRight()   closeWindow("right")            end
local function nextLayout()         awful.layout.inc(config.layouts, 1)    end
local function previousLayout()     awful.layout.inc(config.layouts, -1)   end
local function nextTag()            awful.tag.viewnext()            end
local function previousTag()        awful.tag.viewprev()            end
local function nextScreen()         awful.screen.focus_relative(1)  end
local function previousScreen()     awful.screen.focus_relative(-1) end
local function urgentJump()         awful.client.urgent.jumpto()    end


-- Actions
local Actions = {}

-- Simple commands
local QUICK_CMDS = { "h", "H", "j", "k", "l", "L", "r", "f", "m", "n", "Tab",
                     "i", "s", "t", "e", "Left", "Right", "Down", "Up", ":",
                     "u", "v"
                   }

-- TODO - These definitions move to config file in the future
Actions["h"] = goLeft
Actions["H"] = goPrevious
Actions["j"] = goDown
Actions["k"] = goUp
Actions["l"] = goRight
Actions["L"] = goNext
Actions["r"] = runCommand
Actions["f"] = toogleFullscreen -- DEPRECATED - will be used for application register
Actions["m"] = markCurrentWindow
Actions["n"] = minimize
Actions["N"] = restore
Actions["Tab"] = goNext
Actions["i"] = switchToInsertMode
Actions["s"] = switchWindows
Actions["t"] = runTerminal
Actions["e"] = runEditor
Actions["Right"] = goRight
Actions["Left"] = goLeft
Actions["Up"] = goUp
Actions["Down"] = goDown
Actions[":"] = commandMode.switchToCommandMode
Actions["u"] = urgentJump
Actions["v"] = switchToVisualMode

-- Multi commands
local LONG_CMDS = { "d", "g", "c", "C" }
Actions["dd"] = closeWindow
Actions["dj"] = closeWindowDown
Actions["dk"] = closeWindowUp
Actions["dh"] = closeWindowLeft
Actions["dl"] = closeWindowRight
Actions["cl"] = nextLayout
Actions["Cl"] = previousLayout
Actions["ct"] = nextTag
Actions["Ct"] = previousTag
Actions["cs"] = nextScreen
Actions["Cs"] = previousScreen
Actions["gm"] = toogleMaximalize
Actions["gt"] = toogleOnTop
Actions["gf"] = toogleFullscreen


-- TODO write a function to call these functions in array - warn if key of an array does not exist
function actions.callAction(action, n)
    -- Function never will be called 0 times
    if n == nil or n == 0 then n = 1 end

    for k in pairs(Actions) do
        if (k == action) then
            for i = 1, n do Actions[k]() end
            return
        end
    end

    dbg.msg("Function does not exist!")
end


function actions.isQuickCmd(key)
    return utils.inTable(QUICK_CMDS, key)
end


function actions.isLongCmd(key)
    return utils.inTable(LONG_CMDS, key)
end


return actions
