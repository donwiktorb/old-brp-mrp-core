RegisterCommand('miejsce', function(s, a, r)
    local number = a[1]
    if number then
        number = number-1
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh ~= 0 and IsVehicleSeatFree(veh, number) then
            SetPedIntoVehicle(PlayerPedId(), veh, number)
        end
    end
end)
