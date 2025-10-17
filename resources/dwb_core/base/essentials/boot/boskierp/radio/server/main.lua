


Event:Register('dwb:vehicle:radio', function(source, xPlayer,url)
    local ped = GetPlayerPed(source)
    local veh = GetVehiclePedIsIn(ped)
    Entity(veh).state.radio = url
end, true)
Event:Register('dwb:vehicle:radio:sync', function(source, xPlayer,time)
    local ped = GetPlayerPed(source)
    local veh = GetVehiclePedIsIn(ped)
    Entity(veh).state.radioTime = time
end, true)
Event:Register('dwb:vehicle:radio:stop', function(source, xPlayer,url)
    local ped = GetPlayerPed(source)
    local veh = GetVehiclePedIsIn(ped)
    Entity(veh).state.radio = nil
end, true)
