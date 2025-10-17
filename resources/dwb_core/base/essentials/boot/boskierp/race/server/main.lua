
-- -- Citizen.CreateThread(function()
-- --     for k,v in pairs(Config.Race.Points) do
-- --         for k2,v2 in pairs(v.checkpoints) do
-- --             if v2.radius then
-- --                 -- Define the middle coordinates
-- --                 local middleX = v2.coord.x
-- --                 local middleY = v2.coord.y
-- --                 local middleZ = v2.coord.z

-- --                 -- Define the radius
-- --                 local radius = v2.radius

-- --                 -- Calculate random azimuth and inclination angles
-- --                 local azimuth = math.random() * 2 * math.pi
-- --                 local inclination = math.acos(2 * math.random() - 1)

-- --                 -- Convert spherical coordinates to Cartesian coordinates
-- --                 local startX = middleX + radius * math.sin(inclination) * math.cos(azimuth)
-- --                 local startY = middleY + radius * math.sin(inclination) * math.sin(azimuth)
-- --                 -- -- local startZ = middleZ + radius * math.cos(inclination)
-- --                 local startZ = middleZ

-- --                 local endX = middleX - radius * math.sin(inclination) * math.cos(azimuth)
-- --                 local endY = middleY - radius * math.sin(inclination) * math.sin(azimuth)
-- --                 -- -- local endZ = middleZ - radius * math.cos(inclination)
-- --                 local endZ = middleZ
-- --                 v2.coords = {
-- --                     vector3(startX, startY, startZ),
-- --                     vector3(endX, endY, endZ)
-- --                 }
-- --                 -- -- table.insert(v2.coords, {
-- --                 -- -- })
-- --             end
-- --         end
-- --     end
-- -- end)

Mysql:onReady(function()
    local races = Mysql.Sync:fetchAll('SELECT * FROM races')
    for k,v in pairs(races) do
        local checkpoints = json.decode(v.checkpoints)
        for k,v in pairs(checkpoints) do
            v.coords = vec3(v.coords.x, v.coords.y, v.coords.z)
        end
        table.insert(Config.Race.Points[v.race].checkpoints, {
            label = v.id..' '..v.label,
            id = v.id,
            owner = v.owner,
            values = checkpoints
        })
    end
end)

Command:Register('race', {'id, delete'}, function(xPlayer, args)
    if args[1] == 'delete' then
        local id = tonumber(args[2])
        for k,v in pairs(Config.Race.Points) do
            for k2,v2 in pairs(v.checkpoints) do
                if v2.id and v2.id == id and (v2.owner and v2.owner == xPlayer.charId or xPlayer.group) then
                    table.remove(v.checkpoints, k2)
                    Mysql.Async:Execute('DELETE FROM races WHERE id = ?', {
                        id
                    })
                end
            end
        end
    end
end)

function getRaceById(id)
    return Config.Race.Points[id]
end

function getRacePlayerById(race, id)
    for k,v in pairs(Config.Race.Points[race].players) do
        if v.source== id then
            return v  
        end
    end
end

function getRaceByPlayer(id)
    for k,v in pairs(Config.Race.Points) do
        for k2,v2 in pairs(v.players) do
            if v2.source == id then
                return v
            end
        end
    end
end

User:OnCustomEvent('race', function(self, zoneData, posData)
    local data = posData.data
    local elements = {}
    for k,v in pairs(Config.Race.Points) do
        if v.host then
            table.insert(elements, {
                label = "("..v.name..")" .. " min. "..v.wage.." " ..v.label.." ",
                value = k,
                race = k
            })
        end
    end
    Event:TriggerNet('dwb:race:open', self.source, data.race, elements)
end)

Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    if action.name == 'race' and data.current.value == 'host' then
        local raceId = entData.race
        local race = getRaceById(raceId)
        if race and not race.host then
            local road = {}
            for k,v in pairs(Config.Race.Points[raceId].checkpoints) do
                table.insert(road, {
                    label = v.label,
                    value = k,
                    name = 'checkpoint'
                })
            end
            local item = xPlayer:GetInventoryItem('cash')
            Event:TriggerNet('dwb:race:host', source, raceId, road, item and item.count or 0, #race.startPoints)
        else
            xPlayer:ShowNotify('info', TR("race"), TR("hosting"))
        end
    elseif action.name == 'race' and data.current.value == 'race-join' then
        local player = getRacePlayerById(data.current.race, source)
        if player then

        else
            local race = getRaceById(data.current.race)
            local money = xPlayer:GetInventoryItem('cash')
            if money.count >= race.wage and #race.players < #race.startPoints  then
                local veh = GetVehiclePedIsIn(GetPlayerPed(source), true)
                if not veh then
                    return xPlayer:ShowNotify('info', 'Wysicg', 'Wysiadz z pojazdu lub znajdz sobie pojazd')
                end

                table.insert(getRaceById(data.current.race).players, {
                    source = source,
                    vehicle = GetVehiclePedIsIn(GetPlayerPed(source), true)
                })
                xPlayer:RemoveInventoryItem('cash', race.wage)
            end
        end
    elseif action.name == 'race' and data.current.value == 'custom' then
        Event:TriggerNet('dwb:race:custom', source, entData.race)
    end
end, true)




Event:Register('dwb:race:create', function(source, xPlayer, current, raceId)
        local race = getRaceById(raceId)
        if race and not race.host then
            local road = {}
            for k,v in pairs(Config.Race.Points[raceId].checkpoints) do
                table.insert(road, {
                    label = v.label,
                    value = k,
                    name = 'checkpoint'
                })
            end
            local item = xPlayer.inventory:GetItem('cash', 'name')
            Event:TriggerNet('dwb:race:host', source, raceId, road, item and item.count or 0, #race.startPoints)
        else
            xPlayer:ShowNotify('info', TR("race"), TR("hosting"))
        end
end ,    true)

Event:Register('dwb:race:create:custom', function(source, xPlayer, current, race)



        Event:TriggerNet('dwb:race:custom', source, race)
end ,    true)

Event:Register('dwb:race:join', function(source, xPlayer, current)
     local player = getRacePlayerById(current.race, source)
        if player then

        else
            local race = getRaceById(current.race)
            local money = xPlayer.inventory:GetItem('cash', 'name')
            if money.count >= race.wage and #race.players < #race.startPoints  then
                local veh = GetVehiclePedIsIn(GetPlayerPed(source), true)
                if not veh then
                    return xPlayer:ShowNotify('info', 'Wysicg', 'Wysiadz z pojazdu lub znajdz sobie pojazd')
                end

                table.insert(getRaceById(current.race).players, {
                    source = source,
                    vehicle = GetVehiclePedIsIn(GetPlayerPed(source), true)
                })
                xPlayer.inventory:RemoveItem('cash', 'name', race.wage)
            end
        end
end ,    true)

Event:Register('dwb:custom:save', function(source, xPlayer,checkpoints, raceId, label)
    local source = source
    local insertId = Mysql.Sync:Insert('INSERT INTO races SET ?', {
        owner = xPlayer.charId,
        race = raceId,
        label = label and label..'#'..source..'@'..xPlayer.charId or xPlayer.char.firstname..' '..xPlayer.char.lastname,
        checkpoints=json.encode(checkpoints)
    })
    table.insert(Config.Race.Points[raceId].checkpoints, {
        label = label and insertId..' '..label..'#'..source..'@'..xPlayer.charId or insertId.. ' '..xPlayer.char.firstname..' '..xPlayer.char.lastname,
        values = checkpoints
    })
end, true)

Event:RegisterCb('dwb:race:get', function(source, xPlayer,s,cb)
    local elements = {}
    for k,v in pairs(Config.Race.Points) do
        if v.host then
            table.insert(elements, {
                label = "("..v.name..")" .. " min. "..v.wage.." " ..v.label.." "..s,
                value = k,
                race = k
            })
        end
    end
    cb(elements or{})
end, true)
Event:Register('dwb:race:host', function(source, xPlayer,raceId, data)
    local veh = GetVehiclePedIsIn(GetPlayerPed(source), true)
    if not veh then
        return xPlayer:ShowNotify('info', 'Wysicg', 'Wysiadz z pojazdu lub znajdz sobie pojazd')
    end
    local xPlayer = xPlayer
    local name = data.name
    local wage = data.wage
    local time = data.time
    local roadId = data.roadId
    local race = getRaceById(raceId)
    race.host = source
    race.name = name
    race.wage = wage
    race.time = time
    race.roadId = roadId
    table.insert(race.players, {
        source = source,
        vehicle = veh
    })

    xPlayer:ShowNotify('info', TR("race"), TR("hosting"))
    xPlayer:ShowNotify('info', TR("race"), TR("starts_in_minute"))

    SetTimeout(1000*60*race.time, function()
        -- if #race.players <= 1 then
        --     xPlayer:AddInventoryItem(false, 'cash', race.wage)
        --     race.host = nil
        --     race.players = {}
        --     race.name = nil
        --     race.wage = nil
        -- end
        for k,v in pairs(race.startPoints) do
            local player = race.players[k]
            if player then
                SetEntityCoords(player.vehicle, v)     
                SetPedIntoVehicle(GetPlayerPed(player.source), player.vehicle, -1)
                SetEntityHeading(player.vehicle, race.startHeading+0.0)
                FreezeEntityPosition(player.vehicle, true)
                Event:TriggerNet('dwb:race:ready', player.source, race.checkpoints[roadId].values)
            end
        end
    end)

end, true)

-- User:OnExit(function(self)
--     for k,v in pairs(Config.Race.Points) do
--         if v.host == self.source then
--             v.host = nil
--             v.players = {}
--             v.wage = nil
--             v.name = nil
--         end
--     end
-- end)

Event:Register('dwb:race:won', function(source, xPlayer)
    local race = getRaceByPlayer(source)
    if race then
        for k,v in pairs(race.players) do
            xPlayer:AddInventoryItem(false,'cash', race.wage)
            Event:TriggerNet('dwb:race:won', v.source)
            Event:TriggerNet('dwb:notify:show', v.source, 'info', 'Wyscigi','Wygral '..xPlayer.char.firstname.. ' '..xPlayer.char.lastname)
        end
        race.host = nil
        race.players = {}
        race.name = nil
        race.wage = nil
    end
end, true)