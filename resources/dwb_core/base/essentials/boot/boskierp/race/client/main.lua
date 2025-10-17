


local making = false

Event:Register('dwb:race:custom', function(raceId)
    ActivateFrontendMenu(-1171018317, 0, -1)
    SendNuiMessage(json.encode({
        show = true,
        type = 'Notify2',
        action = 'open',
        data = {
            show = true,
            content = string.format("Tworzysz wyścig, na tabie zaznaczaj <k>TAB</k>, aby stworzyć checkpoint (tam gdzie marker). Naciśnij <k>X</k>, aby anulować. Naciśnij <k>G</k>, aby zapisać wyścig.")
        }
    }))
    making = true
    local cancel = false
    while making do
        Wait(0)
        if IsControlJustPressed(0, 73) then
            cancel = true
            making = false
        elseif IsControlJustPressed(0, 47) then
            making = false
        end
    end
    SendNuiMessage(json.encode({
        show = true,
        type = 'Notify2',
        action = 'close',
        data = {
            show = true,
            content = string.format("Tworzysz wyścig, na tabie zaznaczaj <k>TAB</k>, aby stworzyć checkpoint (tam gdzie marker). Naciśnij <k>X</k>, aby anulować. Naciśnij <k>G</k>, aby zapisać wyścig.")
        }
    }))
    if not cancel then
        local coords = GetEntityCoords(PlayerPedId())
        local checkpoints = {}
        local stop = false
        local blipInfo = GetFirstBlipInfoId(162)
        local blipCoords = GetBlipCoords(blipInfo)
        RequestCollisionAtCoord(blipCoords.x, blipCoords.y, 40.0)
        RequestAdditionalCollisionAtCoord(blipCoords.x, blipCoords.y, 40.0)
        local found, groundZ, norm = GetGroundZFor_3dCoord_2(blipCoords.x, blipCoords.y, 40.0, true) 
        if found then
            Log:Info('Found ground', groundZ)
            blipCoords = vec3(blipCoords.x, blipCoords.y, groundZ) 
        else
            blipCoords = vec3(blipCoords.x, blipCoords.y, 30.0) 
        end
                SetEntityCoords(PlayerPedId(), blipCoords)

                while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                    Log:Info("[SPAWN]", "Waiting for collisions" )
                    Wait(0)
                    end
        table.insert(checkpoints, {
            checkpoint = 4,
            blip = 4,
            coords = blipCoords,
            radius = 10.0,
        })
        RemoveBlip(blipInfo)
        while not stop do
            local blip = GetNextBlipInfoId(162)
            Wait(0)
            if blip == 0 then
                stop = true
                checkpoints[#checkpoints].blip = 4
            else
                local blipCoords2 = GetBlipCoords(blip)
                SetEntityCoords(PlayerPedId(), blipCoords2)
                RequestCollisionAtCoord(blipCoords2.x, blipCoords2.y, 50.0)
                RequestAdditionalCollisionAtCoord(blipCoords2.x, blipCoords2.y, 50.0)
                SetEntityCoords(PlayerPedId(), blipCoords2)

                while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                    RequestCollisionAtCoord(blipCoords2.x, blipCoords2.y, 100.0)
                    RequestAdditionalCollisionAtCoord(blipCoords2.x, blipCoords2.y, 100.0)
                    Log:Info("[SPAWN]", "Waiting for collisions" )
                    Wait(0)
                    end
                local found, groundZ, norm = GetGroundZFor_3dCoord_2(blipCoords2.x, blipCoords2.y, 100.0, true) 
                if found then
                    Log:Info('Found ground', groundZ)
                    blipCoords2 = vec3(blipCoords2.x, blipCoords2.y, groundZ) 
                else
                    blipCoords2 = vec3(blipCoords2.x, blipCoords2.y, 30.0) 
                end
                table.insert(checkpoints, {
                    checkpoint = 2,
                    blip = 4,
                    coords = blipCoords2,
                    radius = 10.0,
                })
                RemoveBlip(blip)
                
            end
        end

        SetEntityCoords(PlayerPedId(), coords)

        UI:Open('MenuDialog', {
            name = 'race-name',
            align = 'center',
            title = 'Nazwa wyścigu',
        }, function(data,menu)
            menu.close()
            Event:TriggerNet('dwb:custom:save', checkpoints, raceId, data.current.value)
        end, function(data,menu)
            menu.close()
            Event:TriggerNet('dwb:custom:save', checkpoints, raceId)
        end)
    end
end, true)


Event:Register('dwb:race:host', function(race, road, maxWage, places)
    UI:Open('MenuSide', {
        name = 'race',
        side="right",
        main=0,
        title = "Wyscig "..places..' miejsc',
        show = true,
        elements = {
            {
                type = 'input',
                name = 'name',
                label = 'Nazwa'
            },
            {
                type = 'number',
                name = 'wage',
                label = 'Stawka na wejscie',
                min = 0,
                max = maxWage
            },
            {
                type = 'number',
                name = 'time',
                label = 'Czas przed startem (minut)',
                min = 0,
                max = 20
            },
            {
                type = 'select',
                name = 'roadId',
                label = 'Wybierz trasę (customowe)',
                value = 0,
                options = road
            }
        }
    },function(data,menu)
        local elements = data.menu.elements
        local name = elements[1].value
        local wage = math.abs(tonumber(elements[2].value))
        local time = math.abs(tonumber(elements[3].value))
        local roadId = elements[4].value+1
        Event:TriggerNet('dwb:race:host', race, {
            wage = wage,
            name = name,
            time = time,
            roadId = roadId
        })
        menu.close()
    end)
end, true)

local checkpoints = {}

Event:Register('dwb:race:ready', function(data)
    checkpoints = data
    Scaleform:RaceCountdown(5, function()
        FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), false)
    end)
end, true)

Event:Register('dwb:race:won', function(data)
    for k,v in pairs(checkpoints) do

                    DeleteCheckpoint(v.check)
                    RemoveBlip(v.blip)
    end
    checkpoints = {}
end, true)

Thread:Create(function()
    while true do
        local sleep = 500
        for k,v in pairs(checkpoints) do
            sleep = 0
            if not v.check then
                v.check = CreateCheckpoint(1, v.coords, checkpoints[k+1] and checkpoints[k+1].coords or vec3(0,0,0), v.radius or 20.0, 222,222,222,222, 10)
                v.blip = AddBlipForCoord(v.coords)
                SetBlipColour(v.blip, 2)
                SetBlipAsShortRange(v.blip, true)
                ShowNumberOnBlip(v.blip, k)
                if k == 1 then
                    SetWaypointOff()
                    SetBlipRoute(v.blip, true)
                    SetBlipRouteColour(v.blip, 24)
                end
            end
            if k == 1 then
                local dist = #(DWB.PlayerData.Coords - v.coords)-10
                if dist <= 0 then
                    DeleteCheckpoint(v.check)
                    RemoveBlip(v.blip)
                    table.remove(checkpoints, k)
                    if #checkpoints <= 0 then
                        Event:TriggerNet('dwb:race:won')
                    else
                        local v = checkpoints[k]
                        SetWaypointOff()
                        SetBlipRoute(v.blip, true)
                        SetBlipRouteColour(v.blip, 24)
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

Event:Register('dwb:race:open', function(raceId, races)
    UI:Open('Menu', {
        name = 'race',
        title = "Wyścig",
        elements = {
            {
                label = "Dołącz",
                value = 'join'
            },
            {
                label = "Stwórz",
                value = 'create'
            },
            {
                label = "Stwórz custom",
                value = 'custom'
            }
        }
    },function(data,menu)
        menu.close()
        if data.current.value == 'join' then
    UI:Open('Menu', {
        name = 'race-join',
        title = "Wyścig",
        elements = races
    },function(data,menu)
        menu.close()
        Event:TriggerNet('dwb:race:join', data.current)
end)
        elseif data.current.value == 'create' then
            Event:TriggerNet('dwb:race:create', data.current, raceId)
        else
            print(json.encode(data.current))
            Event:TriggerNet('dwb:race:create:custom', data.current, raceId)
    end
end)
end    ,   true)