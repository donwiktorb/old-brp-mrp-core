-- Event:Register('dwb:chat:sendMessage', function(message)
--     Event:TriggerNet('dwb:chat:onMessage', source, message)

--     -- if not WasEventCanceled() then
--     --     Event:TriggerNet('dwb:chat:onMessage', -1, message)
--     -- end

-- end, true)

function refreshCommands()
    local cmds = Command:GetAll()
    local suggestions = {}
    for k,v in pairs(cmds) do
        if IsAceAllowed(('command.%s'):format(k)) then
            table.insert(suggestions, {
                name = '/' .. k,
                help = v.help,
                args = v.args
            })
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

RegisterNetEvent('__cfx_internal:commandFallback', function(command)
    -- if not WasEventCanceled() then
    --     TriggerClientEvent('dwb:chat:onPrint', source, '/' .. command) 
    -- end
    print(source, command)

    CancelEvent()
end)

RegisterNetEvent('dwb:chat:started', function()
    local suggestions = refreshCommands()
    local xPlayer = DWB.Players[source]

    TriggerClientEvent('dwb:chat:started', source, suggestions)

end)