

function User:GetInventoryItem(slotName)
    for k,v in ipairs(self.inventory) do
        if v.slot == tonumber(slotName) or v.name == slotName then
            return v, k
        end
    end
end

function User:GetInventoryItemCount(slotName)
    local count = 0
    for k,v in ipairs(self.inventory) do
        if v.slot == tonumber(slotName) or v.name == slotName then
            count = count + v.count
        end
    end
    return count
end

function User:GetCurrentWeight()
    local weight = 0.0
    for k,v in pairs(self.inventory) do
        if v.type ~= 'weapon' then
            weight = (v.weight*v.count)+weight
        else
            weight = v.weight + weight
        end
    end
    return weight
end

function User:CanCarryItem(slotName, quantity)
    local item = DWB.Items[name]
    if not item then return end
    local playerItem = self:GetInventoryItem(slotName)
    local count = playerItem and playerItem.count or 0
    return count+quantity <= item.limit
    -- local weight = self:GetCurrentWeight()
    -- return weight+ (item.weight * quantity) < Config.Inventory.maxKgs
end

function User:GetItemLimit(name)
    return DWB.Items[name] and DWB.Items[name].limit or 1
end

function User:ClearInventory()
    self.inventory = {}

            self:SyncInventory()
end

function User:AddInventoryItem(slot2, name, count, data, replace)
    local item = DWB.Items[name]
    if item then
        local userItem = self:GetInventoryItem(name)
        local slot = slot2 or self:GetFreeSlot()
        local owned = self:GetItemBySlot(tonumber(slot))
        if not slot then return end

        if not userItem or (userItem.type ~= 'item' or userItem.count+count > userItem.limit) then
            local overLimit = userItem and userItem.count + count > userItem.limit or false
            table.insert(self.inventory, {
                name = name,
                count = tonumber(count),
                slot = not owned and tonumber(slot) or self:GetFreeSlot(),
                ['data'] = data and data or item.data and item.data or {},
                label = item.label,
                limit = item.limit,
                type = item.type,
                weight = item.weight,
                usable = DWB.UsableItemsCallbacks[name] ~= nil,
                rare = item.rare,
                canRemove = item.canRemove
            })
            self:SyncInventory()
        else
            userItem.count = userItem.count+count
            self:SyncInventory()
        end
    end
end

function User:AddInventoryItemNoSync(slot, name, count, data, replace)
    local item = DWB.Items[name]
    if item then
        local userItem = self:GetInventoryItem(name)
        local slot = slot or self:GetFreeSlot()
        if not slot then return end
            local overLimit = userItem and userItem.count + count > userItem.limit or false
            table.insert(self.inventory, {
                name = name,
                count = tonumber(count),
                slot = tonumber(slot),
                data = data or item.data or {},
                label = item.label,
                limit = item.limit,
                type = item.type,
                weight = item.weight,
                usable = DWB.UsableItemsCallbacks[name] ~= nil,
                rare = item.rare,
                canRemove = item.canRemove
            })
    end
end

function User:RemoveInventoryItemNoSync(slotName, count)
    for k,v in pairs(self.inventory) do
        if v.slot == tonumber(slotName) or v.name == slotName then
            if count and self.inventory[k].count > count then
                self.inventory[k].count = self.inventory[k].count - count
            else
                if self.removeItemCbs and self.removeItemCbs[v.name] then
                    self.removeItemCbs[v.name](self)
                end
                table.remove(self.inventory, k)
            end
            return 
        end
    end
end

function User:RemoveInventoryItem(slotName, count)
    for k,v in pairs(self.inventory) do
        if v.slot == tonumber(slotName) or v.name == slotName then
            if count and self.inventory[k].count > count then
                self.inventory[k].count = self.inventory[k].count - count
            else
                if self.removeItemCbs and self.removeItemCbs[v.name] then
                    self.removeItemCbs[v.name](self)
                end
                table.remove(self.inventory, k)
            end
            self:SyncInventory()
            return 
        end
    end
end

function User:RemoveInventoryItemByMD(slotName, k,v, count)
    for k,v in pairs(self.inventory) do
        if (v.slot == tonumber(slotName) or v.name == slotName) and (v.data and v.data[k] == v) then
            if count and self.inventory[k].count > count then
                self.inventory[k].count = self.inventory[k].count - count
            else
                table.remove(self.inventory, k)
            end
            self:SyncInventory()
            return 
        end
    end
end

function User:SetItemData(slotName, data)
    for k,v in pairs(self.inventory) do
        if v.slot == tonumber(slotName) or v.name == slotName then
            if type(data) == 'table' and not data.key then
                for k2,v2 in pairs(data) do
                    self.inventory[k].data[k2] = v2
                end
            elseif data.key then
                self.inventory[k].data[data.key] = data.value
            else
                self.inventory[k].data = data
            end
            self:SyncInventory()
            return 
        end
    end
end