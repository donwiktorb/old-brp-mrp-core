-- Event:Register('dwb:chat:sendMessage', function(source, xPlayer,message)
--     Event:TriggerNet('dwb:chat:onMessage', source, message)

--     -- if not WasEventCanceled() then
--     --     Event:TriggerNet('dwb:chat:onMessage', -1, message)
--     -- end

-- end, true)

function refreshCommands(source)
  local xPlayer = DWB.Players[source]
  local cmds = Command:GetAll()
  local suggestions = {}
  for k, v in pairs(cmds) do
    if v.admin then
      if xPlayer.data.group then
        local perm = Config.Admin.Permissions[xPlayer.data.group]
        if perm and perm.commands[k] then
          table.insert(suggestions, {
            name = "/" .. k,
            help = v.help,
            args = v.args,
          })
        end
      end
    else
      -- if IsAceAllowed(('command.%s'):format(k)) then
      table.insert(suggestions, {
        name = "/" .. k,
        help = v.help,
        args = v.args,
      })
      -- end
    end
  end

  return suggestions

  -- local registeredCommands = GetRegisteredCommands()

  -- local suggestions = {}

  -- for _, command in ipairs(registeredCommands) do
  --     if IsAceAllowed(('command.%s'):format(command.name)) then
  --         table.insert(suggestions, {
  --             name = '/' .. command.name,
  --             help = ''
  --         })
  --     end
  -- end

  -- return suggestions
end

RegisterNetEvent("__cfx_internal:commandFallback", function(command)
  -- if not WasEventCanceled() then
  --     TriggerClientEvent('dwb:chat:onPrint', source, '/' .. command)
  -- end
  -- -- print(source, command)

  CancelEvent()
end)

-- Event:Register('dwb:chat:started', function(source, xPlayer)
--     local suggestions = refreshCommands(source)
--     local xPlayer = DWB.Players[source]

--     Event:TriggerNet('dwb:chat:started', source, suggestions)
-- end, true)
User:OnLoadedChar(function(self)
  local suggestions = refreshCommands(self.source)
  Event:TriggerNet("dwb:chat:started", self.source, suggestions)
end)
