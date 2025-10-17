
-- local hash = GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET')
-- local ammo = 4
-- local currentAmmo = 4
-- local currveh = 0

-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)
--         local ped = PlayerPedId()
--         local veh = GetVehiclePedIsIn(ped)
--         if veh ~= 0 then
--             print(ammo)
--             if ammo > 0 then
--                 local ret, weaphash = GetCurrentPedVehicleWeapon(ped)
--                 print(ret, weaphash)
--                 if IsPedShooting(ped) and ret then
--                     if weaphash == hash then
--                         ammo = ammo -4
--                     end
--                 end
--             else
--                 print('x d')
--                 DisableControlAction(0, 70, true)
--             end
--         else
--             Wait(500)
--         end
--     end
-- end)

-- Event:Register('dwb:jobs:vehicle:spawned', function(veh)
--     local ped = PlayerPedId()
-- end, true)

