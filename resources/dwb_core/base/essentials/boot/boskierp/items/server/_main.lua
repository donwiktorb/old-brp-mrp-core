
-- -- Item:RegisterUsable('binoculars', function(source)
-- --     Event:TriggerNet('dwb:binoculars:show', source)
-- -- end)


-- -- Item:RegisterUsable('shield', function(source)
-- --     local ped = GetPlayerPed(source)
-- --     if not Entity(ped).state.shield then
-- --         local source = source
-- --        Object:CreateAsync('prop_ballistic_shield', GetEntityCoords(GetPlayerPed(source)), function(obj, objId)
-- --             Entity(ped).state.shield = obj
-- --             Event:TriggerNet('dwb:shield', source, objId)
-- --         end)

-- --     else
-- --         local shield = Entity(ped).state.shield
-- --         Entity(ped).state.shield = false
-- --         Event:TriggerNet('dwb:shield2', source)
-- --         DeleteEntity(shield)
-- --     end
-- -- end)

-- -- for k,v in pairs(Items.Proofs) do
-- -- Item:RegisterUsable(k, function(source)

-- --     local xPlayer = DWB.Players[source]
-- --     xPlayer:RemoveInventoryItem(k, 1) 
-- --     Event:TriggerNet('dwb:ballistic2', source, v)
-- -- end)
-- -- end

-- -- Event:Register('dwb:items:flash', function(source, xPlayer,coords, netId)
-- --     local coords = coords
-- --     local netId = netId
-- --     Object:CreateAsync('w_ex_flashbang', coords, function(obj, objId)
-- --         while not DoesEntityExist(obj)  do
-- --             Wait(0)
-- --         end
-- --         Event:TriggerNet('dwb:items:flash', -1, coords, objId)
-- --     end)
-- -- end, true)

-- -- Item:RegisterUsable('bag', function(source)
-- --     local xPlayer = DWB.Players[source]
-- --     local inv = xPlayer:GetInventoryItem('bag')
-- --     local data = inv.data and inv.data.items or {} or {}
-- --     Event:TriggerNet('dwb:inventory:drop:open', source, data, 'bag', {
-- --         label = 'Torba',
-- --         name = 'bag',
-- --                             slots = 10
                            
-- --     })
-- -- end)

-- -- Event:Register('dwb:inventory:change', function(source, xPlayer,data, invData, invData2)
-- --     local currentItem = data.current
-- --     local targetItem = data.target
-- --     local targetSlot = data.targetSlot
-- --     local quantity = tonumber(data.quantity)
-- --     local newInv = data.newInv
-- --     local currentSlot = data.currentSlot
-- --     local oldInv = data.oldInv
-- --     if oldInv == 'bag' then
-- --         local bag = xPlayer:GetInventoryItem('bag')
        
-- --             local data = bag.data and bag.data.items or {} or {}
-- --         for k,v in pairs(data) do
-- --             if v.slot == currentSlot then
-- --                 if quantity > v.count then
-- --                     quantity = v.count
-- --                 end
-- --                 v.count = v.count - quantity
-- --                 if v.count <= 0 then
-- --                     table.remove(data, k)
-- --                 end
-- --                 xPlayer:SetItemData(bag.slot, {['items'] = data})
-- --                 xPlayer:AddInventoryItem(targetSlot, v.name, quantity, v.data or {})                
-- --                 Event:TriggerNet('dwb:inventory:drop:open', source, data, invData, {
-- --                     label = 'Torba',
-- --                     name = 'bag',
-- --                             slots = 10
-- --                 })
-- --             end
-- --         end

-- --     elseif oldInv == 'inventory' and newInv == 'bag' then
-- --         local item = xPlayer:GetInventoryItem(currentSlot)
-- --         if quantity > item.count then
-- --             quantity = item.count
-- --         end
-- --         local bag = xPlayer:GetInventoryItem('bag')
-- --         local data = bag.data and bag.data.items or {} or {}
-- --         local found = false
-- --         for k,v in pairs(data) do
-- --             if v.slot == targetSlot then
-- --                 found = true
-- --                 if v.name == targetItem.name and v.count + quantity <= item.limit then
-- --                     v.count = v.count + quantity  
-- --                     xPlayer:RemoveInventoryItem(currentSlot, quantity)
-- --                         xPlayer:SetItemData(bag.slot, {['items'] = data})
-- --                         Event:TriggerNet('dwb:inventory:drop:open', source, data, invData, {
-- --                             label = 'Torba',
-- --                             name = 'bag',
-- --                             slots = 10
-- --                         })
-- --                 end
-- --             end
-- --         end
-- --         if not found then
-- --         xPlayer:RemoveInventoryItem(currentSlot, quantity)
-- --         local noRef = {}
-- --         for k,v in pairs(item) do
-- --             noRef[k] = v
-- --         end
-- --         noRef.slot = targetSlot
-- --         noRef.count = quantity
-- --         table.insert(data, noRef)
-- --         xPlayer:SetItemData(bag.slot, {['items'] = data})
-- --         Event:TriggerNet('dwb:inventory:drop:open', source, data, invData, {
-- --             label = 'Torba',
-- --             name = 'bag',
-- --             slots = 10
-- --         })
-- --     end
-- --     end
-- -- end,true)

-- -- Event:Register('dwb:inventory:item:change', function(source, xPlayer,data, invData, invData2)
-- --     if data.oldInv == 'bag' or data.newInv == 'bag' then
-- --         Event:TriggerNet('dwb:inventory:drop:open', source, invData2, invData, {
-- --             label = 'Torba',
-- --             name = 'bag',
-- --             slots = 10
-- --         })
-- --     end
-- -- end, true)


for k,v in pairs(Config.Items.Usable) do
    for k2,v2 in pairs(v.items) do
        print(v2.name)
        Item:RegisterUsable(v2.name, function(source)
            print(source)
            local xPlayer = DWB.Players[source]
            local removeAfterUse = v2.removeAfterUse or v.removeAfterUse

            if removeAfterUse then
                local removeAmount = v2.removeAmount or v.removeAmount
                xPlayer.inventory:RemoveItem(v2.name, 'name', removeAmount)
            end

            local serverFunction = v2.serverFunction or v.serverFunction

            if serverFunction then
                serverFunction = serverFunction(xPlayer)
            end

            local addItems = v2.addItems or v.addItems
            local randomizeItems = v2.randomItems or v.randomItems

            if addItems then
                if not randomizeItems then
                    for k2,v2 in pairs(addItems) do
                        if type(v2) == 'table' then
                            v2 = math.random(table.unpack(v2))
                        end

                        xPlayer.inventory:AddItem({
                            name = k2,
                            count = v2
                        })
                    end
                else
                    for k2,v2 in pairs(addItems) do
                        local x = math.random(1, randomizeItems)
                        if x == 2 then
                            if type(v2) == 'table' then
                                v2 = math.random(table.unpack(v2))
                            end

                            xPlayer.inventory:AddItem({
                                name = k2,
                                count = v2
                            })
                        end
                    end
                end
            end

            local trackUsage = v2.trackUsage or v.trackUsage
            local clientFunction = v2.clientFunction or v.clientFunction

            if trackUsage then
                Event:TriggerNet('dwb:items:usage', source, k, k2, serverFunction)
            end

            -- if trackUsage then
            --     Event:TriggerNet('dwb:items:usage', k, k2)
            -- elseif clientFunction then
            --     Event:TriggerNet('dwb:items:client:fn', k, k2)
            -- end
        end)
    end
end