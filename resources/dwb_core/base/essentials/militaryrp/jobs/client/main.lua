Event:Register('dwb:team:chosen', function(team)
    local coords = {}

    for n,m in pairs(Jobs.Spawners[team]) do
        table.insert(coords, m)
    end

    Marker:Add('jobs', {
        messages = {},
        marker = {
            type = 27,
            color = {
                r = 20,
                g = 222,
                b = 222,
                a = 222
            },
            animate = true
        },
        data = {
            team = team
        },
        settings = {
            drawDist = 50,
            radius = 2.5,
            overrideCoords = true,
            drawMarker = true
        },
        coords = coords,
        functions = {
            onExitCb = function(zoneData, posData)
                Menu:CloseAll() 
            end,
            onClickCb = function(zoneData, posData)
                local type = posData.type
                local zone = posData.zone
                local team = zoneData.data.team
                local spawn = posData.spawn
                local ped = PlayerPedId()
                if type == 'menu' then
                    if IsPedInAnyVehicle(ped) then 
                        Event:TriggerNet('dwb:jobs:vehicle:remove')
                    else
                        for k,v in pairs(Jobs.Vehicles[team]) do
                            if v.name == zone then
                                UI:Open('Menu', {
                                    name = zone,
                                    title = v.label,
                                    align = 'right',
                                    elements = v.categories 
                                }, function(data, menu)
                                    local category = data.current.type
                                    for k2,v2 in pairs(Jobs.VehCat[team]) do
                                        if v2.type == category then
                                            local elements = {}
                                            for m2, n2 in pairs(v2.vehicles) do
                                                if not n2.label then
                                                    n2.label = GetDisplayNameFromVehicleModel(GetHashKey(n2.model))
                                                end
                                                table.insert(elements, n2)
                                            end
                                            UI:Open('Menu', {
                                                name = zone..''..posData.index,
                                                title = v2.label,
                                                align = 'right',
                                                elements = elements
                                            }, function(data2, menu2)
                                                local model = data2.current.model
                                                local license = data2.current.license
                                                local heading = data2.current.heading
                                                local coords = spawn
                                                if not IsAnyVehicleNearPoint(coords, 10) then
                                                    Event:TriggerNet('dwb:jobs:vehicle:spawn', model, coords, heading, license)
                                                    Menu:CloseAll(menu, menu2)
                                                else
                                                    Notification:ShowCustom('info', 'Pojazdy', 'Zablokowane wyciąganie pojazdu')
                                                end
                                            end)
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        }
    })
end, true)