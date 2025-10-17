
Core:RegisterUsableItem('clip', function(source)
    local xPlayer = DWB.Players[source]
    Event:TriggerNet('dwb:clip:use', source)
end)

Event:Register('dwb:clip:use', function()
    local xPlayer = DWB.Players[source]
    xPlayer:RemoveInventoryItem('clip', 1)
end, true)

Core:RegisterUsableItem('bulletproof', function(source)
    local xPlayer = DWB.Players[source]
    xPlayer:RemoveInventoryItem('bulletproof', 1)
    Event:TriggerNet('dwb:bp:use', source)
end)

Core:RegisterUsableItem('fixkit', function(source)
    local xPlayer = DWB.Players[source]
    xPlayer:RemoveInventoryItem('fixkit', 1)
    Event:TriggerNet('dwb:fixkit:use', source)
end)