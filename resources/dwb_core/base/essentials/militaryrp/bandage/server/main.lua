function checkClosest(source,cb)
    local closestDistance, closestPlayer = -1, 0
    local coords = GetEntityCoords(GetPlayerPed(source))
    for k,v in pairs(DWB.Players) do
        if k ~= source then
            local target = GetPlayerPed(k)
            local targetCoords = GetEntityCoords(target)
            local dist = #(coords-targetCoords)

            if closestDistance == -1 or closestDistance > dist then
				closestPlayer = k
				closestDistance = dist
            end
        end
    end

    cb(closestDistance, closestPlayer)
end

Core:RegisterUsableItem('bandage', function(source)
    Event:TriggerNet('dwb:bw:revive2', source)
    local xPlayer=  DWB.Players[source]
    xPlayer:RemoveInventoryItem('bandage', 1)
end)

Core:RegisterUsableItem('medkit', function(source)
    checkClosest(source, function(dist, id)
        if id and dist <= 5 then
            local xPlayer=  DWB.Players[source]
            xPlayer:RemoveInventoryItem('bandage', 1)
            Event:TriggerNet('dwb:bw:revive', id)
        end
    end)
end)