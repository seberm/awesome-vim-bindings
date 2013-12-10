-- Namespace
local P = {}
VimAw = P

function closeWindow()
    print("closing window")
end

function goDown()
    print("moving DOWN in wins")
end

function goUp()
    print("moving UP in wins")
end


function closeWindowDown()
    print("closing win down")
end


-- Actions
Actions = { }

-- Simple commands
Actions["h"] = goLeft
Actions["j"] = goDown
Actions["k"] = goUp
Actions["l"] = goRight

-- Multi commands
Actions["dd"] = closeWindow
Actions["dj"] = closeWindowDown


-- TODO write a function to call these functions in array - warn if key of an array does not exist
local function callAction(action, n)
    -- Function never will be called 0 times
    if n == nil or n == 0 then n = 1 end

    for k in pairs(Actions) do
        if (k == action) then
            for i=1,n do Actions[k]() end
            return
        end
    end

    print("Function does not exist!")
end


-- Constants
local END = 0
local START = 1
local READ_NEXT = 2
local COMPLETE = 3

local status = START;
local cmdCount = 0;

-- Buffer for cmds
local cmd = ""


function isNumber(key)
    if tonumber(key) then
        return true
    end

    return false
end


local function inTable(table, item)
    for key, value in pairs(table) do
        if value == item then return key end
    end

    return false
end


local QUICK_CMDS = { "j", "k", "l", "h", "m" }
local function isQuickCmd(key)
    return inTable(QUICK_CMDS, key)
end

local LONG_CMDS = { "d", "g" }
local function isLongCmd(key)
    return inTable(LONG_CMDS, key)
end


local function reset()
    status = START
    cmdCount = 0
    cmd = ""
end



function P.doAction(key)
    -- == while status do
    while status ~= END do
        -- READY STATUS - reading the first char
        if status == START then
            if isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)
                --action = START
                return
            elseif isQuickCmd(key) then
                cmd = key
                status = COMPLETE
            elseif isLongCmd(key) then
                cmd = key
                status = READ_NEXT
                return
            else
                -- Unknown key
                return
            end

        elseif status == READ_NEXT then
            -- TODO If this format of command is given: Y-cmd-X-cmd, resultant count should be cmdCount = Y+X
            if isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)
                action = READ_NEXT
                return
            else
                cmd = cmd .. key
                status = COMPLETE
            end

        elseif status == COMPLETE then
            print("calling: " .. cmd)
            callAction(cmd, cmdCount)
            reset()
            break; -- or return
        end
    end
end



-- TESTS
assert(isQuickCmd("j"))
