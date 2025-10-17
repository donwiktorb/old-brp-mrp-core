function User:GetInventory()
    return self.inventory
end

function User:GetFreeSlot()
    for i=1, 50 do
        local item = self:GetInventoryItem(i)
        if not item then
            return i
        end
    end
end

function User:GetItemBySlot(slot)
    for k,v in pairs(self.inventory) do
        if (v.slot == slot) then
            return v, k
        end
    end
end

function User:SyncInventory(inv, data, invData2)
    Event:TriggerNet('dwb:player:update', self.source, {
        inventory = self.inventory
    })
    Event:TriggerNet('dwb:inventory:sync', self.source, self.inventory, inv, data, invData2)
end

function User:ClearInventory()
    self.inventory = {}
    self:SyncInventory()
end

function User:ChangeSlot(old,new,quantity, items, invData, invData2)
    for k,v in pairs(self.inventory) do
        if (v.slot == old) then
            local count = v.count - quantity
            local item, k = self:GetItemBySlot(new)
            if count > 0 and not item then
                v.count = count
                self:AddInventoryItemNoSync(new, v.name, quantity, v.data)
            else
                v.slot = new
            end
        end
    end
    self:SyncInventory(items, invData, invData2)
end

function User:ChangeItem(old,new,quantity,data, data2, invData2)
    local item, itemIdx = self:GetItemBySlot(old)
    local item2, item2Idx = self:GetItemBySlot(new)
    if item and item2 and item.name == item2.name then
        if quantity > item.count then
            quantity = item.count
        end
        local count = item.count -quantity
        local newCount = item2.count+quantity
        if newCount <= item.limit then
            item2.count = item2.count + quantity
            item.count = item.count-quantity
            if item.count <= 0 then
                table.remove(self.inventory, itemIdx)
            end
        end
    elseif item and item2 and item.name ~= item2.name then
        item.slot = new
        item2.slot = old
    end
    self:SyncInventory(data, data2, invData2)
end





