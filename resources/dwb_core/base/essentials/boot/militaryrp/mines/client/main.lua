local prop = 'prop_snow_oldlight_01b'
local currentObj

UI:newFocus('DefuseMine', true)

Event:Register('dwb:mine:use', function()
    local ped = PlayerPedId()
    local forward = GetEntityForwardVector(ped)
    Event:TriggerNet('dwb:mine:spawn', forward)
end, true)

Key:onJustPressed('O', 'Rozbrój minę', function()
    local model = GetHashKey(prop)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    -- local obj = GetClosestObjectOfType(coords, 2.0, model, false, true, true)
    if currentObj then
        UI:Open('DefuseMine', {})
        -- currentObj = obj
    end
end)

RegisterNUICallback('mine_fail', function(data, cb)
    UI:Close('DefuseMine', {})
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    AddExplosion(coords, 4, 0.8, true, false, 8)
    -- DeleteEntity(currentObj)
    -- DeleteEntity(currentObj)
    Event:TriggerNet('dwb:mine:remove', currentObj)
    cb({})
end)

RegisterNUICallback('mine_success', function(data, cb)
    UI:Close('DefuseMine', {})
    -- DeleteEntity(currentObj)
    -- DeleteEntity(currentObj)
    
    Event:TriggerNet('dwb:mine:remove', currentObj)
    cb({})
end)

Event:Register('dwb:mine:spawn', function(obj, mineId, coords)
    PlaceObjectOnGroundProperly(obj)
    
    Marker:Add('mine', {
        marker = {},
        settings = {
            drawMarker = false,
            drawDist = 20,
            radius = 1.6,
            overrideCoords = true
        },
        coords = {
            {
                model = prop,
                obj = obj,
                pos = coords
            }     
        },
        functions = {
            onDrawDistExit = function()
                currentObj = nil
            end,
            onCloseDist = function(zone,pos)
                currentObj = pos.obj
            end,
            onExitCb = function(zone, pos)
                AddExplosion(pos.pos, 4, 0.8, true, false, 8)
                Event:TriggerNet('dwb:mine:remove', pos.obj)
                -- DeleteEntity(pos.obj)
                
            end
        }

    })
end, true)

Event:Register('dwb:mine:remove', function(obj)
    Marker:RemoveNonExistantObjects('mine')
    DeleteEntity(currentObj)
    currentObj = false
end, true)