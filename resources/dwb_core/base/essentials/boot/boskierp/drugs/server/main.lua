local weedPlantStateObjects = {
    [500] = 1511282135,
    [1000] = 1315651205,
    [1500] = 1027382312,
    [2000] = 469652573,
    [2500] = 716763602
}

Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    if data.current.value == 'sell-drugs' then

            local found
            local found2
            for k,v in pairs(Drugs.Sell) do
                local item = xPlayer:GetInventoryItem(v.name)
                if item then
                    found = item
                    found2 = v
                end
            end
            
            if found then
                local ent = NetworkGetEntityFromNetworkId(entityId)
                if Entity(ent).state.data and Entity(ent).state.data.tried then return end
                Entity(ent).state.data = {tried = true}
                local rand = math.random(found2.chance[1], found2.chance[2])
                if rand == 2 then
                    local amount = math.random(found2.amount[1], found2.amount[2])
                    local price = math.random(found2.price[1], found2.price[2])
                    if amount > found.count then
                        amount = found.count
                    end

                    price = price * amount
                    xPlayer:RemoveInventoryItem(found.slot, amount)
                    xPlayer:AddInventoryItem(false, found2.money, price)
                    xPlayer:ShowNotify('info', TR(found2.title), TR(found2.msg, amount, price))
                else

                    xPlayer:ShowNotify('warning', 'Dilerka', 'Obywatel odrzucił twoją ofertę')

                    addReport('police', 'David', TR("drugs_tablet"), {
                        coords = GetEntityCoords(GetPlayerPed(source)),
                        type = 'gps'
                    })
                    -- for k,v in pairs(DWB.Players) do
                    --     if v:HasJob('police') and v.char.duty and v.char.duty['police'] then
                    --         -- v:ShowNotify('info', 'Sprzedaz narkotykow', 'Sprzedaja dragi, lokalizacja w tablecie')
                    --         -- Event:TriggerNet('dwb:outlaw:drugs', k, GetEntityCoords(GetPlayerPed(source)))
                    --     end
                    -- end
                    Outlaw:Notify(source, 'shooting', false)
                    Event:TriggerNet('dwb:drugs:sell', source)
                end
            end

    elseif data.current.value == 'collect' then
        if action.name == 'cocaine' then
            local entity =NetworkGetEntityFromNetworkId(entityId)
            if DoesEntityExist(entity) then 
                DeleteEntity(NetworkGetEntityFromNetworkId(entityId))
                xPlayer:AddInventoryItem(false, 'coke_leaf', entData and entData.amount or 1)
                Event:TriggerNet('dwb:drugs:coke:collect', source)
            end
        elseif action.name == 'weed' then
            xPlayer:AddInventoryItem(false, 'weed_seeds', 1)
            Event:TriggerNet('dwb:drugs:weed:collect', source)
        elseif action.name == 'weed-plant' then
            xPlayer:AddInventoryItem(false, 'soak_weed', entData and entData.amount or 1)
            DeleteEntity(NetworkGetEntityFromNetworkId(entityId))
        end
    elseif data.current.value == 'mix' then
        print('x d')
    elseif data.current.value == 'drying' and action.name == 'weed' then
        local item = xPlayer:GetInventoryItem('soak_weed')
        if item and  item.count >= 1 then 
            xPlayer:RemoveInventoryItem('soak_weed', 1)
            xPlayer:AddInventoryItem(false, 'weed', 1)
            Event:TriggerNet('dwb:drugs:weed:dry', source)
        else
            xPlayer:ShowNotify('warning', 'Suszenie', 'Nie posiadasz mokrej trawy')
        end
    elseif data.current.value == 'extract' then
        local item = xPlayer:GetInventoryItem('coke_leaf')
        local item2 = xPlayer:GetInventoryItem('ephedrine')
        local item4 = xPlayer:GetInventoryItem('hydrochloric_acid')
        if item and item2 and item4 and  item.count >= 1 and item2.count >= 1 and item4.count >= 1 then 
            xPlayer:RemoveInventoryItem('coke_leaf', 1)
            xPlayer:RemoveInventoryItem('ephedrine', 1)
            xPlayer:RemoveInventoryItem('hydrochloric_acid', 1)
            
            
            xPlayer:AddInventoryItem(false, 'coke_powder', 1)
        
        Event:TriggerNet('dwb:drugs:coke:extract', source)
        else
            xPlayer:ShowNotify('warning', 'Ekstracja', 'Nie posiadasz wszystkich składników: Liście koki, Efedryna, Kwas solny')
        end
    elseif data.current.value == 'pack' then
        local item = xPlayer:GetInventoryItem('coke_powder')
        if item and item.count >= 1 then 
            xPlayer:RemoveInventoryItem('coke_powder', 1)
            xPlayer:AddInventoryItem(false, 'coke_pack', 1)
        
        Event:TriggerNet('dwb:drugs:coke:pack', source)
        else
            xPlayer:ShowNotify('warning', 'Pakowanie', 'Nie posiadasz gramów kokainy.')
        end
        
    elseif data.current.value == 'plant-weed' and action.name == 'pot' then
        local item = xPlayer:GetInventoryItem('weed_seeds')
        if item and item.count > 0 then
            xPlayer:RemoveInventoryItem('weed_seeds', 1)
            local obj = NetworkGetEntityFromNetworkId(entityId)
            local action =  {
                name = 'weed-plant',
                title = 'Krzak Marihuany',
                elements = {
                    {
                        label = 'Podlej',
                        value = 'water'
                    }
                } 
            }
            Entity(obj).state.action = action
        end
    elseif data.current.value == 'water' then
        local item = xPlayer:GetInventoryItem("watercan_500")
        if action.name == 'weed-plant' and item and item.count > 0 then
            xPlayer:RemoveInventoryItem("watercan_500", 1)
            local obj = NetworkGetEntityFromNetworkId(entityId)
            local currentWaterState = Entity(obj).state.water or 500
            local object
            local action =  {
                name = 'weed-plant',
                title = 'Krzak Marihuany',
                elements = {
                    {
                        label = 'Podlej',
                        value = 'water'
                    }
                } 
            }

            object = weedPlantStateObjects[currentWaterState]

            if not object then
                action =  {
                    name = 'weed-plant',
                    title = 'Krzak Marihuany',
                    elements = {
                        {
                            label = 'Zbierz',
                            value = 'collect'
                        }
                    } 
                }
            else
                local coords = GetEntityCoords(obj)

                DeleteEntity(obj)

                obj = CreateObjectNoOffset(object, coords, true,true, false)


                while not DoesEntityExist(obj) do
                    print("waiting for object", object, coords)
                    Wait(0)
                end

                Entity(obj).state.water = currentWaterState+500
                FreezeEntityPosition(obj, true)
            end

            Entity(obj).state.action = action
        end
    end
end, true)

Event:Register('dwb:drugs:weed:plant', function(source, xPlayer,fwd)
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)-vec3(0,0,1)
    local coords = (pCoords+fwd*1.0)

    Object:Create(Config.Drugs.Pot, coords, function(obj)
        Entity(obj).state.water = 500 
    end)    
end, true)

Item:RegisterUsable('pot', function(src)
    local xPlayer = DWB.Players[src]
    xPlayer.inventory:RemoveItem('pot', 'name', 1)
    Event:TriggerNet('dwb:drugs:weed:plant', src)
end)


local workin = {}

User:OnCustomEvent('pot', function(self, entId, action, current)

    local ent = NetworkGetEntityFromNetworkId(entId)
    if current.value == 'plant' then
        local pot = Config.Drugs.Pots[current.drug]

        local coords = GetEntityCoords(ent)
        DeleteEntity(ent)
        Object:Create(pot.objects[500], coords, function(obj)
            Entity(obj).state.water = 500 
        end)    
    elseif current.value == 'water' then
        if xPlayer.inventory:RemoveItem('watercan', 'name', 1) then
            local pot = Config.Drugs.Pots[current.drug]

            local coords = GetEntityCoords(ent)

            local water = Entity(ent).state.water + 500

            DeleteEntity(ent)
        
            local obj  = pot.objects[water]

            if obj then
                Object:Create(obj, coords, function(obj)
                    Entity(obj).state.water = water
                end)    
            else
                xPlayer.inventory:AddItem({
                    name = pot.giveItem,
                    count = type(pot.giveCount) == 'table' and math.random(pot.giveCount[1], pot.giveCount[2]) or pot.giveCount
                })            
            end
        end
    end
end)

User:OnCustomEvent('pot', function(self, entId, action, current)

    local ent = NetworkGetEntityFromNetworkId(entId)
    if current.value == 'plant' then
        local pot = Config.Drugs.Pots[current.drug]

        local coords = GetEntityCoords(ent)
        DeleteEntity(ent)
        Object:Create(pot.objects[500], coords, function(obj)
            Entity(obj).state.water = 500 
        end)        
    end
end)

User:OnCustomEvent('drug-harvest', function(self, zoneData, posData)
    local data = posData.data
    workin[self.source] = {
        posData = posData.data,
        xPlayer = self
    }
end)

User:OnCustomEvent('drug-packing', function(self, zoneData, posData)
    local data = posData.data
    workin[self.source] = {
        posData = posData.data,
        xPlayer = self
    }
end)


Thread:Create(function()
    while true do
        Wait(5000)
        for k5,v5 in pairs(workin) do
            local self = v5.xPlayer
            if not v5.xPlayer.posData then
                workin[k5] = nil
                goto continue
            end
            if v5.posData.items then
                for k,v in pairs(v5.posData.items) do
                    self.inventory:AddItem({
                        name = k,
                        count = v
                    })
                end
            elseif v5.posData.exchangeItems then
                for k,v in pairs(v5.posData.exchangeItems) do
                    if self.inventory:RemoveItem(v.removeItem, 'name', v.amountToRemove) then
                        self.inventory:AddItem({
                            name = v.giveItem,
                            count = v.amountToGive
                        })
                    else
                        workin[k5] =nil
                    end
                end
            end
            ::continue::
        end
    end
end)

Event:Register('dwb:drugs:sell', function(source, xPlayer,entId)
    local entity = NetworkGetEntityFromNetworkId(entId)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
    local found
    local found2
    for k,v in pairs(Config.Drugs.Sell) do
        local item = xPlayer.inventory:GetItem(v.name, 'name')
        if item then
            found = item
            found2 = v
        end
    end
    if found then
        local rand = math.random(found2.chance[1], found2.chance[2])
        if rand == 2 then
            local amount = math.random(found2.amount[1], found2.amount[2])
            local price = math.random(found2.price[1], found2.price[2])
            if amount > found.count then
                amount = found.count
            end

            price = price * amount
            xPlayer.inventory:RemoveItem(found.slot, 'slot', amount)
            xPlayer.inventory:AddItem({
                name = 'black_money',
                count = price
            })
            xPlayer:ShowNotify('info', TR(found2.title), TR(found2.msg, amount, price))
        else

            xPlayer:ShowNotify('warning', 'Dilerka', 'Obywatel odrzucił twoją ofertę')

            Tablet:AddReport('police', {
                name = 'John',
                content = 'Sprzedaż narkotyków',
                data = {
                    coords = GetEntityCoords(GetPlayerPed(source)),
                    type = 'gps'
                }
            })

            for k,v in pairs(DWB.Players) do
                if v:HasJob('police') then
                    -- v:ShowNotify('info', 'Sprzedaz narkotykow', 'Sprzedaja dragi, lokalizacja w tablecie')
                    Event:TriggerNet('dwb:outlaw:drugs', k, GetEntityCoords(GetPlayerPed(source)))
                end
            end
            Event:TriggerNet('dwb:drugs:sell', source)
        end
    end
end, true)