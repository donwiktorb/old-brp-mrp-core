
Event:RegisterCb('dwb:mechanic:buy', function(source, cb, price)
	local xPlayer = DWB.Players[source]

    xPlayer.bank:Transaction(0, 'Mechanik', 'Tune', price)


    cb(true)
    -- if xPlayer.inventory:RemoveItem(Config.Items.Money, 'name', price) then
    --     cb(true)
    -- else
    --     cb(false)
    -- end

    -- local item = xPlayer:GetInventoryItem(Config.MoneyItem)

	-- if item and item.count >= price then
	-- 	xPlayer:RemoveInventoryItem(Config.MoneyItem, price)
	-- 	cb(true)
	-- else
	-- 	cb(false)
	-- end
end)

User:OnCustomEvent('wash', function(self, zoneData, posData)
    local xPlayer = self
    if not self.busy then
        local veh  = GetVehiclePedIsIn(GetPlayerPed(self.source), false)
        if DoesEntityExist(veh) then
            local price = zoneData.data and zoneData.data.price or posData.data and posData.data.price or 200
            local time = zoneData.data and zoneData.data.time or posData.data and posData.data.time or 30
            local item, itemCount = xPlayer.inventory:GetItems(Config.Items.Money, 'name')
            local label = posData.label or zoneData.label
            if itemCount >= price then
                self.busy = true
                xPlayer.inventory:RemoveItems(Config.Items.Money, 'name', price)
                Event:TriggerNet('dwb:mechanic:wash', self.source, price, time or 30)
            else
                self:ShowNotify('info', label, TR("not_enough_money", comma_value(price-itemCount)))
            end
        end
    end
end)

User:OnCustomEvent('autorepair', function(self, zoneData, posData)
    local xPlayer = self
    if not self.busy then
        local veh  = GetVehiclePedIsIn(GetPlayerPed(self.source), false)
        if DoesEntityExist(veh) then
            local price = zoneData.data and zoneData.data.price or posData.data and posData.data.price or 200
            local time = zoneData.data and zoneData.data.time or posData.data and posData.data.time or 30
            local item, itemCount = xPlayer.inventory:GetItems(Config.Items.Money, 'name')
            local label = posData.label or zoneData.label
            if itemCount >= price then
                xPlayer.inventory:RemoveItems(Config.Items.Money, 'name', price)
                self.busy = true
                Event:TriggerNet('dwb:mechanic:fix', self.source, price, time or 30)
            else
                self:ShowNotify('info', label, TR("not_enough_money", comma_value(price-itemCount)))
            end
        end
    end
end)

Event:Register('dwb:mechanic:remove:item', function(source, xPlayer)
    xPlayer.inventory:RemoveItem('fixkit', 'name', 1)
end, true)

Event:Register('dwb:mechanic:not:busy', function(source, xPlayer)
    xPlayer.busy = false
end, true)

Item:RegisterUsable('fixkit', function(source)
    -- -- local item = xPlayer:GetInventoryItem('repair_kit')
    -- -- -- local veh = GetVehiclePedIsIn(GetPlayerPed(source), false)
    -- -- -- if not veh then
    -- -- --     -- xPlayer:RemoveInventoryItem('repair_kit', 1)
    -- -- --     Event:TriggerNet('dwb:mechanic:fix', source)
    -- -- -- end

    Event:TriggerNet('dwb:mechanic:fix', source)
end)

-- -- Event:Register('dwb:mechanic:colors', function(source, xPlayer,colors)
-- --     SaveResourceFile('dwb', 'xd2.json', colors, -1)
-- -- end, true)

-- -- Thread:Create(function()
-- --     local xd = {}
-- --     local xd2 = json.decode(LoadResourceFile('dwb', 'xd.json'))
-- --     for k,v in pairs(xd2) do
-- --         table.insert(xd, {
-- --             label = v.ColorName,
-- --             color = v.Index
-- --         })
-- --     end
-- --     SaveResourceFile('dwb', 'xd.json', json.encode(xd), -1)
-- -- end)

User:OnCustomEvent('tune', function(self, zoneData, posData)
    Event:TriggerNet('dwb:mechanic:open' , self.source)
end)