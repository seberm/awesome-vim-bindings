local awful = require("awful")

-- require utils
local dbg = require("dbg")

require("config")

-- Simple actions
function switchToInsertMode()
    changeMode(INSERT_MODE)
    redrawBorders(WIN_BORDER_ACTIVE_INSERT_MODE)
    keygrabber.stop()
end

function goLeft()
    awful.client.focus.bydirection("left")
    if client.focus then client.focus:raise() end
end

function goDown()
    awful.client.focus.bydirection("down")
    if client.focus then client.focus:raise() end
end

function goUp()
    awful.client.focus.bydirection("up")
    if client.focus then client.focus:raise() end
end

function goRight()
    awful.client.focus.bydirection("right")
    if client.focus then client.focus:raise() end
end

function runCommand()
    -- TODO Multiple run does not work (for example: 4r)
    -- TODO When command input is canceled, desktop should stay in NORMAL mode
    -- TODO Application is automaticaly switched into INSERT MODE - maybe it is OK...but it is necessary to inform user about new mode!
    mypromptbox[mouse.screen]:run()
end

function toogleFullscreen()
    local c = awful.client.next(0)
    if c == nil then return end

    c.fullscreen = not c.fullscreen
end

function toogleOnTop()
    local c = awful.client.next(0)
    if c == nil then return end

    c.ontop = not c.ontop
end

function toogleMaximalize()
    local c = awful.client.next(0)
    if c == nil then return end

    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical

    if c.focus then c.focus:raise() end
end

function minimize()
    local c = awful.client.next(0)
    if c == nil then return end

    c.minimized = true
end

function restore()
    awful.client.restore()
end

function goNext()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end

function goPrevious()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end

function switchWindows()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
end

function runTerminal()
    dbg.msg(terminal)
    awful.util.spawn(terminal)
    switchToInsertMode()
end

function runEditor()
    awful.util.spawn(editor_cmd)
    switchToInsertMode()
end


--  Multi actions
function closeWindow(direction)
    if direction then
        awful.client.focus.bydirection(direction)
    end

    local c = awful.client.next(0)
    if c then c:kill() end

    -- Switch to next window
    goNext()
end

function closeWindowDown() closeWindow("down") end
function closeWindowUp() closeWindow("up") end
function closeWindowLeft() closeWindow("left") end
function closeWindowRight() closeWindow("right") end
function nextLayout() awful.layout.inc(layouts, 1) end
function previousLayout() awful.layout.inc(layouts, -1) end
function nextTag() awful.tag.viewnext() end
function previousTag() awful.tag.viewprev() end
function nextScreen() awful.screen.focus_relative(1) end
function previousScreen() awful.screen.focus_relative(-1) end
function urgentJump() awful.client.urgent.jumpto() end


-- Actions
local Actions = {}

-- Simple commands
local QUICK_CMDS = { "h", "H", "j", "k", "l", "L", "r", "f", "m", "n", "Tab", "i", "s", "t", "e", "Left", "Right", "Down", "Up", ":", "u" }
Actions["h"] = goLeft
Actions["H"] = goPrevious
Actions["j"] = goDown
Actions["k"] = goUp
Actions["l"] = goRight
Actions["L"] = goNext
Actions["r"] = runCommand
Actions["f"] = toogleFullscreen -- DEPRECATED - will be used for application register
Actions["m"] = toogleMaximalize -- DEPRECATED - same as 'f' action
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
Actions[":"] = switchToCommandMode
Actions["u"] = urgentJump

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
function callAction(action, n)
    -- Function never will be called 0 times
    if n == nil or n == 0 then n = 1 end

    for k in pairs(Actions) do
        if (k == action) then
            for i=1, n do Actions[k]() end
            return
        end
    end

    print("Function does not exist!")
end

function isQuickCmd(key)
    return inTable(QUICK_CMDS, key)
end


function isLongCmd(key)
    return inTable(LONG_CMDS, key)
end
