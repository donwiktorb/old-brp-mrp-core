Event:Register('dwb:air:sync:start', function(fixed, vehCoords, weaponHash)
    Event:TriggerNet('dwb:air:sync:start', -1, fixed, vehCoords, weaponHash)
end, true)

Event:Register('dwb:air:sync:stop', function()
    Event:TriggerNet('dwb:air:sync:stop', -1, fixed, vehCoords, weaponHash)
end, true)