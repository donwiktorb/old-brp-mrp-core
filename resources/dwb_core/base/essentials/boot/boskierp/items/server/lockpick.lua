


local Lockpick = Item:Register({
    name = 'lockpick' -- name = 'water'
})
function Lockpick:OnUse(xPlayer, item) 
    Event:TriggerNet('dwb:lockpick:use', xPlayer.source)
end




Event:Register('dwb:lockpick:use', function(source,xPlayer, vehId)
    local veh = NetworkGetEntityFromNetworkId(vehId)
    SetVehicleDoorsLocked(veh,  1)
    xPlayer.inventory:RemoveItem('lockpick', 'name', 1)
end, true)