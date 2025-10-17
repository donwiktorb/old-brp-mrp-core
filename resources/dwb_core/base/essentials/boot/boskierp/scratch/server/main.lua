
Item:RegisterUsable('scratch', function(source)
    local rand = math.random(Config.ScratchChance[1], Config.ScratchChance[2])
    if rand == 2 then
        local money = math.random(Config.ScratchPrice[1], Config.ScratchPrice[2])
        xPlayer:AddInventoryItem(false, 'cash', money)
        Event:TriggerNet('dwb:scratch:show', source, money)
    else
        Event:TriggerNet('dwb:scratch:show', source, 'None')
    end
    xPlayer:RemoveInventoryItem('scratch', 1)
end)