local started = false
local lastEnt = nil
Thread:Create(function()
    while true do
        local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

        if retval and not started then
            started = true
            lastEnt = entity
            local action = Entity(entity).state.action
            if action and action.aim then
                local entData = Entity(entity).state.data
                local model = GetEntityModel(entity)
                local entType = IsPedAPlayer(entity) and 'player' or IsEntityAVehicle(entHit) and 'vehicle'

                if entity == PlayerPedId() then
                    entType = 'self'
                end

                if Cursor.Models[model] then
                    local newAction  = Cursor.Models[model]
                    if not action then
                        action = newAction
                    elseif newAction then
                        for k,v in pairs(newAction.elements) do
                            table.insert(action.elements, v)
                        end
                    end
                elseif entType then
                    local newAction = Cursor.Types[entType]
                    if not action 
                    then
                        action = json.decode(json.encode(newAction))
                    elseif newAction then
                        for k,v in pairs(newAction.elements) do
                            table.insert(action.elements, v)
                        end
                    end 
                    
                    if entType == 'vehicle' then
                        if LocalPlayer.state.vehicleActions then
                            for k,v in pairs(LocalPlayer.state.vehicleActions) do
                                table.insert(action.elements, {
                                    label = v.label,
                                    value = v.value
                                })
                            end
                        end
                    end
                end

                if action and (not action.cb or Cursor.Callbacks[action.cb](entity)) then
                    local netId = NetworkGetNetworkIdFromEntity(entity)

                    local title = action.title
                    local name = action.name
                    local elements = action.elements

                    if action.elementCb then
                        local elements2 = Cursor.ElementCbs[action.elementCb]
                        if elements2 then
                            elements2 = elements2()
                            for k,v in pairs(elements2) do
                                table.insert(elements, v)
                            end
                        end
                    end    

                    local addon = action.aimCb and Cursor.AimCbs[action.aimCb]()

                    Event:TriggerNet('dwb:aiming:started', action, netId, entData, addon)
                end
            end
        elseif not retval and started then
            started = false
            local entity = lastEnt
            local action = Entity(entity).state.action
            if action and action.aim then
                local entData = Entity(entity).state.data
                local model = GetEntityModel(entity)
                local entType = IsPedAPlayer(entity) and 'player' or IsEntityAVehicle(entHit) and 'vehicle'

                if entity == PlayerPedId() then
                    entType = 'self'
                end

                if Cursor.Models[model] then
                    local newAction  = Cursor.Models[model]
                    if not action then
                        action = newAction
                    elseif newAction then
                        for k,v in pairs(newAction.elements) do
                            table.insert(action.elements, v)
                        end
                    end
                elseif entType then
                    local newAction = Cursor.Types[entType]
                    if not action 
                    then
                        action = json.decode(json.encode(newAction))
                    elseif newAction then
                        for k,v in pairs(newAction.elements) do
                            table.insert(action.elements, v)
                        end
                    end 
                    
                    if entType == 'vehicle' then
                        if LocalPlayer.state.vehicleActions then
                            for k,v in pairs(LocalPlayer.state.vehicleActions) do
                                table.insert(action.elements, {
                                    label = v.label,
                                    value = v.value
                                })
                            end
                        end
                    end
                end

                if action and (not action.cb or Cursor.Callbacks[action.cb](entity)) then
                    local netId = NetworkGetNetworkIdFromEntity(entity)

                    local title = action.title
                    local name = action.name
                    local elements = action.elements

                    if action.elementCb then
                        local elements2 = Cursor.ElementCbs[action.elementCb]
                        if elements2 then
                            elements2 = elements2()
                            for k,v in pairs(elements2) do
                                table.insert(elements, v)
                            end
                        end
                    end    

                    local addon = action.aimCb and Cursor.AimCbs[action.aimCb]()

                    Event:TriggerNet('dwb:aiming:stopped', action, netId, entData, addon)
                end
            end
        end
        Wait(500)
    end
end)