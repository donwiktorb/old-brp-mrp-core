--- Controls Module
---Provides functionality for managing input controls.
---@module Commands

--- Controls class for managing input states.
---@type Commands
Command = class()

Command.commands = {}

--[[
    Register('car', function(source, args, raw), {'admin', 'superadmin'})
    {name, args -> {name}, help}
]]

--- Get all commands
function Command:GetAll()
  return Command.commands
end
--- Register command
---@param name string
---@param suggestion table
---@param cb function
---@param groups table
function Command:Register(name, suggestion, cb, groups)
  if Command.commands[name] then
    return Log:Info("Command", name, "already registered.")
  end
  RegisterCommand(name, function(source, args, raw)
    local xPlayer = DWB.Players[source]
    if not xPlayer then
      return Log:Info("xPlayer not found")
    end
    if #groups > 0 then
      cb(xPlayer, args, raw)
    else
      for k, v in pairs(groups) do
        if xPlayer.group == v then
          cb(xPlayer, args, raw)
        end
      end
    end
  end)
  local help = suggestion[1]
  suggestion[1] = nil
  local args = suggestion
  Command.commands[name] = {
    help = help,
    args = args,
  }
  Event:Trigger("dwb:chat:addSuggestion", name, help, args)
end
