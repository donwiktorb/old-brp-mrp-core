


local Drone = Item:Register({
    name = 'drone' -- name = 'water'
})

function Drone:OnUse(xPlayer, item) 

    local coords = GetEntityCoords(GetPlayerPed(xPlayer.source)) Object:CreateAsync2('ch_prop_arcade_drone_01a', coords, function(drone, droneId)
        local netId = NetworkGetNetworkIdFromEntity(drone)

        xPlayer.inventory:RemoveItem('drone', 'name', 1)
        Event:TriggerNet('dwb:items:drone', xPlayer.source, droneId)
    end)
end
Event:Register('dwb:items:drone:back', function(source, xPlayer)
    xPlayer.inventory:AddItem({name = "drone", count = 1})
end, true)

RegisterCommand('drone',function(source, args)
    local coords = GetEntityCoords(GetPlayerPed(source)) Object:CreateAsync2('ch_prop_arcade_drone_01a', coords, function(drone, droneId)
        local netId = NetworkGetNetworkIdFromEntity(drone)

        Event:TriggerNet('dwb:items:drone:start', source, netId)
    end)

end)