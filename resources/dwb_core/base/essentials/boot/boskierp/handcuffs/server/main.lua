
Item:RegisterUsable('handcuffs', function(source)
    Event:TriggerNet('dwb:handcuffs:use', source)
end)

User:OnCustomEvent('fraction-action', function(self, current, current4, data4)
    if current.value == 'hands' then
        Event:TriggerNet('dwb:handcuffs:use', self.source)
    end
end)


Event:Register('dwb:handcuffs:use', function(source, xPlayer)
    Event:TriggerNet('dwb:handcuffs:use', source)
end, true)
Event:Register('dwb:handcuffs:state', function(source, xPlayer,player)
    if player then
        if Player(player).state.isHandcuffed then
            Player(player).state.isHandcuffed = false
            Event:TriggerNet('dwb:handcuffs:uncuff', player)
        else
            Player(player).state.isHandcuffed = true

            -- -- Event:TriggerNet('dwb:handcuffs:menu', source, player)
            local _player = player
            Object:CreateAsync(GetHashKey('p_cs_cuffs_02_s'), GetEntityCoords(GetPlayerPed(source)), function(obj, objId)
                local netId = NetworkGetNetworkIdFromEntity(obj)
                Event:TriggerNet('dwb:handcuffs:cuff', _player, netId)
            end)
        end
    end
end, true)

Event:Register('dwb:handcuffs:delete', function(source, xPlayer,propId)
    local prop = NetworkGetEntityFromNetworkId(propId)
    DeleteEntity(prop)
end, true)

Event:Register('dwb:handcuffs:drag', function(source, xPlayer,player)
    if Player(player).state.isHandcuffed then
        Event:TriggerNet('dwb:handcuffs:drag', player, true, source)
    end
end, true)


-- -- Event:Register('dwb:inventory:item:change', function(source, xPlayer,data, invData, invData2)
-- --     local xPlayer = DWB.Players[source]
-- --     if data.current.name == data.target.name then
-- --         if data.oldInv == 'player' then
-- --             local currentItem = data.current
-- --             local targetItem = data.target
-- --             local targetSlot = data.targetSlot
-- --             local quantity = tonumber(data.quantity)
-- --             local newInv = data.newInv
-- --             local currentSlot = data.currentSlot
-- --             local oldInv = data.oldInv
-- --             local player = DWB.Players[invData] 
-- --             local item = DWB.Items[currentItem.name]
-- --             local zPlayerItem = xPlayer:GetInventoryItem(targetSlot)
-- --             local playerItem = player:GetInventoryItem(currentSlot)
-- --             if playerItem.count < quantity then
-- --                 quantity = playerItem.count
-- --             end

-- --             local counter = zPlayerItem.count+quantity

-- --             if counter > item.limit then
-- --                 quantity = item.limit-zPlayerItem.count
-- --             end

-- --             player:RemoveInventoryItem(data.currentSlot, quantity)
-- --             xPlayer:AddInventoryItem(data.targetSlot, item.name, quantity, playerItem.data or {})
-- --         end
-- --     end
-- -- end, true)


Event:Register('dwb:handcuffs:search:start', function(source, xPlayer,playerId)
    if Player(playerId).state.isHandcuffed then
        local player = DWB.Players[playerId]
        xPlayer.inventory:OpenEasy({
            name = 'player',
            label = 'Gracz',
            items = player.char.inventory or {},
        }, {
            canChangeSlot = true,
            canChangeItem = true,
            doNotRemoveItem = false,
            autoSync = true
        }, function(data)
            if not player.char.data.IsDead and data.current.name ~= 'cash' then
                return true
            else
                xPlayer:ShowNotify('info', 'Ekwipunek', 'Nie możesz lootwać pieniędzy i osób na bw')
            end
        end, function(data)
            return true
        end, function(data, inv)
            -- Entity(obj).state.data = inv
        end, function(data, inv)
            -- if #inv.items > 0 then
            --     Entity(obj).state.data = inv
            --     Entity(obj).state.occupied = false
            -- elseif #inv.items <= 0 then
            --     DeleteEntity(obj)
            -- end
        end)

        -- Event:TriggerNet('dwb:inventory:drop:open', source, player.inventory, playerId, {
        --     label = 'Osoba',
        --     name = 'player'
        -- })
    end
end, true)

Event:Register('dwb:handcuffs:person:veh', function(source, xPlayer,playerId, vehid, seat)
    if Player(playerId).state.isHandcuffed then
        local veh = NetworkGetEntityFromNetworkId(vehid)
       TaskWarpPedIntoVehicle(GetPlayerPed(playerId), veh, seat) 
    end
end, true)

Event:Register('dwb:handcuffs:person:out:veh', function(source, xPlayer,playerId, vehid)
    if Player(playerId).state.isHandcuffed then
        local veh = NetworkGetEntityFromNetworkId(vehid)
        TaskLeaveVehicle(GetPlayerPed(playerId),veh,16)
    end
end, true)

Event:Register('dwb:inventory:change', function(source, xPlayer,data, invData, invData2)
    local currentItem = data.current
    local targetItem = data.target
    local targetSlot = data.targetSlot
    local quantity = tonumber(data.quantity)
    local newInv = data.newInv
    local currentSlot = data.currentSlot
    local oldInv = data.oldInv
    local player = DWB.Players[invData] 
    if player then
        if oldInv == 'player' then
            local item = player:GetInventoryItem(currentSlot)
            if quantity > item.count then
                quantity = item.count
            end
            xPlayer:AddInventoryItem(targetSlot, item.name, quantity, item.data or {})
            player:RemoveInventoryItem(currentSlot, quantity)
            Event:TriggerNet('dwb:inventory:drop:open', source, player.inventory, invData, {
                label = 'Osoba',
                name = 'player'
            })
        elseif oldInv == 'inventory' then
            local item = xPlayer:GetInventoryItem(currentSlot)
            if quantity > item.count then
                quantity = item.count
            end
            player:AddInventoryItem(targetSlot, item.name, quantity, item.data or {})
            xPlayer:RemoveInventoryItem(currentSlot, quantity)
            Event:TriggerNet('dwb:inventory:drop:open', source, player.inventory, invData, {
                label = 'Osoba',
                name = 'player'
            })
        end
    end
end,true)

