Event:Register('dwb:sounds:play:client', function(source, xPlayer,pid, file, volume)
    Event:TriggerNet('dwb:sounds:play:client', pid, file, volume)
end, true)

Event:Register('dwb:sounds:play:source', function(source, xPlayer,file, volume)
    Event:TriggerNet('dwb:sounds:play:client', source, file, volume)
end, true)

Event:Register('dwb:sounds:play:distance', function(source, xPlayer,distance, file, volume)
    local coords = GetEntityCoords(GetPlayerPed(source))
    Event:TriggerNet('dwb:sounds:play:distance', -1, coords, distance, file, volume)
end, true)

Event:Register('dwb:sounds:stop', function(source, xPlayer)
    Event:TriggerNet('dwb:sounds:stop', source)
end, true)