local doors = {
    {
        model = 1527147442,
        heading = 340.0,
        offset = 1.0
    }
}
local showNotify = false
local showedNotify = false

function getClosestDoors(coords, model2)
    local closestDoors, closestDist = -1, -1
    local closestDoorsId = -1
    for k,v in pairs(Config.Doorlock.Doors) do
        if v.model == model2 then 
            local dist = #(v.coords - coords)
            if closestDist == -1 then
                closestDoors = v
                closestDist = dist
                closestDoorsId = k
            elseif dist < closestDoors then
                closestDoors = v
                closestDist = dist
                closestDoorsId = k
            end
        end
    end
    return closestDoorsId, closestDoors, closestDist
end

function getDoors(model)
    for k,v in pairs(doors) do
        if v.model == model then
            return k,v
        end
    end
end

function isBetween(value, min, max)
    return value >= min and value <=max
end

function generateUniqueID(x, y, z)
  local hash = 17 -- Initial value for the hash

  -- Combine the x, y, and z values into the hash
  hash = hash * 31 + math.floor(x * 100)
  hash = hash * 31 + math.floor(y * 100)
  hash = hash * 31 + math.floor(z * 100)

  -- Convert the hash to a string
  local id = tostring(hash)

  return id
end

Event:Register('dwb:doorlock:update', function(doors, states)
    for k,v in pairs(doors) do
        Config.Doorlock.Doors[v].closed= states[k]
    end
    -- Config.Doorlock.Doors[doorId].closed = state
end, true)

Event:Register('dwb:doorlock:update:gates', function(doors, states)
    for k,v in pairs(doors) do
        Config.Doorlock.Gates[v].closed= states[k]
    end
    -- Config.Doorlock.Doors[doorId].closed = state
end, true)
-- -- -- -- Thread:Create(function()
-- -- -- --     while true do
-- -- -- --         Wait(0)
-- -- -- --         for k,v in pairs(DWB.PlayerData.ClosestObjects) do
-- -- -- --             if v.dist <= 3.0 then
-- -- -- --                 local doorId = generateUniqueID(v.coords.x, v.coords.y, v.coords.z)
-- -- -- --                 DrawText3D(v.coords.x, v.coords.y, v.coords.z, "MODEL: "..GetEntityModel(v.obj).." | "..GetEntityHeading(v.obj).." | "..GetEntityCoords(v.obj).." | "..doorId.." | "..v.obj)
-- -- -- --             end
-- -- -- --         end
-- -- -- --     end
-- -- -- -- end)

Key:onJustPressed('E', 'Otwieranie/Zamykanie drzwi', function()
    local r, cat, coords, normal, entHit = Object:GetInDirection()
    if entHit ~= 0 then
        local entCoords = GetEntityCoords(entHit)
        local doorId = generateUniqueID(entCoords.x, entCoords.y, entCoords.z)
        -- -- Event:TriggerNet('dwb:doorlock:add', doorId, GetEntityModel(entHit), GetEntityHeading(entHit), 'police')
        local door = Config.Doorlock.Doors[doorId]
        if door then
            if door.jobs then
                local job = User:GetJob(door.jobs)
                if not job then
                    return
                end
            end

            if door.closed then
                Sound:Play('openKeypad', 0.7)
            else
                Sound:Play('lockKeypad', 0.7)
            end

            if not door.closed then
                local min = door.heading-(door.offset or 1.0)
                local max = door.heading+(door.offset or 1.0)
                while not isBetween(GetEntityHeading(entHit), min, max) do
                    Wait(0)
                end
            end

            Event:TriggerNet('dwb:doorlock:state', doorId)
            -- Config.Doorlock.Doors[doorId].closed = not Doorlock.Doors[doorId].closed
        else
            for k,v in pairs(Config.Doorlock.Gates) do
                local dist = #(v.coords - DWB.PlayerData.Coords)
                if dist <= v.distance then
                    if v.jobs then
                        local job = User:GetJob(v.jobs)
                        if job then
                            Event:TriggerNet('dwb:doorlock:gate:state', k)
                        end
                    else
                        if v.license then
                            local hasLicense = false
                            for k2,v2 in pairs(DWB.PlayerData.char.licenses or {}) do
                                if v.license == v2 then
                                    hasLicense = true
                                end
                            end
                            if hasLicense then
                                Event:TriggerNet('dwb:doorlock:gate:state', k)
                            end
                        else
                            Event:TriggerNet('dwb:doorlock:gate:state', k)
                        end
                    end

                end
            end
        end
    else
        for k,v in pairs(Config.Doorlock.Gates) do
            local dist = #(v.coords - DWB.PlayerData.Coords)
            if dist <= v.distance then
                if v.jobs then
                    local job = User:GetJob(v.jobs)
                    if job then
                        Event:TriggerNet('dwb:doorlock:gate:state', k)
                    end
                else
                    if v.license then
                        local hasLicense = false
                        for k2,v2 in pairs(DWB.PlayerData.char.licenses or {}) do
                            if v.license == v2 then
                                hasLicense = true
                            end
                        end
                        if hasLicense then
                            Event:TriggerNet('dwb:doorlock:gate:state', k)
                        end
                    else
                        Event:TriggerNet('dwb:doorlock:gate:state', k)
                    end
                end

            end
        end
    end
end)

Thread:Create(function()
    while true do
        Wait(500)
        local lastDist = 5
        showNotify = false
        local notifyObj = false
        for k,v in pairs(DWB.PlayerData.ClosestObjects) do
            local doorId = generateUniqueID(v.coords.x, v.coords.y, v.coords.z)
            local door = Config.Doorlock.Doors[doorId]
            if door then
                local job = User:GetJob(door.jobs)
                if job then
                    if v.dist <= lastDist and HasEntityClearLosToEntity(PlayerPedId(), v.obj, 4) then
                        showNotify = door
                        notifyObj = v
                        lastDist = v.dist
                    end 
                end
                if door.closed and not IsEntityPositionFrozen(v.obj) then
                    FreezeEntityPosition(v.obj, true)
                    SetEntityHeading(v.obj, door.heading)
                elseif not door.closed and IsEntityPositionFrozen(v.obj) then
                    FreezeEntityPosition(v.obj, false)  
                elseif not door.closed and door.forceOpen then
                    if door.openHeading then
                        SetEntityHeading(v.obj, door.openHeading)
                        -- FreezeEntityPosition(v.obj, true)
                    end
                end
            end
        end
        for k,v in pairs(Config.Doorlock.Gates) do
            local dist = #(DWB.PlayerData.Coords - v.coords)
            if dist <= 10.0 then
                local obj = GetClosestObjectOfType(DWB.PlayerData.Coords, 10.0, v.model, false,false,false)
                if obj ~= 0 then
                    local job = User:GetJob(v.jobs)
                    if job then
                        showNotify = v
                        notifyObj = v
                    end
                    if v.closed and not IsEntityPositionFrozen(obj) then
                        if v.defaultCoords then
                            SetEntityCoords(obj, v.defaultCoords)
                            if v.heading then
                                SetEntityHeading(obj, v.heading)
                            end
                        elseif v.heading then
                            SetEntityHeading(obj, v.heading)
                        end
                        FreezeEntityPosition(obj, true)
                    elseif not v.closed and IsEntityPositionFrozen(obj) then
                        FreezeEntityPosition(obj, false)
                    end
                end
            end
        end

        if showNotify then
            showedNotify = true
            SendNuiMessage(json.encode({
                type = 'Notify2',
                action = 'open',
                data=  {
                    show = true,
                    content = string.format("Naciśnij <k>E</k>, aby %s drzwi.", showNotify.closed and "otworzyć" or "zamknąć")
                }
            }))
            -- local content = string.format("Naciśnij ~b~E, aby %s drzwi.", showNotify.closed and "~g~otworzyć" or "zamknąć")
            -- Text:AddDraw3d('doorlock', notifyObj.coords, 4.0, content, {})
        elseif not showNotify and showedNotify then
            showedNotify = false
            -- Text:RemoveDraw3d('doorlock')
            SendNuiMessage(json.encode({
                type = 'Notify2',
                action = 'close',
            }))
        end
    end
end)
