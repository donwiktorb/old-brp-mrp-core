Event:Register('dwb:jobs:vehicle:spawn', function(model, coords, heading, license)
    local xPlayer = DWB.Players[source]
    if not license or xPlayer:HasLicense(license) then 
        local heading = heading or 200

        local ped = GetPlayerPed(source)
        Vehicle:Spawn(model, coords, heading, function(veh)
            TaskWarpPedIntoVehicle(ped, veh, -1)
            Event:TriggerNet('dwb:jobs:vehicle:spawned', source, veh)
        end)    
    else
        xPlayer:ShowNotify('info', 'Pojazdy', 'Nie masz licencji '..license..' na ten pojazd!')
    end
end, true)

Event:Register('dwb:jobs:vehicle:remove', function()
    local xPlayer = DWB.Players[source]
    local ped = GetPlayerPed(source)
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= 0 then
        Vehicle:Delete(veh)
    end
end, true)