Core = class()

function Core:GetIdentifier(source, str)
    local identifiers = GetPlayerIdentifiers(source)
    local identifier

    for k, v in pairs(identifiers) do
        if v:match(str) then
            identifier = v
        end
    end

    return identifier
end

function Core:GetPlayerFromId(playerId, mt)
    return DWB.Players[tonumber(playerId)]
end

function Core:GetPlayerBy(key, value)
    for k, v in pairs(DWB.Players) do
        if v[key] == value then
            return v, k
        end
    end
end

function Core:GetPlayerFromIdentifier(identifier)
    local player = nil
    for k, v in pairs(DWB.Players) do
        if v.identifier == identifier then
            player = v
        end
    end
    return player
end

function Core:GetPlayers()
    return DWB.Players
end

function Core:GetClosestPlayer(coords, minDist, cb, ignore)
    local player, dist
    for k, v in pairs(DWB.Players) do
        local ped = GetPlayerPed(k)
        if ped then
            if not ignore or ignore ~= k then
                local pCoords = GetEntityCoords(ped)
                local distance = #(coords - pCoords)
                if not player then
                    player = v
                    dist = distance
                elseif distance <= dist then
                    player = v
                    dist = distance
                end
            end
        end
    end

    if not minDist then
        return player, dist
    elseif dist <= minDist then
        return player, dist
    end
end

function Core:GetClosestPlayers(coords, dist, cb)
    local t = {}
    for k, v in pairs(DWB.Players) do
        local ped = GetPlayerPed(k)
        if ped then
            local pCoords = GetEntityCoords(ped)
            local distance = #(coords - pCoords)
            if distance <= dist then
                if cb then
                    cb(k, v)
                end
                t[k] = v
            end
        end
    end
    return t
end

function Core:SetTimeout(msec, cb)
    local id = DWB.TimeoutCount + 1
    SetTimeout(msec, function ()
        if DWB.CancelledTimeouts[id] then
            DWB.CancelledTimeouts[id] = nil
        else
            cb()
        end
    end)
    DWB.TimeoutCount = id

    return id
end

function Core:ClearTimeout(id)
    DWB.CancelledTimeouts[id] = true
end

function Core:LoadItems(cb)
    Mysql.Async:fetchAll("SELECT * FROM items", {}, function (result)
        for k, v in ipairs(result) do
            v.ref = json.decode(v.ref)
            v.extra = json.decode(v.extra)
            DWB.Items[string.lower(v.name)] = v
        end
        if cb then
            cb()
        end
    end)
end

function Core:LoadJobs(cb)
    Job:LoadJobs(cb)
end

function Core:SavePlayers(all, cb2, cb4)
    local asyncTasks = {}
    local xPlayers = DWB.Players

    for k, v in pairs(xPlayers) do
        v.saving = true
        table.insert(asyncTasks, function (cb)
            local xPlayer = v
            xPlayer:SaveAll(function ()
                xPlayer:Saved()
            end)
        end)
    end

    if not all then
        Async:parallelLimit(asyncTasks, 8, function (results)
            RconPrint("[SAVED] All players" .. "\n")
            Event:Trigger("dwb:players:saved")

            for k, v in pairs(DWB.Players) do
                v.saving = nil
            end

            if cb4 ~= nil then
                cb4()
            end
        end)
    else
        Async:parallel(asyncTasks, function (results)
            for k, v in pairs(DWB.Players) do
                v.saving = nil
            end

            RconPrint("[SAVED] All players" .. "\n")
            Event:Trigger("dwb:players:saved")

            if cb4 ~= nil then
                cb4()
            end
        end)
    end
end

function Core:SyncPlayers()
    for k, v in pairs(DWB.Players) do
        v:ServerSync()
    end
end
