
 Citizen.CreateThread(function()
	local getVeh = GetVehiclePedIsIn
	local getSeat = GetPedInVehicleSeat
	local isSeatFree = IsVehicleSeatFree
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(1, 303) then
			ToggleEngine()
		end
		local ped = PlayerPedId()

		local vehicle = getVeh(ped, false)

		if (getSeat(vehicle, -1) == ped) or isSeatFree(vehicle, -1) then
			local engine = 	GetIsVehicleEngineRunning(vehicle)
			local InVehicle = IsPedInAnyVehicle(ped, false)
			local model = GetEntityModel(vehicle)
			SetVehicleEngineOn(vehicle, engine, true, false)
			SetVehicleJetEngineOn(vehicle, engine)
			if not InVehicle or (InVehicle and vehicle ~= GetVehiclePedIsIn(ped, false)) then
				if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
					if engine then
						SetHeliBladesFullSpeed(vehicle)
					end
				end
			end
		end
	end
end)

-- function draw(text, color) 
-- 	BeginTextCommandThefeedPost("STRING")
-- 	AddTextComponentSubstringPlayerName(text)
-- 	ThefeedNextPostBackgroundColor(color)
-- 	PlaySound(-1, "SELECT", 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1);
-- 	ThefeedSetAnimpostfxCount(1)
-- 	ThefeedSetAnimpostfxColor(34, 138, 21, 255)
-- 	EndTextCommandThefeedPostTicker(true, true)
-- end

function ToggleEngine()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	local InVehicle = IsPedInAnyVehicle(ped, false)
	local model = GetEntityModel(veh)
	local runing = GetIsVehicleEngineRunning(veh)

	Citizen.Wait(1100)

	
	if InVehicle then 
		if (GetPedInVehicleSeat(veh, -1) == ped) then

            if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
			    SetVehicleEngineOn(veh, not runing, true, true)
			    SetVehicleJetEngineOn(veh, not runing)
                SetHeliBladesFullSpeed(veh)
            else
			    SetVehicleEngineOn(veh, not runing, false, true)
            end

			local engine = GetIsVehicleEngineRunning(veh)

			if engine then
				Notification:ShowCustom("info", "Silnik", "Włączyłeś silnik.")
				-- draw("Silnik włączony", 184)
			else
				Notification:ShowCustom("info", "Silnik", "Wyłączyłeś silnik.")
				-- draw("Silnik wyłączony", 6)
			end
		end 
    end 
end
