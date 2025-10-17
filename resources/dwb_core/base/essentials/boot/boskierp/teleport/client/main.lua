
Event:Register('dwb:teleport:start', function(data)

        User:Teleport(data)
    -- local height = GetEntityHeightAboveGround(PlayerPedId())
    -- if height > 7.0 then
    --     local ret, z = GetGroundZFor_3dCoord(data.coords, true)
    --     if ret then
    --         SetEntityCoords(PlayerPedId(), data.coords)
    --     end
    -- end
end, true)

Event:Register('dwb:mechanic:vehicle:fix', function(netId)
    local veh = NetworkGetEntityFromNetworkId(netId)
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(veh, 0.0, 3.0, 0.0)
    local heading = GetEntityHeading(veh)
    TaskGoStraightToCoord(ped, coords, 2.0, 5000, heading-(179+1), 4)
    Wait(200)
    Wait(5000)
    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading-180)
    Animation:Play(ped, 'mini@repair', 'fixing_a_player', 8.0, 3.0, -1, 1, 1.0, false, false, false)
    SetVehicleDoorOpen(veh, 4, false, false)
end, true)