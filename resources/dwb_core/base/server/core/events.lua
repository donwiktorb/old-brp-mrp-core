RegisterNetEvent('dwb:events:server:net', function(name, token, ...)
    local _source = source
    Event:CallServerNet(name, token, _source, ...)
end)

RegisterNetEvent('dwb:events:server:net2', function(name, token, ...)
    local _source = source
    Event:CallServerNet2(name, token, _source, ...)
end)

AddEventHandler('dwb:server', function(name, ...)
    Event:CallServer(name, ...)
end)

Event:Register('dwb:callback:server', function(source, xPlayer, name, ...)
    local _source = source
    if DWB.Callbacks[name] then
        DWB.Callbacks[name](_source, function(...)
            Event:TriggerNet('dwb:callback:server:response', _source, name, ...)
        end, ...)
    end
end, true)

Event:Register('dwb:callback:server:async', function(source, xPlayer, name, ...)
    local _source = source
    if DWB.Callbacks[name] then
        DWB.Callbacks[name](_source, function(...)
            Event:TriggerNet('dwb:callback:server:response:async', _source, name, ...)
        end, ...)
    end
end, true)