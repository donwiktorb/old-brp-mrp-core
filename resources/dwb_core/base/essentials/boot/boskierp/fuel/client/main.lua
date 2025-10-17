Thread:Create(function()
    if true then
        return
    end
    local lastCoords
    while true do
        Wait(10000)
        if DWB.PlayerData.InVehicle and DWB.PlayerData.IsDriver then
            local veh = DWB.PlayerData.Vehicle
            if veh then
                local coords = GetEntityCoords(veh)
                if not lastCoords then 
                    lastCoords = coords
                end

                local dist = #(coords-lastCoords)

                local fuel = Entity(veh).state.fuel or GetVehicleFuelLevel(veh)

                -- if fuel == nil then
                --     fuel = GetVehicleFuelLevel(veh)
                --     Event:TriggerNet('dwb:fuel:sync', NetworkGetNetworkIdFromEntity(veh), fuel)
                -- else
                --     SetVehicleFuelLevel(veh, fuel)
                -- end 

                if dist >= 1000.0 then
                    local maxFuel = GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume")

                    local percent = (fuel/maxFuel)*100
                    
                    if percent <= 25.0 then
                        Notification:ShowCustom("info", TR("vehicle"), TR("low_fuel"))
                    end

                    if fuel < 10.0 then
                        SetVehicleFuelLevel(veh, 0.0)
                    else
                        SetVehicleFuelLevel(veh, fuel-4.0)
                    end
                    Event:TriggerNet('dwb:fuel:sync', GetVehicleFuelLevel(veh))
                    lastCoords = coords
                end
            end
        elseif lastCoords then
            lastCoords = nil
        end
    end
end)

local fillEnt = nil
local money = 0

Event:Register('dwb:fuel:fill:start', function(entId, entId2)
    money = entId2.pc
    local ped = PlayerPedId()
    local bone = GetPedBoneIndex(ped, 28422)
    local entity = NetworkGetEntityFromNetworkId(entId)
    fillEnt = entity
    N_0xb2d0bde54f0e8e5a(entity, true)
    AttachEntityToEntity(entity)
    AttachEntityToEntity(entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 4, 1) 
    local vehActions = LocalPlayer.state.vehicleActions or {}
    table.insert(vehActions, 
        {
            value = 'fill-vehicle-fuel',
            removeAfter = true,
            id = 'fuel',
            label = 'Zatankuj pojazd'}
        )
    LocalPlayer.state.vehicleActions = vehActions
end, true)

local fill = false

function startFill()
    Thread:Create(function()
        while fill do
            Wait(1000)
            local veh = fill
            local maxFuel = GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume")
            local fuel = GetVehicleFuelLevel(veh)
            local percent = (fuel/maxFuel)*100
            Entity(fill).state.description = math.floor(percent).."% Paliwa"
            if percent >= 100 and fill then
                DeleteEntity(fillEnt)
                Entity(fill).state.description = nil
                LocalPlayer.state.vehicleActions = nil
                fill = false
            elseif fill then
                SetVehicleFuelLevel(veh, fuel+5.0)
                Event:TriggerNet('dwb:fuel:sync', NetworkGetNetworkIdFromEntity(veh), fuel+5.0)
            end
            Event:TriggerNet('dwb:fuel:pay', money, NetworkGetNetworkIdFromEntity(veh), fuel)
        end
    end)
end

Event:Register('dwb:fuel:fill:fill', function(entId)
    local ped = PlayerPedId()
    local bone = GetPedBoneIndex(ped, 28422)
    local entity = NetworkGetEntityFromNetworkId(entId)

    fill = entity
    startFill()
end, true)

Event:Register('dwb:fuel:fill:stop', function()
    DeleteEntity(fillEnt)
    if fill then
    Entity(fill).state.description = nil
    end
    LocalPlayer.state.vehicleActions = nil
    fill = false
end, true)