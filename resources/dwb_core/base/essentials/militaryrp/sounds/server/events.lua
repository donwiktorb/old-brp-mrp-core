Event:Register('dwb:sounds:play:client', function(pid, file, volume, loop)
    Event:TriggerNet('dwb:sounds:play:client', pid, file, volume, loop)
end, true)

Event:Register('dwb:sounds:play:source', function(file, volume, loop)
    Event:TriggerNet('dwb:sounds:play:client', source, file, volume, loop)
end, true)

Event:Register('dwb:sounds:play:distance', function(distance, file, volume, loop)
    local coords = GetEntityCoords(GetPlayerPed(source))
    Event:TriggerNet('dwb:sounds:play:distance', -1, coords, distance, file, volume, loop)
end)

Event:Register('dwb:sounds:stop', function()
    Event:TriggerNet('dwb:sounds:stop', source)
end, true)