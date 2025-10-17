

local suggestions = {}
local duplicated = {}
local hidden = true
local active = false
local forcedHidden = false

Key:onJustPressed('T', 'Otwórz/Zamknij chat', function()
    if not active then
        hidden = not hidden

        SendNUIMessage({
            type = 'Chat',
            action = 'open'
        })

        SendNUIMessage({
            type = 'Chat',
            action = 'setFocus',
            focus = true
        })
        SetNuiFocus(true)
        active = true
    end
end)

RegisterNUICallback('chat_state', function(data, cb)
    active = data.active
    if not active then
        SendNUIMessage({
            type = 'Chat',
            action = 'setFocus',
            focus = false
        })
        
        SetNuiFocus(false)
    end
    cb()
end)

RegisterNUICallback('chat_send', function(data, cb)
    if data.message and data.message:gsub("%s+", "") ~= '' then
        if data.message:sub(1, 1) == '/' then
            ExecuteCommand(data.message:sub(2))
        else
            Event:TriggerNet('dwb:chat:sendMessage', data.message)
        end  
    end

    cb()
end)

RegisterCommand('chat', function(s, a, r) 
    if a[1] == 'on' then
        forcedHidden = not forcedHidden
        SendNUIMessage({
            type = 'Chat',
            action = 'hide',
            data = {
                forcedHidden = forcedHidden
            }
        })
    end
end)

RegisterCommand('clear', function(s, a, r) 
    SendNUIMessage({
        type = 'Chat',
        action = 'messages',
        data = {
            action = 'clear',
        } 
    })
end)

-- RegisterNetEvent('dwb:chat:addSuggestion')
-- AddEventHandler('dwb:chat:addSuggestion', function(command, help, args)
--     table.insert(suggestions, {name = command, help = help, args = args or {}})
--     print(command, help, args) 
--     SendNUIMessage({
--         type = 'Chat', 
--         action = 'suggestions',
--         data = {
--             action = 'set',
--             suggestions = suggestions
--         }
--     })
-- endd
Event:Register('dwb:chat:addSuggestion', function()
    table.insert(suggestions, {name = command, help = help, args = args or {}})
    SendNUIMessage({
        type = 'Chat', 
        action = 'suggestions',
        data = {
            action = 'set',
            suggestions = suggestions
        }
    })
end, true)

Event:Register('dwb:chat:addMessage', function(data)
    SendNUIMessage({
        type = 'Chat',
        action = 'messages',
        data = {
            action = 'add',
            html = data.template,
            args = data.args or {}
        }
    })
end)

Event:Register('dwb:chat:addMessage', function(data)
    SendNUIMessage({
        type = 'Chat',
        action = 'messages',
        data = {
            action = 'add',
            html = data.template,
            args = data.args or {}
        }
    })
end, true)

RegisterNetEvent('dwb:chat:onPrint', function(text)
    SendNUIMessage({
        type = 'Chat',
        action = 'messages',
        data = {
            action = 'add',
            html = '<span style="color:green">INFO -> {0}</span>',
            args = {text}
        } 
    })
end)

Event:Register('dwb:chat:onMessage', function(text)
    SendNUIMessage({
        type = 'Chat',
        action = 'messages',
        data = {
            action = 'add',
            html = '<span>{0}: {1}</span>',
            args = {GetPlayerName(PlayerId()), text}
        }      
    })
end, true)

RegisterNetEvent('dwb:chat:started', function(sugg)
    for k,v in pairs(sugg) do
        if not duplicated[v.name] then
            table.insert(suggestions, v)
            duplicated[v.name] = true
        end
    end
    SendNUIMessage({
        type = 'Chat',
        action = 'suggestions',
        data = {
            action = 'set',
            suggestions = suggestions
        }
    })
end)

function refreshCommands()
    TriggerServerEvent('dwb:chat:started')

    local registeredCommands = GetRegisteredCommands()

    for _, command in ipairs(registeredCommands) do
        if not duplicated['/'..command.name] then
            if IsAceAllowed(('command.%s'):format(command.name)) then
                duplicated['/'..command.name] = true
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end
    end

    SendNUIMessage({
        type = 'Chat',
        action = 'suggestions',
        data = {
            action = 'set',
            suggestions = suggestions
        }
    })
end

AddEventHandler('onClientResourceStart', function(res)
    if res == GetCurrentResourceName() then
        Wait(2000)
        refreshCommands()

    end

end)

Event:Register('dwb:player:state:firstSpawn', function()
    refreshCommands()
end, false)