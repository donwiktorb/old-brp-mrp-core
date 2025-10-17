-- Event:Register('dwb:gps:make', function(netId, id)
--     if id == 1 then
--     RemoveBlip(netId)
--     end
-- end, true)

local gps = {}
-- -- Event:Register('dwb:gps:create', function(playerId)
-- --     local player = GetPlayerFromServerId(playerId)
-- --     local ped = GetPlayerPed(player)
-- --     local blip = AddBlipForEntity(ped)
-- --     if IsPedInAnyVehicle(ped) then

-- --     else
-- --         SetBlipSprite(blip, 3)
-- --     end
-- --     gps[playerId] = blip
-- -- end, true)

-- -- Event:Register('dwb:gps:remove', function(playerId)
-- --     RemoveBlip(gps[playerId])
-- --     gps[playerId] = false
-- -- end, true)

Event:Register('dwb:gps:clear', function(src, toggle)
    if gps[src] then
        RemoveBlip(gps[src].blip)
        gps[src] = nil
    end
end, true)

function createGpsBlip(v)
    local p = GetPlayerFromServerId(v.src)
    local pp = GetPlayerPed(p)
    
    if p ~= -1 and DoesEntityExist(pp) then
        v.blip = AddBlipForEntity(pp)
        v.type = 'ent'
    else
        v.blip = AddBlipForCoord(v.coords)
        v.type = 'coords'
    end

    local blipSettings = Config.GPS.Blips[v.job or 'lost']

    -- -- print(json.encode(blipSettings))

    if v.toggled and v.job then
        blipSettings = Config.GPS.Blips[v.job .. '_on']
    end

    if v.vehType and v.vehType == 'heli' then
        SetBlipSprite(v.blip, blipSettings.heliBlip)
    else
        SetBlipSprite(v.blip, blipSettings.blip)
    end

    v.badge = tostring(v.badge)

    SetBlipDisplay(v.blip, 4)
    ShowHeadingIndicatorOnBlip(v.blip, true)
    SetBlipCategory(v.blip, 7)
    SetBlipScale(v.blip, 0.8)

    if blipSettings.color then
        SetBlipColour(v.blip, blipSettings.color)
    end

    SetBlipAsShortRange(v.blip, false)
    BeginTextCommandSetBlipName('STRING')


    local name = '# ' .. v.badge .. ' ' .. v.name

    if not v.job then
        name = 'LOST GPS'
        v.badge = tostring('0')
    end

    AddTextComponentString(name)
    EndTextCommandSetBlipName(v.blip)

    if #v.badge >= 3 then
        v.badge = string.sub(v.badge, -2)
    end

    ShowNumberOnBlip(v.blip, tonumber(v.badge))
end

function updateGpsBlip(v)
    local blipSettings = Config.GPS.Blips[v.job or 'lost']

    -- -- print(json.encode(blipSettings))

    if v.toggled and v.job then
        blipSettings = Config.GPS.Blips[v.job .. '_on']
    end

    if v.vehType and v.vehType == 'heli' then
        SetBlipSprite(v.blip, blipSettings.heliBlip)
    else
        SetBlipSprite(v.blip, blipSettings.blip)
    end

    v.badge = tostring(v.badge)

    SetBlipDisplay(v.blip, 4)
    ShowHeadingIndicatorOnBlip(v.blip, true)
    SetBlipCategory(v.blip, 7)
    SetBlipScale(v.blip, 0.8)

    if blipSettings.color then
        SetBlipColour(v.blip, blipSettings.color)
    end

    SetBlipAsShortRange(v.blip, false)
    BeginTextCommandSetBlipName('STRING')


    local name = '# ' .. v.badge .. ' ' .. v.name

    if not v.job then
        name = 'LOST GPS'
        v.badge = tostring('0')
    end

    AddTextComponentString(name)
    EndTextCommandSetBlipName(v.blip)

    if #v.badge >= 3 then
        v.badge = string.sub(v.badge, -2)
    end

    ShowNumberOnBlip(v.blip, tonumber(v.badge))
end

function isInJobs(job, job2)
    if not Config.GPS.Jobs[job] then
        return true
    end

    return Table:InTable(Config.GPS.Jobs[job], job2)
end

Event:Register('dwb:gps:left', function(src)
    if gps[src] then
        RemoveBlip(gps[src].blip)
        gps[src] = nil
    end
end, true)

Event:Register('dwb:gps:sync', function(users)
    local job = User:GetJobByType('fraction')
    
    for k, v in pairs(users) do
        if job and (job.name == v.job or isInJobs(job.name, v.job)) then
            if not gps[v.src] then
                createGpsBlip(v)
                gps[v.src] = v
            else
                local obj = gps[v.src]
                if obj.type == 'ent' then
                    local p = GetPlayerFromServerId(v.src)
                    local pp = GetPlayerPed(p)
                    
                    if p == -1 then
                        RemoveBlip(obj.blip)
                        createGpsBlip(v)
                        gps[v.src] = v
                    else
                        v.blip = obj.blip
                        updateGpsBlip(v)
                    end
                else
                    local p = GetPlayerFromServerId(v.src)
                    local pp = GetPlayerPed(p)
                    
                    if p == -1 then
                        v.blip = obj.blip
                        SetBlipCoords(obj.blip, v.coords)
                        updateGpsBlip(v)
                    else
                        RemoveBlip(obj.blip)
                        createGpsBlip(v)
                        gps[v.src] = v
                    end
                end
            end
        else
            if gps[v.src] then
                RemoveBlip(gps[v.src].blip)
                gps[v.src] = nil
            end
        end
    end
end, true)

-- -- Event:Register('dwb:gps:sync', function(users)
-- --     for k, v in pairs(gps) do
-- --         RemoveBlip(v.blip)
-- --         gps[k] = nil
-- --     end

-- --     gps = users
-- --     local job = User:GetJobByType('fraction')
-- --     if job then
-- --         for k, v in pairs(gps) do
-- --             -- -- print(k, json.encode(v))
-- --             if (v.job and v.job == job.name) or not v.job then
-- --                 local p = GetPlayerFromServerId(v.src)
-- --                 local pp = GetPlayerPed(p)
-- --                 if p ~= -1 and DoesEntityExist(pp) then
-- --                     v.blip = AddBlipForEntity(pp)
-- --                 else
-- --                     v.blip = AddBlipForCoord(v.coords)
-- --                 end

-- --                 local blipSettings = Config.GPS.Blips[v.job or 'lost']

-- --                 -- -- print(json.encode(blipSettings))

-- --                 if v.toggled and v.job then
-- --                     blipSettings = Config.GPS.Blips[v.job .. '_on']
-- --                 end

-- --                 if v.vehType and v.vehType == 'heli' then
-- --                     SetBlipSprite(v.blip, blipSettings.heliBlip)
-- --                 else
-- --                     SetBlipSprite(v.blip, blipSettings.blip)
-- --                 end

-- --                 v.badge = tostring(v.badge)

-- --                 SetBlipDisplay(v.blip, 4)
-- --                 ShowHeadingIndicatorOnBlip(v.blip, true)
-- --                 SetBlipCategory(v.blip, 7)
-- --                 SetBlipScale(v.blip, 0.8)
-- --                 if blipSettings.color then
-- --                     SetBlipColour(v.blip, blipSettings.color)
-- --                 end
-- --                 SetBlipAsShortRange(v.blip, false)
-- --                 BeginTextCommandSetBlipName('STRING')


-- --                 local name = '# ' .. v.badge .. ' ' .. v.name
-- --                 if not v.job then
-- --                     name = 'LOST GPS'
-- --                     v.badge = tostring('0')
-- --                 end
-- --                 AddTextComponentString(name)
-- --                 EndTextCommandSetBlipName(v.blip)

-- --                 if #v.badge >= 3 then
-- --                     v.badge = string.sub(v.badge, -2)
-- --                 end
-- --                 ShowNumberOnBlip(v.blip, tonumber(v.badge))
-- --             end
-- --         end
-- --     end
-- -- end, true)

-- -- Citizen.CreateThread(function()
-- --     while true do
-- --         for k,v in pairs(GetActivePlayers()) do
-- --             local ped = GetPlayerPed(v)
-- --             local blip = AddBlipForEntity(ped)
-- --             if IsPedInAnyVehicle(ped) then

-- --             else
-- --                 SetBlipSprite(blip, 3)
-- --             end
-- --         end
-- --     end
-- -- end)
