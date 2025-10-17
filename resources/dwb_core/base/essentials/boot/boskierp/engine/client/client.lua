
function fromKmToMs(time)
    return time * (1/3600)
end
function fromMsToKm(time)
    return time * 3.6
end
function calculateImpactForce(m,v,t, s)
    local e = ((m*(v^2)))/2
    return e/s
    -- return (m*v)/(2*t)
end

Thread:Create(function()
    if true then return
end
    local lastEngine
    local lastTime = GetGameTimer()
    local lastCoords = DWB.PlayerData.Coords
    while true do
        Wait(0)
        if DWB.PlayerData.InVehicle then
            SetVehicleStrong(DWB.PlayerData.Vehicle, true)
            local m = GetVehicleHandlingFloat(DWB.PlayerData.Vehicle, "CHandlingData", "fMass")
            -- local v = fromKmToMs(GetEntitySpeed(DWB.PlayerData.Vehicle)) -- m/s
            local v = GetEntitySpeed(DWB.PlayerData.Vehicle)
            local time = GetGameTimer()
            local t = fromKmToMs(time-lastTime)
            -- print((m*v)/2*t, t)
            local coord = DWB.PlayerData.Coords
            local d = #(lastCoords  - coord)
            lastCoords = coord
            lastTime = time
            if HasEntityCollidedWithAnything(DWB.PlayerData.Vehicle) then
                local engine = GetVehicleEngineHealth(DWB.PlayerData.Vehicle)
                local force = calculateImpactForce(m,v,t, d)

                local newEng = engine-(force/500000)
                if newEng > 100 then
                    SetVehicleEngineHealth(DWB.PlayerData.Vehicle, newEng)
                else
                    SetVehicleUndriveable(DWB.PlayerData.Vehicle, true)
                end
            end
            
            -- print(HasEntityCollidedWithAnything(DWB.PlayerData.Vehicle))
                        -- -- local class = GetVehicleClass(DWB.PlayerData.Vehicle)
            -- -- if not Config.Engine.Class[class] then
            -- --     local entity = DWB.PlayerData.Vehicle
            -- --     SetVehicleWheelsCanBreak(entity, true)
            -- --     local engine = GetVehicleEngineHealth(entity)
            -- --     if lastEngine then

                    

            -- --         local d = engine*0.5
            -- --         if d <= 100.0 then
            -- --             local newd = 100.0
            -- --             SetVehicleEngineHealth(entity, newd)
            -- --             SetVehicleUndriveable(entity,false)
            -- --         end
            -- --         -- -- local difference = lastEngine - engine
            -- --         -- -- print(difference, lastEngine, engine)
            -- --         -- -- if difference > 0 and engine > 100 then
            -- --         -- --     local newd = difference * 10.0
            -- --         -- --     SetVehicleEngineHealth(entity, newd)
            -- --         -- -- 	SetVehicleUndriveable(entity,false)
            -- --         -- -- elseif engine <= 100 then
            -- --         -- --     local newd = 100.0
            -- --         -- --     SetVehicleEngineHealth(entity, newd)

            -- --         -- -- 	SetVehicleUndriveable(entity,true)
            -- --         -- -- end
            -- --     end
            -- --     lastEngine = engine

            -- --     -- -- local body = GetVehicleBodyHealth(entity)
            -- --     -- -- SetVehicleBodyHealth(entity, 0)
            -- -- end
        elseif lastEngine then
            lastEngine = nil
        end
    end
end)

Event:Register('dwb:player:vehicle:enter', function(veh)
    print('x d')
    SetPedConfigFlag(PlayerPedId(), 429, true)
    SetPedConfigFlag(PlayerPedId(), 184, true)
    SetPedConfigFlag(PlayerPedId(), 35, true)
    SetPedConfigFlag(PlayerPedId(), 32, true)
    SetPedConfigFlag(PlayerPedId(), 248, true)
    SetPedConfigFlag(PlayerPedId(), 241, true)
    if GetPedInVehicleSeat(veh, 0) == PlayerPedId() then
        SetPedIntoVehicle(PlayerPedId(), veh, 0)
    end
end)

Event:Register('dwb:player:thread:start', function()
    print('x d')
    SetPedConfigFlag(PlayerPedId(), 429, true)
    SetPedConfigFlag(PlayerPedId(), 248, true)
    SetPedConfigFlag(PlayerPedId(), 241, true)
    -- SetPedConfigFlag(PlayerPedId(), 241, true)
end)

Key:onJustReleased('U', "Odpal silnik", function()
    ToggleEngine()
end)

Event:Register('dwb:keys:engine', function()
    ToggleEngine()
end, true)

function ToggleEngine()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	local InVehicle = IsPedInAnyVehicle(ped, false)
	local model = GetEntityModel(veh)
	local runing = GetIsVehicleEngineRunning(veh)

	if InVehicle then 
		if (GetPedInVehicleSeat(veh, -1) == ped) then
            local engine = GetVehicleEngineHealth(veh)
                if engine == 100.0 then return end
            
            if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
			    SetVehicleEngineOn(veh, not runing, true, true)
			    SetVehicleJetEngineOn(veh, not runing)
                SetHeliBladesFullSpeed(veh)
            else
			    SetVehicleEngineOn(veh, not runing, false, true)
            end

			-- local engine = GetIsVehicleEngineRunning(veh)

			if not runing then
				Notification:ShowCustom("info", TR("engine"), TR("engine_on"))
			else
				Notification:ShowCustom("info", TR("engine"), TR("engine_off"))
			end
		end 
    end 
end
