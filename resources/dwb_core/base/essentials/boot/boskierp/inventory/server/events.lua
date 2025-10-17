
local objs = {}

User:OnLoadedChar(function(self)
    self.inventory = Inventory(self)
    self.inventory:FixSlot()
end, true)

User:OnUnloadedChar(function(self)
    self.inventory = nil
end)

Thread:Create(function()
    while true do
        Wait(150*1000)
        for k,v in pairs(objs) do
            local time = os.time()
            local timeD = time-v.time
            if timeD >= 900 then
                DelteEntity(NetworkGetEntityFromNetworkId(k))
                objs[k] = nil
            end
        end
    end
end)

Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    local value = data.current.value
    if action.name == 'pick' and value == 'open' then
        local obj = NetworkGetEntityFromNetworkId(entityId)
        xPlayer.inventory:OpenEasy({
            name = 'package',
            label = 'Paczka',
            items = entData and entData.items or {}        
        }, {}, function(data)
            return true
        end, function(data)
            return true
        end, function(data, inv)
            Entity(obj).state.data = inv
        end, function(data, inv)
            if #inv.items <= 0 then
                DeleteEntity(obj)
            else
                Entity(obj).state.data = inv
            end
        end)
    end
end, true)

Event:Register('dwb:inventory:change', function(source, xPlayer,data, invData, invData2)
    local quantity = tonumber(data.quantity)
    local currentItem = data.current
    local targetItem = data.target
    
    local newInv = data.newInv
    local oldInv = data.oldInv

    local currentSlot = data.currentSlot
    local targetSlot = data.targetSlot

    local targetItem = data.target
    local currentItem = data.current

    if not targetItem then
        if oldInv == 'inventory' then
            xPlayer.inventory:Changed('removed', data)          
        else
            xPlayer.inventory:Changed('added', data)          
        end
    else
        xPlayer.inventory:Changed('change', data)          
    end
end, true)

Event:Register('dwb:inventory:closed', function(source, xPlayer,data, invData, invData2)
    xPlayer.inventory:Close()
end, true)

Event:Register('dwb:inventory:slot:change', function(source, xPlayer,data, invData, invData2)
    xPlayer.inventory:Changed('change-slot', data)
end, true)

Event:Register('dwb:inventory:item:change', function(source, xPlayer,data, invData, invData2)
    xPlayer.inventory:Changed('change', data)
end ,true)

Event:Register('dwb:inventory:use', function(source, xPlayer,data)
    local item = xPlayer.inventory:GetItem(data.slot or data.current.slot, 'slot')
    if item and item.type ~= 'weapon' then
        Item:Use(xPlayer, item.name, item, data)
    elseif item and item.type == 'weapon' then

        local ped = GetPlayerPed(source)
        local weapon = Player(source).state.currentWeapon

        if not weapon then
            Player(source).state.currentWeapon = item.name
            xPlayer.currentWeapon = item
            GiveWeaponToPed(ped, item.name, item.data.ammo or 0.0, true, true)

            if Config.Inventory.Components[item.name] then
                for k,v in pairs(item.data or {}) do
                    local comp = Config.Inventory.Components[item.name][k]
                    if comp then
                        GiveWeaponComponentToPed(ped, GetHashKey(item.name), GetHashKey(comp))
                    end
                end
            end
        else
            xPlayer.currentWeapon = false
            Player(source).state.currentWeapon = nil
            RemoveAllPedWeapons(ped, true)
        end

    end
end, true)

Event:Register('dwb:inventory:sync:ammo', function(source, xPlayer,weapon, ammo)
    local currentWeapon = Player(source).state.currentWeapon
    if currentWeapon then
        local item = xPlayer.currentWeapon
        xPlayer.lastWeapon = item
        if item then
            xPlayer.inventory:SetItemData(item.slot, 'slot', {
                key = "ammo",
                value = ammo
            })
        end
    end
end, true)

Event:Register('dwb:inventory:item:desc', function(source, xPlayer,item, data, invData2)
    local desc = item.value
    local item2 = item.item

    local playerItem = xPlayer.inventory:GetItem(tonumber(item2.slot), 'slot')     
    if playerItem then
        if playerItem.type == 'weapon' then
            if playerItem.data[desc.name] then
                xPlayer.inventory:SetItemData(playerItem.slot, 'slot', {
                    key = desc.name,
                    value = nil
                })

                xPlayer.inventory:AddItem({
                    name = desc.name,  count = 1})

                if Config.Inventory.Components[playerItem.name] then
                    local comp = Config.Inventory.Components[playerItem.name][desc.name]
                    if comp then
                        RemoveWeaponComponentFromPed(GetPlayerPed(source), GetHashKey(playerItem.name), GetHashKey(comp))
                    end
                end
            end
        end
    end
end, true)


Command:Register('additem', {'xd '}, function(xPlayer, a)
    local zPlayer = DWB.Players[tonumber(a[1]) or xPlayer.source]
    zPlayer.inventory:AddItem({
        name = a[1],
        count = tonumber(a[2]),
        slot = tonumber(a[3]),
        limit = 10
    })
end, {})

Command:Register('xd9', {'xd '}, function(xPlayer)
    local ped = GetPlayerPed(xPlayer.source)
    local pedInventory = Entity(ped).state.inventory or {items = {}}
    xPlayer.inventory:Open(pedInventory, function(data)
        if xPlayer.inventory:AddRemove(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot) then
            Entity(ped).state.inventory = pedInventory
            xPlayer.inventory:Sync(pedInventory)
        end
        -- print(json.encode(data))
        -- -- added
        -- local item = data.current
        -- local targetSlot = data.targetSlot
        -- item.slot = targetSlot
        -- if (xPlayer.inventory:AddItem(item)) then
        --     table.remove(pedInventory.items, data.currentSlot)
        --     Entity(ped).state.inventory = pedInventory
        --     xPlayer.inventory:Sync(pedInventory)
        -- end
    end, function(data)
        if xPlayer.inventory:RemoveAdd(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot) then
            Entity(ped).state.inventory = pedInventory
            xPlayer.inventory:Sync(pedInventory)
        end
        -- removed
        -- print(json.encode(data))
        -- local item = data.current
        -- local targetSlot = data.targetSlot
        -- item.slot = targetSlot
        -- if (xPlayer.inventory:RemoveItem(data.currentSlot, 'slot', 1)) then
        --     table.insert(pedInventory.items, item)
        --     Entity(ped).state.inventory = pedInventory
        --     xPlayer.inventory:Sync(pedInventory)
        -- end
    end, function(data)
        -- item chane
        if data.oldInv == 'inventory' and data.newInv == 'inventory' then
            if xPlayer.inventory:ChangeItem(false, data.current, data.quantity, data.currentSlot, data.targetSlot) then
                xPlayer.inventory:Sync()
            end
        elseif data.oldInv == 'inventory' then
            if xPlayer.inventory:ChangeItem(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot, true) then
                Entity(ped).state.inventory = pedInventory
                xPlayer.inventory:Sync(pedInventory)
            end
        elseif data.newInv == 'inventory' then
            if xPlayer.inventory:ChangeItem(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot, false) then
                Entity(ped).state.inventory = pedInventory
                xPlayer.inventory:Sync(pedInventory)
            end
        else
            if xPlayer.inventory:ChangeItem(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot, false, true) then
                Entity(ped).state.inventory = pedInventory
                xPlayer.inventory:Sync(pedInventory)
            end
        end
    end, function(data)
        -- slot change
        if data.newInv == 'inventory' then
            if xPlayer.inventory:ChangeSlot(nil, data.current, data.quantity, data.currentSlot, data.targetSlot, false, true) then
                Entity(ped).state.inventory = pedInventory
                xPlayer.inventory:Sync(pedInventory)
            end
        else
            if xPlayer.inventory:ChangeSlot(pedInventory.items, data.current, data.quantity, data.currentSlot, data.targetSlot, false, true) then
                Entity(ped).state.inventory = pedInventory
                xPlayer.inventory:Sync(pedInventory)
            end
        end
    end)
end)



local objs = {}
Event:Register('dwb:inventory:open', function(source, xPlayer,vehicleSlots, obj)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
    if DoesEntityExist(vehicle) then
        if not Entity(vehicle).state.occupied then
            xPlayer.occupied = vehicle
            Entity(vehicle).state.occupied = true
            xPlayer.inventory:OpenEntity(vehicle, {
                name = 'vehicle',
                label = 'Bagażnik',
                items = Entity(vehicle).state.data and Entity(vehicle).state.data.items or {},
                slots = vehicleSlots or 25
            }, true, {}, function(data)
                return true
            end, function(data)
                return true
            end, function(data, inv)
                Entity(vehicle).state.data = inv
            end, function(data, inv)
                Entity(vehicle).state.data = inv
                Entity(vehicle).state.occupied = false
                xPlayer.occupied = false
            end)
        end
    elseif obj then
        obj = NetworkGetEntityFromNetworkId(obj)
        if not Entity(obj).state.occupied then
            Entity(obj).state.occupied = true
            xPlayer.occupied = obj
            xPlayer.inventory:OpenEasy({
                name = 'drop',
                label = 'Ziemia',
                items = Entity(obj).state.data and Entity(obj).state.data.items or {},
            }, {
                canChangeSlot = true,
                canChangeItem = true,
                doNotRemoveItem = false,
                autoSync = true
            }, function(data)
                return true
            end, function(data)
                return true
            end, function(data, inv)
                Entity(obj).state.data = inv
            end, function(data, inv)
                xPlayer.occupied = nil
                if #inv.items > 0 then
                    Entity(obj).state.data = inv
                    Entity(obj).state.occupied = false
                elseif #inv.items <= 0 then
                    DeleteEntity(obj)
                end
            end)
        end
    else
        xPlayer.inventory:OpenEasy({
            name = 'drop2',
            label = 'Ziemia',
            items = {}        
        }, {
            canChangeSlot = true,
            canChangeItem = true,
            doNotRemoveItem = false,
            autoSync = true
        }, function(data)
            return true
        end, function(data)
            return true
        end, function(data, inv)

        end, function(data, inv)
            if #inv.items > 0 then
                local item = inv.items[1]
                local prop = Config.Inventory.Objects[item.name] or Config.Inventory.Objects[item.type] or Config.Inventory.Objects['default']
                local coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
                local coords = vec3(coords.x+0.5, coords.y, coords.z-0.5)
                local obj = CreateObjectNoOffset(prop, coords, true,true, false)

                while not DoesEntityExist(obj) do
                    print("waiting for object", 'inventory')
                    Wait(0)
                end

                SetEntityRoutingBucket(obj, GetPlayerRoutingBucket(xPlayer.source))

                Entity(obj).state.action = {
                    name = 'pick',
                    title = 'Przedmiot',
                    closeOnSubmit = true,
                    elements = {
                        {
                            label = 'Podnieś',
                            value = 'open',
                        }
                    },

                }

                Entity(obj).state.data = inv
                Entity(obj).state.isPackage = true
            end
        end)
    end
end, true)




Event:Register('dwb:inventory:change', function(source, xPlayer,data, invData, invData2)
    if true then
        return
    end
    xPlayer:OpenInventory({
        inventory = {},
        label = "",
        name = "",
        entity = obj
    }, function()
    
    end, function()
    
    end)

    local currentItem = data.current
    local targetItem = data.target
    local targetSlot = data.targetSlot
    local quantity = tonumber(data.quantity)
    local newInv = data.newInv
    local currentSlot = data.currentSlot
    local oldInv = data.oldInv
    local coords = GetEntityCoords(GetPlayerPed(source))
    local coords = vec3(coords.x+0.5, coords.y, coords.z-0.5)

    RemoveAllPedWeapons(GetPlayerPed(source), true)
    Player(source).state.currentWeapon = nil

    local item = xPlayer:GetInventoryItem(currentItem.slot)

    if oldInv == 'inventory' and newInv == 'drop' then
        if item.count < quantity then return end
        xPlayer:RemoveInventoryItem(item.slot, tonumber(quantity))
        
        local prop = Inventory.Objects[item.name] or Config.Inventory.Objects[item.type] or Inventory.Objects['default']

        local obj = CreateObjectNoOffset(prop, coords, true,true, false)

        while not DoesEntityExist(obj) do
            print("waiting for object", 'inventory')
            Wait(1000)
        end

        SetEntityRoutingBucket(obj, GetPlayerRoutingBucket(source))

        local items =  {
            {
                name = item.name,
                count = quantity,
                slot = targetSlot,
                label = item.label,
                data = item.data,
                description = item.description,
                type = item.type,
                weight = item.weight
            }
        }

        Entity(obj).state.action = {
            name = 'pick',
            title = 'Przedmiot',
            closeOnSubmit = true,
            elements = {
                {
                    label = 'Podnieś',
                    value = 'open',
                }
            },

        }

        Entity(obj).state.data= {
            items = {{
                    name = item.name,
                    count = quantity,
                    slot = targetSlot,
                    label = item.label,
                    data = item.data,
                    description = item.description,
                    type = item.type,
                    weight = item.weight
                }}
        }

        local id = NetworkGetNetworkIdFromEntity(obj)
        objs[id] = {
            time = os.time()
        }

        Event:TriggerNet('dwb:inventory:drop:open', source, items, NetworkGetNetworkIdFromEntity(obj), invData2)
        -- Event:TriggerNet('dwb:inventory:drop:close:open', source, Entity(obj).state.action.items, id)
    elseif newInv == 'pick' and oldInv == 'inventory' then
        local entity = NetworkGetEntityFromNetworkId(invData)
        if not DoesEntityExist(entity) then return end
        -- local action = Entity(entity).state.action
        local entData = Entity(entity).state.data or {
            items = {}
        }
        local items = entData.items
        local found = false
        for k,v in pairs(items) do
            if v.slot == targetSlot then
                found = v
            end
        end

        if found and  quantity > found.count then return end

        if found and found.name == currentItem.name then
            local count = found.count + quantity
            if count <= item.limit then
                found.count = count
                xPlayer:RemoveInventoryItem(item.slot, tonumber(quantity))
                entData.items = items
                Entity(entity).state.data = entData
                -- Entity(entity).state.action = action
                Event:TriggerNet('dwb:inventory:drop:open', source, items, invData, invData2)
            end
        elseif not found then
            if quantity > item.count then
                quantity = item.count
            end
            table.insert(items, {
                name = item.name,
                count = quantity,
                slot = targetSlot,
                label = item.label,
                data = item.data,
                description = item.description,
                type = item.type,
                weight = item.weight
            })
            -- action.items = items
            entData.items = items
            xPlayer:RemoveInventoryItem(item.slot, tonumber(quantity))
            -- Entity(entity).state.action = action
            Entity(entity).state.data = entData
            Event:TriggerNet('dwb:inventory:drop:open', source, items, invData, invData2)
        end
    elseif newInv == 'inventory' and oldInv == 'pick' then
        local entity = NetworkGetEntityFromNetworkId(invData)
        if not DoesEntityExist(entity) then return end
        -- local action = Entity(entity).state.action
        local entData = Entity(entity).state.data
        local items = entData.items
        local found = false
        local foundIdx = false
        for k,v in pairs(items) do
            if v.slot == currentSlot then
                found = v
                foundIdx = k
            end
        end

        if found and found.name == currentItem.name then
            local count = found.count - quantity
            if count > 0 then
                found.count = count
                xPlayer:AddInventoryItem(targetSlot, found.name, tonumber(quantity), found.data)
                -- action.items = items
                entData.items = items
                -- Entity(entity).state.action = action
                Entity(entity).state.data = entData
                Event:TriggerNet('dwb:inventory:drop:open', source, items, invData, invData2)
            else
                xPlayer:AddInventoryItem(targetSlot, found.name, tonumber(found.count), found.data)
                table.remove(items, foundIdx)
                if #items <= 0 and GetEntityType(entity) == 3 then
                    objs[invData] = nil  
                    DeleteEntity(entity)    
                    Event:TriggerNet('dwb:inventory:close', source, items, invData)
                else
                    -- action.items = items
                    entData.items = items
                    -- Entity(entity).state.action = action
                    Entity(entity).state.data = entData
                    Event:TriggerNet('dwb:inventory:drop:open', source, items, invData, invData2)
                end
            end
        end
    end
end, true)

Inventory:OnChangedItem('attach', 'weapon', function(self, invItem, targetInvItem)

    if Config.Inventory.Components[targetInvItem.name] then
        local comp = Config.Inventory.Components[targetInvItem.name][invItem.name]
        if comp then
            GiveWeaponComponentToPed(GetPlayerPed(self.source), GetHashKey(targetInvItem.name), GetHashKey(comp))
    self:SetItemData(targetInvItem.slot, 'slot', {
        [invItem.name] = true
    })

    self:RemoveItem(invItem.slot, 'slot', 1)
        end
    end
end)

RegisterCommand('xd4', function(src)
    local xPlayer = DWB.Players[src]
    local data = {}
    local i =0
    for k,v in pairs(DWB.Items) do
        i = i + 1
        v.slot = i
        v.count = i
        table.insert(data, v)
    end
            xPlayer.inventory:OpenEntity(GetPlayerPed(src), {
                name = 'vehicle',
                label = 'Bagażnik',
                items = data,
                slots = 999
            }, true, {}, function(data)
                return true
            end, function(data)
                return true
            end, function(data, inv)
            end, function(data, inv)
            end)
end)
Event:Register('dwb:inventory:item:remove', function(xPlayer)
    if item.type == 'weapon' then
        RemoveAllPedWeapons(GetPlayerPed(xPlayer.source), true)
    end
end, true)
User:OnUnloaded(function(self)
    if self.occupied and DoesEntityExist(self.occupied) then Entity(self.occupied).state.occupied = false end
end)