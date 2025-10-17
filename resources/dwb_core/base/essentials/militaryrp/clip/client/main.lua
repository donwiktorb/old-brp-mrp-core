
Event:Register('dwb:clip:use', function()
    local ped = PlayerPedId()
    if IsPedArmed(ped, 4) then
        local hash = GetSelectedPedWeapon(ped)
        if hash ~= nil then
            AddAmmoToPed(ped, hash, 128)
            Notification:Show('Użyłeś magazynku.')
            Event:TriggerNet('dwb:clip:use')
        else
            Notification:Show('Nie posiadasz broni w rękach.')
        end
    else
        Notification:Show('Nie posiadasz broni w rękach.')
    end
end, true)

Event:Register('dwb:bp:use', function()

    local ped = PlayerPedId()
            Stream:RequestAnimDict("clothingshirt", function()
                TaskPlayAnim(ped, "clothingshirt", "try_shirt_positive_a", 8.0, 3.0, 1, 0, 1, false, false, false)
            end)
            -- SetPedComponentVariation(ped, 9, 27, 9, 2)
            SetPedArmour(ped, 200)
end, true)

Event:Register('dwb:fixkit:use', function()

  local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			FreezeEntityPosition(playerPed, true)
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				--local veh2 = GetVehicleEngineHealth(vehicle --[[ Vehicle ]])
				--SetVehicleEngineHealth(vehicle, veh2 + 200)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				Notification:Show('Pojazd naprawiony')
				FreezeEntityPosition(playerPed, false)
			end)
		end
	end
end, true)