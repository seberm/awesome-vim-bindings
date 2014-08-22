local awful = require("awful")

local log = require("vimaw.logging")
local config = require("vimaw.config")
local utils = require("vimaw.utils")


local commandMode = {}

-- Commands specification
local Commands = { }
Commands["restart"] = awesome.restart
Commands["quit"] = awesome.quit
Commands["terminal"] = runTerminal
Commands["editor"] = runEditor


local function exe_callback(command)
    local returnString = nil
    local normalProg, command, arg = command:match("^%s*(!?)%s*(%a+)(.*)")

    if normalProg ~= "" then
        returnString = awful.util.spawn(command .. " " .. arg)
    else -- It's an awesome command
        local cmd = Commands[command];
        if cmd then
            cmd(arg)
        else
            returnString = "VimAw does not support command \"" .. command .. "\""
        end
    end

    if type(returnString) == "string" then
        mypromptbox[mouse.screen].widget:set_text(returnString)
    end
end


local function completion(command, cur_pos, ncomp, shell)
    if command:sub(1,1) == "!" then -- Completion for shell commands (begining with !)
        command = command:sub(2)
        cur_pos = cur_pos - 1

        command, cur_pos = awful.completion.shell(command, cur_pos, ncomp, shell)

        command = '!' .. command
        cur_pos = cur_pos + 1
        return command, cur_pos
    else -- Completion for VimAw commands
        local all_cmds = utils.tableKeys(Commands)

        -- Abort completion under some circumstances
        if #command == 0 or (cur_pos ~= #command + 1 and command:sub(cur_pos, cur_pos) ~= " ") then
            return command, cur_pos
        end

        local matches = {}
        for k, c in pairs(all_cmds) do
          if c:find("^" .. command:sub(1, cur_pos)) then
              table.insert(matches, c)
          end
        end

        -- There are no matches, abort completion
        if #matches == 0 then return command, cur_pos end

        while ncomp > #matches do ncomp = ncomp - #matches end

        return matches[ncomp], cur_pos
    end
end


function commandMode.switchToCommandMode()
    awful.prompt.run(
      { prompt = "<span>COMMAND MODE: </span>" },
      mypromptbox[mouse.screen].widget,
      exe_callback,
      completion,
      awful.util.getdir("cache") .. "/history_command_mode",
      config.COMMAND_PROMPT_HISTORY_SIZE,

      -- Prompt automatically switches desktop into INSERT mode when we
      -- cancel input, so... we must explicitly switch it back into NORMAL mode
      normalMode -- Done callback
   )
end


return commandMode
