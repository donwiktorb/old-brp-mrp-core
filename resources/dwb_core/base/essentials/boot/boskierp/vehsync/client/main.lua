
local toggled = {}
local sounds = {}

Thread:Create(function()
    while true do
        local vehicles = GetGamePool('CVehicle')
        for i=1, #vehicles do
            local v = vehicles[i]
            local state = Entity(v).state
            if state.manage then
                if state.toggle then
                    SetVehicleHasMutedSirens(v, not state.muted)
                    SetVehicleSiren(v, state.toggle)
                    if not toggled[v] or toggled[v].state ~= state.state then
                        if not toggled[v] then
                            toggled[v] = {
                                state = state.state,
                                sound = 0
                            }
                        else
                            StopSound(toggled[v].sound)
                            ReleaseSoundId(toggled[v].sound)
                        end
                        toggled[v].state = state.state
                        if state.state == 2  then
                            SetVehicleHasMutedSirens(v, true)
                            local soundId = GetSoundId()
                            PlaySoundFromEntity(soundId, "RESIDENT_VEHICLES_SIREN_WAIL_03", v, 0, 0, 0)
                            toggled[v].sound = soundId
                        elseif state.state == 1 then
                            SetVehicleHasMutedSirens(v, true)
                            local soundId = GetSoundId()
                            PlaySoundFromEntity(soundId, "RESIDENT_VEHICLES_SIREN_QUICK_02", v, 0, 0, 0)
                            toggled[v].sound = soundId
                        -- -- elseif state.state == 1 then
                        -- --     SetVehicleHasMutedSirens(v, false)
                        elseif state.state == 3 then
                            local soundId = GetSoundId()
                            PlaySoundFromEntity(soundId, "SIRENS_AIRHORN", v, 0, 0, 0)
                            toggled[v].sound = soundId
                        end
                    end
                elseif toggled[v] then
                    SetVehicleSiren(v, false)
                    StopSound(toggled[v].sound)
                    ReleaseSoundId(toggled[v].sound)
                    toggled[v] = nil
                end
            end
        end

        Wait(500)
    end
end)

Event:Register('dwb:vehsync:sync', function(state)
    states = state
end, true)

Thread:Create(function()
    while true do
        Wait(0)
        for k,v in pairs(toggled) do
            if not DoesEntityExist(k) then
                -- -- print(v.sound, k)
                StopSound(v.sound)
                ReleaseSoundId(v.sound)
                toggled[k] = nil
            end
        end
        if DWB.PlayerData.InVehicle and DWB.PlayerData.IsDriver then
            local veh = DWB.PlayerData.Vehicle
			if GetVehicleClass(veh) == 18 then
                DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
                DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP 
                DisableControlAction(0, 173, true) -- INPUT_CELLPHONE_DOWN
                DisableControlAction(0, 174, true) -- INPUT_CELLPHONE_LEFT 
                --DisableControlAction(0, 175, true) -- INPUT_CELLPHONE_RIGHT 
                DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
                DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
                DisableControlAction(0, 21, true) -- INPUT_CHARACTER_WHEEL 
                DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
                DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM 

                DisableControlAction(0, 45, true) -- INPUT_VEH_CIN_CAM 
            
                SetVehRadioStation(veh, "OFF")
                SetVehicleRadioEnabled(veh, false)

                if IsDisabledControlJustReleased(0, 85) then
                    Event:TriggerNet('dwb:vehsync:toggle', NetworkGetNetworkIdFromEntity(veh), 'toggle')
                    -- if states[veh] then
                    --     SetVehicleSiren(veh, false)
                    --     states[veh] = nil
                    -- else
                    --     SetVehicleSiren(veh, true)
                    --     states[veh] = true
                    -- end
                    -- SetVehicleHasMutedSirens(veh, true)
				elseif IsDisabledControlJustReleased(0, 19) then
                    Event:TriggerNet('dwb:vehsync:toggle', NetworkGetNetworkIdFromEntity(veh), 'muted')
				-- elseif IsDisabledControlJustReleased(0, 45) then
				elseif IsDisabledControlJustReleased(0, 172) then
                    Event:TriggerNet('dwb:vehsync:state', NetworkGetNetworkIdFromEntity(veh), 'muted')
                end

				if IsDisabledControlPressed(0, 86) then
                    if not Entity(veh).state.horn then
                        Event:TriggerNet('dwb:vehsync:horn', NetworkGetNetworkIdFromEntity(veh), true)
                    end
                else
                    if Entity(veh).state.horn then
                        Event:TriggerNet('dwb:vehsync:horn', NetworkGetNetworkIdFromEntity(veh), false)
                    end
                end
            end
        end
    end
end)