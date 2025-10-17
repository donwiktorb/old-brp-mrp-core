local isActive = false
local isOwner = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if isActive then
            -- print(json.encode(isActive))
            local fixed, vehCoords, weaponHash = isActive.fixed, isActive.vehCoords, isActive.weaponHash
            local veh = NetworkGetEntityFromNetworkId(vehCoords)
            local vehCoords = GetEntityCoords(veh)
            ShootSingleBulletBetweenCoords(fixed, vehCoords, 4, true, weaponHash, false, true, false, 5.0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if isOwner then
            local ped = PlayerPedId()
            if IsEntityDead(ped) ~= false or not IsPedInAnyVehicle(ped) then
                isOwner = false
                Event:TriggerNet('dwb:air:sync:stop')
            end
        end
    end
end)

Event:Register('dwb:air:sync:start', function(fixed, vehCoords, weaponHash)
    Stream:RequestWeapon(weaponHash)
    isActive = {
        fixed = fixed,
        vehCoords = vehCoords,
        weaponHash = GetHashKey(weaponHash)
    }
end, true)

Event:Register('dwb:air:sync:stop', function()
    isActive = false
end, true)

Citizen.CreateThread(function()
    for k,v in pairs(Airdef.Coords) do
        Marker:Add('defair', {
            -- marker = {},
            settings = {
                -- drawMarker = true,
                drawDist = 1500.0,
                radius = 50.0,
                overrideCoords = true
            },
            coords = {
                {
                    prop = v.prop,
                    weapon = v.weapon,
                    pos = v.pos,
                    team = v.team
                }
            },
            functions = {
                onDrawDistEnter = function(zone, zPos)
                    -- print('x d')
                    local ped = PlayerPedId()
                    local veh = GetVehiclePedIsIn(ped)
                    if veh ~= 0 and IsEntityInAir(veh) and not IsEntityDead(ped) and PlayerData and PlayerData.char and PlayerData.char.team ~= zPos.team  then
                        local coords = zPos.pos
                        local prop = zPos.prop

                        -- local obj = GetClosestObjectOfType(coords, 20.0, prop, false, true, true)
                        -- if obj ~= 0 and not isOwner then
                        if not isOwner then
                            local topOffset = vector3(0,0,4)
                            local fixed = coords+topOffset
                            local vehCoords = GetEntityCoords(ped)
                            local weaponHash = zPos.weapon
                            local vehNetId = NetworkGetNetworkIdFromEntity(veh)
                            isOwner = true
                            Event:TriggerNet('dwb:air:sync:start', fixed, vehNetId, weaponHash)
                        end
                    else
                        Event:TriggerNet('dwb:air:sync:stop')
                    end
                end,
                onDrawDistExit = function()
                    isOwner = false
                    Event:TriggerNet('dwb:air:sync:stop')
                end
            }
        })
    end
end)