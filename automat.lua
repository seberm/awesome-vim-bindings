--void onPressKey(char key, int event)  {
--    if (event == EVENT_PRESS) {
--        doAction(key);
--    }
--}

function closeWindow()
    print("closing window")
end

function moveDown()
    print("moving DOWN in wins")
end

function moveUp()
    print("moving UP in wins")
end


-- Functions
Actions = {}
Actions["dd"] = closeWindow
Actions["j"] = moveDown
Actions["k"] = moveUp

-- TODO write a function to call these functions in array - warn if key of an array does not exist
--Actions[nil] = function () print("function does not exist!") end

-- Constants
local END = 0
local START = 1
local READ_NEXT = 2
local COMPLETE = 3

local status = START;
local cmdCount = 0;

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


local QUICK_CMDS = { "j", "k", "l", "h", "m" }
function isQuickCmd(key)
    return inTable(QUICK_CMDS, key)
end

local LONG_CMDS = { "d" }
function isLongCmd(key)
    return inTable(LONG_CMDS, key)
end


-- Buffer for cmds
cmd = ""


function doAction(key)
    -- == while status do
    while status ~= END do
        -- READY STATUS - reading the first char
        if status == START then
            if isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)
                print("number: " .. key .. "cmdCount: " .. cmdCount)
                action = START
                return
            elseif isQuickCmd(key) then
                if cmdCount == 0 then
                    Actions[key]()
                else
                    for i=1,cmdCount do
                        Actions[key]()
                    end
                end

                -- call function and reset
                cmdCount = 0
                status = START
                cmd = ""
                return
            elseif isLongCmd(key) then
                cmd = cmd .. key
                status = READ_NEXT
                return
            else
                print("key not supported: " .. key)
                status = START
                cmdCount = 0
                cmd = ""
                return
            end


        elseif status == READ_NEXT then
            if isNumber(key) then
                cmdCount = cmdCount * 10 + tonumber(key)

                action = READ_NEXT
                return
            elseif isLongCmd(key) then
                if cmdCount == 0 then
                    Actions[key]()
                else
                    for i=1,cmdCount do
                        Actions[key]()
                    end
                end
                
                cmdCount = 0
                cmd = ""
                status = START
                return
            else
                print("combination not supported")
                status = START
                cmdCount = 0
                cmd = ""
                return
            end
        end
    end
end


-- TESTS
assert(isQuickCmd("j"))


--        switch (status) {
--            default:
--            case START:
--                switch (key) {
--                    case '0':
--                    case '1':
--                    case '2':
--                    case '3':
--                    //.....
--                        cmdCount = cmdCount * 10 + (key - '0')
--                        break;
--
--
--                    case 'd':
--                    case 'g':
--                        stack.push_back(key);
--                        status = READ_NEXT;
--                        break;
--                    
--                    case 'j':
--                    case 'k':
--                    case 'h':
--                    case 'l':
--                    case 'f':
--                    case 'm':
--                    case 'n':
--                        stack.push_back(key);
--                        status = COMPLETE;
--
--
--                    case 'ESC'
--                    default:
--                        // Key does not supported
--                        stack.clean();
--                        status = START;
--                        break;
--
--                };
--                break;
--
--
--            case READ_NEXT:
--                break;
--
--            case COMPLETE:
--                string index;
--                for (int i = 0; i < stack.size(); ++i) // clean whole stack
--                    index += stack.pop() // get char and POP
--
--                // LUA
--                fun = Actions[index];
--                for (int i = 0; i < cmdCount; ++i)
--                    fun();
--
--                status = START;
--                break;
--        };
--    }
--}
