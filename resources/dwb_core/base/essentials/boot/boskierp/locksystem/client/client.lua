Event:Register('dwb:keys:lock', function(locked)
    local ped = PlayerPedId()
    local lib = 'anim@mp_player_intmenu@key_fob@'
    local anim = 'fob_click'

    Stream:RequestAnimDict(lib, function()
        TaskPlayAnim(ped, lib, anim, 8.0, -8.0, 1500, 48, 0, false, false, false)
    end)

    if locked then
        Notification:ShowCustom('info', TR("keys"), TR("closed_vehicles"))
        Event:TriggerNet("dwb:sounds:play:distance", 10, "lockk", 0.8)
    else
        Notification:ShowCustom('info', TR("keys"), TR("opened_vehicle"))
        Event:TriggerNet("dwb:sounds:play:distance", 10, "lockk", 0.8)
    end

    
end, true)

Key:onJustPressed('L', 'Klucze do auta (L)' ,function()
    local ped = PlayerPedId()
    local isInVeh = false
    local vehicle, distance = Vehicle:GetInDirection(), 0

    if IsPedInAnyVehicle(ped, true) then vehicle = GetVehiclePedIsIn(ped, false) distance = 0 isInVeh = true end

    if not vehicle then
        vehicle, distance = Vehicle:GetClosest(GetEntityCoords(ped))
    end

    if vehicle and distance <= 4 then
       
        local plate = GetVehicleNumberPlateText(vehicle)

        Event:TriggerCb('dwb:ls:check:owned', function(owned)
            if owned then
                local locked = GetVehicleDoorLockStatus(vehicle)

                if locked == 1 then
                    SetVehicleDoorsLocked(vehicle, 4)
                    Notification:ShowCustom('info', TR("keys"), TR("closed_vehicles"))
                    Event:TriggerNet("dwb:sounds:play:distance", 10, "lockk", 0.8)
                else
                    SetVehicleDoorsLocked(vehicle,  1)
                    Notification:ShowCustom('info', TR("keys"), TR("opened_vehicle"))
                    Event:TriggerNet("dwb:sounds:play:distance", 10, "lockk", 0.8)
                end

                local lib = 'anim@mp_player_intmenu@key_fob@'
                local anim = 'fob_click'

                Stream:RequestAnimDict(lib, function()
                    TaskPlayAnim(ped, lib, anim, 8.0, -8.0, 1500, 48, 0, false, false, false)
                end)

            end
        end, plate, isInVeh)
    end
end)


















Event:Register('dwb:player:vehicle:entering', function(veh, seat)
    if veh ~= 0 then
            local lock = GetVehicleDoorLockStatus(veh)
            if lock == 4 then
                ClearPedTasks(DWB.PlayerData.Ped) print(lock)
            end
    end
end)

-- -- Thread:Create(function()
-- --     -- local getTrying = GetVehiclePedIsTryingToEnter
-- -- 	while true do
-- -- 		Wait(0)
-- --         -- local ped = PlayerPedId()
-- --         -- local veh = getTrying(ped)
-- --         local veh = DWB.PlayerData.TryingToEnterVehicle
-- --         if veh ~= 0 then
-- -- 	        local lock = GetVehicleDoorLockStatus(veh)
-- -- 	        if lock == 4 then
-- -- 	        	ClearPedTasks(DWB.PlayerData.Ped)
-- -- 	        end
-- --         end
-- -- 	end
-- -- end)