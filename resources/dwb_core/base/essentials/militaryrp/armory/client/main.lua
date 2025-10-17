
Event:Register('dwb:team:chosen', function(team)
    local coords = {}

    for n,m in pairs(Armory.Armories[team]) do
        table.insert(coords, m)
    end

    Marker:Add('armories', {
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
                local shop = {
                    name = 'armory',
                    label = 'Zbrojownia',
                    weight = 0.0,
                    maxWeight = 0.0,
                    items = {}
                }
                for k,v in pairs(Armory.Weapons[team]) do
                    if v.name == zone then
                        shop.items = v.weapons     
                    end
                end
                UI:ShowInventory2(shop)
            end
        }
    })
end, true)

-- -- Event:Register('dwb:print:me', function(...)
-- --     local args = {...}
-- --     print(table.concat(args, ' '))
-- -- end)

-- -- RegisterCommand('bombs', function()
-- --     local ped = PlayerPedId()
-- --     local veh = GetVehiclePedIsIn(ped)
-- --     local count = GetVehicleBombCount(veh)
-- --     local count2 = GetVehicleCountermeasureCount(veh)
-- --     Event:Trigger('dwb:print:me', count, count2)
-- -- end)