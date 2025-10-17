
-- local blips = {}
-- local colors = {
--     ['USA'] = 29,
--     ["RU"] = 75,
--     ['EQUAL'] = 66
-- }

-- Event:Register('dwb:zones:state', function(name)
--     for k,v in pairs(Zones.Zones) do
--         if v.name == name then
--             v.disable=not v.disable
--         end
--     end
-- end, true)

-- Event:Register("dwb:zones:blip", function(zone, team)
--     for k,v in pairs(blips) do
--         if v.zone == zone then
--             SetBlipColour(blip --[[ Blip ]],colors[team])
--         end
--     end
-- end,true)

-- Event:Register('dwb:team:chosen', function(team, whitelist)
--     Marker:Add('zones', {
--         messages = {},
--         marker = {
--             type = 28,
--             color = {
--                 r = 20,
--                 g = 222,
--                 b = 222,
--                 a = 222
--             },
--             animate = true
--         },
--         settings = {
--             drawDist = 200,
--             radius = 40,
--             overrideCoords = true,
--             drawMarker = false
--         },
--         coords = Zones.Zones,
--         functions = {
--             onEnterCb = function(zone, pos)
--                 if pos.name and team and not pos.disable and not IsPedInAnyVehicle(PlayerPedId()) then
--                     Event:TriggerNet('dwb:zones:enter', pos.name, team)       
--                 end
--             end,
--             onExitCb = function(zone, pos)
--                 if pos.name and team and not pos.disable then
--                     Event:TriggerNet('dwb:zones:exit', pos.name, team)       
--                 end
--             end
--         }

--     })

--     for k,v in pairs(Zones.Zones) do
--         createBlip(v.label, v.name, v.pos, v.radius)
--     end

-- end, true)


-- function createBlip(name, zone, coords, radius)
--     local blip = AddBlipForCoord(coords)

--     SetBlipSprite(blip, 9)
--     -- SetBlipRotation(blip, math.ceil(data.heading))
--     -- SetBlipNameToPlayerName(blip, id)
--     SetBlipScale(blip, 0.85) -- set scale
--     SetBlipAsShortRange(blip, true)
--     SetBlipColour(blip --[[ Blip ]],39)

--     BeginTextCommandSetBlipName("STRING")

--     AddTextComponentString("! "..name)

--     EndTextCommandSetBlipName(blip)

--     table.insert(blips, {
--         blip = blip,
--         zone = zone
--     }) -- add blip to array so we can remove it later
-- end