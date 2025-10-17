Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    -- print(json.encode(entData))
    if action.name == 'teleport' then
        Event:TriggerNet('dwb:teleport:start', source, entData)
    elseif action.name == 'vehicle' then
        if data.current.value == 'fix' then
            Event:TriggerNet('dwb:mechanic:vehicle:fix', source, entityId)
        end
    end
end, true)