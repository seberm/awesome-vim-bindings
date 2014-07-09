local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local utils = require("vimaw.utils")
local config = require("vimaw.config")
local actions = require("vimaw.actions")
local dbg = require("vimaw.dbg")

local VimAw = {}

-- Informative textbox showing actual mode
VimAw.modeBox = wibox.widget.textbox()

-- Modes definition
NORMAL_MODE = "NORMAL"
INSERT_MODE = "INSERT"
VISUAL_MODE = "VISUAL"

local actualMode = NORMAL_MODE

function currentMode(mode)
    return actualMode == mode
end

-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.border_width = config.WIN_BORDER_SIZE



local function changeMode(mode)
    actualMode = mode
    VimAw.modeBox:set_text(string.format("[--%s--]", mode))
end


function redrawBorders()
    local c = awful.client.next(0)

    color = config.WIN_BORDER_ACTIVE_NORMAL_MODE
    if currentMode(INSERT_MODE) then
        color = config.WIN_BORDER_ACTIVE_INSERT_MODE
    elseif currentMode(VISUAL_MODE) then
        color = config.WIN_BORDER_ACTIVE_VISUAL_MODE
        if awful.client.ismarked(c) then
            color = config.WIN_MARKED_BORDER
        end
    end

    beautiful.border_focus = color
    if c then client.emit_signal("focus", c) end
end


function insertMode()
    changeMode(INSERT_MODE)
    redrawBorders()
    keygrabber.stop()
end


function visualMode()
    changeMode(VISUAL_MODE)
    redrawBorders()
end


-- States
local END = 0
local START = 1
local READ_NEXT = 2
local COMPLETE = 3

local status = START;
local cmdCount = 0;

-- Buffer for cmds
local cmd = ""


-- Reset automat state
local function reset()
    status = START
    cmdCount = 0
    cmd = ""
end


-- Automat
local function doAction(key)
    while status ~= END do
        -- READY STATUS - reading the first char
        if status == START then
            if utils.isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)
                return
            elseif actions.isQuickCmd(key) then
                cmd = key
                status = COMPLETE
            elseif actions.isLongCmd(key) then
                cmd = key
                status = READ_NEXT
                return
            else
                -- Unknown key
                return
            end

        elseif status == READ_NEXT then
            -- TODO If this format of command is given: Y-cmd-X-cmd, resultant count should be cmdCount = Y+X
            if utils.isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)
                action = READ_NEXT
                return
            else
                cmd = cmd .. key
                status = COMPLETE
            end

        elseif status == COMPLETE then
            actions.callAction(cmd, cmdCount)
            reset()
            break; -- or return
        end
    end
end


-- Switch to NORMAL mode
function normalMode()
    changeMode(NORMAL_MODE)
    redrawBorders()

    if not keygrabber.isrunning() then
        keygrabber.run(function(mod, key, event)
            if event == "press" then doAction(key) end
        end)
    end
end


VimAw.run = normalMode
return VimAw
