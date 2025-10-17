function TriggerServerCallback(name, requestId, source, cb, ...)
    if DWB.ServerCallbacks[name] ~= nil then
        Handling:Call(DWB.ServerCallbacks[name], source, cb, ...)
    else
        print('[dwb]: Server Callback -> '..name..' not found')
    end
end

RegisterNetEvent('dwb:triggerServerCallback', function(name, requestId, ...)
    local _source = source

    TriggerServerCallback(name, requestID, _source, function(...)
        TriggerClientEvent('dwb:serverCallback', _source, requestId, ...)
    end, ...)
end)
