local blips = {}

function removeBlips()
    for k,v in pairs(blips) do
        RemoveBlip(v.blip)
        blips[k] = nil
    end
end

Event:Register('dwb:akagps:update', function(players)
    removeBlips()
    for k,v in pairs(players) do
        if DWB.PlayerData and DWB.PlayerData.char then
            if v.team == DWB.PlayerData.char.team then
                createBlip(k, v.data, v.name)
            end
        end
    end
end, true)

function createBlip(id, data, name)
    local blip = AddBlipForCoord(data.coords)

    SetBlipSprite(blip, 1)
    SetBlipRotation(blip, math.ceil(data.heading))
    SetBlipNameToPlayerName(blip, id)
    SetBlipScale(blip, 0.85) -- set scale
    SetBlipAsShortRange(blip, true)
    -- -- print(data.wl)
    if data.recruter then 
        SetBlipColour(blip --[[ Blip ]],35)
    elseif not data.wl then
        SetBlipColour(blip --[[ Blip ]],37)
    else
        SetBlipColour(blip --[[ Blip ]],38)
    end

    BeginTextCommandSetBlipName("STRING")

    if data.recruter then 
        AddTextComponentString("! "..name)
    else
        AddTextComponentString("# "..name)
    end

    EndTextCommandSetBlipName(blip)

    table.insert(blips, {
        blip = blip,
        id = id
    }) -- add blip to array so we can remove it later
end