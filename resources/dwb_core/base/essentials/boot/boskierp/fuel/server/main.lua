Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data)
    local value = data.current.value
    local fuel = Player(source).state.fuel
    if action.name == 'fill-fuel' and value == 'start' and not fuel then
        local item = xPlayer:GetInventoryItem('cash')
        if item and item.count >= (action.pc or 2000) then
            local ped=  GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local _source = source
            local _action = action
            Player(source).state.fuel = true
            Object:CreateAsync('prop_cs_fuel_nozle', coords, function(obj, objId)
                Event:TriggerNet('dwb:fuel:fill:start', _source, objId, _action)
            end)
        end
    elseif action.name == 'fill-fuel' and value == 'stop' then
        Player(source).state.fuel = nil
        Event:TriggerNet('dwb:fuel:fill:stop', source)
    elseif action.name == 'vehicle' and value == 'fill-vehicle-fuel' then
        Event:TriggerNet('dwb:fuel:fill:fill', source, entityId)
    end
end, true)

Event:Register('dwb:fuel:sync', function(source, xPlayer,fuel)
    Entity(GetVehiclePedIsIn(GetPlayerPed(source))).state.fuel = fuel
end, true)

Event:Register('dwb:fuel:pay', function(source, xPlayer,money, netId, fuel)
    local item = xPlayer:GetInventoryItem('cash')
    if not item or item.count < money then
        xPlayer:ShowNotify('fail', 'Stacja benzynowa', 'Nie masz wystarczająco pieniędzy')
        Player(source).state.fuel = nil
        Event:TriggerNet('dwb:fuel:fill:stop', source)
    else
        xPlayer:RemoveInventoryItem('cash', money)
        local ent = NetworkGetEntityFromNetworkId(netId)
        xPlayer:ShowNotify('success', 'Stacja benzynowa', 'Zapłaciłeś ' .. money .. '$')
        Entity(ent).state.fuel = fuel
    end
end, true)