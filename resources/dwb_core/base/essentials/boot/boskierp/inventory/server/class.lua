Inventory = class(nil, Inventory, nil, User)
Inventory.ChangedItemCbs = {}
Inventory.RemovedItemCbs = {}
Inventory.AddedItemCbs = {}

function Inventory:RemovedItem(item)
  -- if self.RemovedItemCbs[item.name] then
  --     for k,v in pairs(self.RemovedItemCbs[item.name]) do
  --         xpcall(v, function(e)
  --             Log:Error('Erorr Joined', json.encode(e))
  --         end, self, item)
  --     end
  -- end

  Event:Trigger("dwb:inventory:item:remove", self, item)
end

function Inventory:AddedItem(item)
  -- if self.AddedItemCbs[item.name] then
  --     for k,v in pairs(self.AddedItemCbs[item.name]) do
  --         xpcall(v, function(e)
  --             Log:Error('Erorr Joined', json.encode(e))
  --         end, self, item)
  --     end
  -- end
  Event:Trigger("dwb:inventory:item:add", self, item)
end

function Inventory:OnRemoveItem(name, cb)
  if not self.RemovedItemCbs[name] then
    self.RemovedItemCbs = {}
  end
  table.insert(self.RemovedItemCbs[name], cb)
end

function Inventory:OnAddItem(name, cb)
  if not self.AddedItemCbs[name] then
    self.AddedItemCbs = {}
  end
  table.insert(self.AddedItemCbs[name], cb)
end

function Inventory:RemoveRandomItems(m)
  local inv = self.char.inventory or 0
  for i = 1, math.floor(#inv / m) do
    local item = inv[i]
    if item then
      table.remove(inv, i)
    end
  end
  self:SyncChar("inventory")
end

function Inventory:FixSlot()
  for k, v in pairs(self.char.inventory) do
    local items, count = self:GetItems(v.slot, "slot")
    if count > 1 then
      v.slot = self:GetFreeSlot() or math.random(1, 50)
    end
  end
end

function Inventory:Load() end

function Inventory:GetItems(value, key)
  local items = {}
  local itemCount = 0

  for k, v in pairs(self.char.inventory) do
    if v[key] == value then
      itemCount = itemCount + v.count
      table.insert(items, v)
    end
  end

  return items, itemCount
end

function Inventory:Sort()
  local items = {}
  function isInItems(name, count)
    for k, v in pairs(items) do
      local newCount = v.count + count
      if v.name == name and newCount <= v.limit then
        return v
      end
    end
  end
  for k, v in pairs(self.char.inventory) do
    local itm = isInItems(v.name, v.count)
    if itm then
      itm.count = itm.count + v.count
    else
      table.insert(items, v)
    end
  end
  local slots = {}
  for k, v in pairs(items) do
    if not v.slot then
      v.slot = math.random(1, 50)
    end
    if slots[v.slot] then
      v.slot = math.random(1, 50)
    end
    slots[v.slot] = true
  end
  self.char.inventory = items
  self:Sync()
end

function Inventory:Clear()
  self.char.inventory = {}
  self:Sync()
end

function Inventory:RemoveItems(value, key, count)
  for k, v in pairs(self.char.inventory) do
    if v[key] == value then
      local newCount = v.count - count
      if newCount > 0 then
        v.count = newCount
        return
      else
        table.remove(self.char.inventory, k)
      end
      count = count - v.count
    end
  end
end

function Inventory:GetItem2(value, key, itemData)
  for k, v in pairs(self.char.inventory) do
    if v[key] == value then
      return v, k
    end
  end
end

function Inventory:GetItem(value, key, inv)
  if not key then
    for k, v in pairs(inv or self.char.inventory) do
      if v.slot == tonumber(value) or v.name == value then
        return v, k
      end
    end
  else
    for k, v in pairs(inv or self.char.inventory) do
      if v[key] == value then
        return v, k
      end
    end
  end
end

function Inventory:GetFreeSlot2(item)
  local found = false

  for i = 1, 50 do
    -- local itm = self.char.inventory[i]
    -- local itm = self.char.inventory[i]
    local itm = self:GetItem(i, "slot")
    if itm then
      if itm.name == item.name then
        local newCount = itm.count + item.count
        if newCount <= item.limit then
          return i, itm
        end
      end
    elseif not found then
      found = i
    end
  end

  return found
end

function Inventory:GetFreeSlot()
  for i = 1, 50 do
    local item = self:GetItem(i, "slot")
    if not item then
      return i
    end
  end
end

function Inventory:SetItemData(value, key, data)
  local item, idx = self:GetItem(value, key)
  if item then
    if not item.data then
      item.data = {}
    end
    if data.key then
      item.data[data.key] = data.value
    else
      for k, v in pairs(data) do
        item.data[k] = v
      end
    end
  end
end

function Inventory:_AddItem(itemData)
  if not itemData.slot then
    itemData.slot = self:GetFreeSlot()
  end
  local item = Item:GetInventoryFormat(itemData)
  table.insert(self.char.inventory, item)
end

function Inventory:_RemoveItem(value, key, count)
  if key then
    local item, idx = self:GetItem(value, key)
    table.remove(self.char.inventory, idx)
  else
    local item, idx = self:GetItem(value)
    table.remove(self.char.inventory, idx)
  end
end

function Inventory:AddRemove(inv, itemData, count, currentSlot, targetSlot, doNotRemove, data)
  local invItem, itemIdx = self:GetItem(currentSlot, "slot", inv) -- itemek z inv 2
  local itemSlot = itemData.slot
  itemData = Item:GetInventoryFormat(invItem)
  itemData.slot = targetSlot
  if invItem then
    if count > invItem.limit then
      count = invItem.limit
    end

    if count > invItem.count then
      count = invItem.count
    end

    data.quantity = count

    itemData.count = count

    table.insert(self.char.inventory, itemData)

    local newCount = invItem.count - count
    if newCount > 0 then
      if not doNotRemove then
        invItem.count = newCount
      end
    else
      if not doNotRemove then
        table.remove(inv, itemIdx)
      end
    end

    self:AddedItem(itemData)

    return true
  end
end

function Inventory:ChangeSlot(inv, itemData, count, currentSlot, targetSlot)
  if not inv then
    local invItem, itemIdx = self:GetItem(currentSlot, "slot") -- itemek z inv
    if count > invItem.count then
      count = invItem.count
    end

    local newCount = invItem.count - count

    if newCount > 0 then
      invItem.count = newCount
    else
      table.remove(self.char.inventory, itemIdx)
    end

    local newItem = {}

    for k, v in pairs(invItem) do
      newItem[k] = v
    end

    newItem.slot = targetSlot
    newItem.count = count

    table.insert(self.char.inventory, newItem)

    return true
  else
    local invItem, itemIdx = self:GetItem(currentSlot, "slot", inv) -- itemek z inv
    if count > invItem.count then
      count = invItem.count
    end

    local newCount = invItem.count - count

    if newCount > 0 then
      invItem.count = newCount
    else
      table.remove(inv, itemIdx)
    end

    local newItem = {}

    for k, v in pairs(invItem) do
      newItem[k] = v
    end

    newItem.slot = targetSlot
    newItem.count = count

    table.insert(inv, newItem)

    return true
  end
end

function Inventory:RemoveAdd(inv, itemData, count, currentSlot, targetSlot, data)
  --- ten sam slot co item = error z jakiegos powodu do szafki wejdzie np telefon ae zamieni sie z tym itemkiem ktory faktycznie wejdzie i kopiwaonko

  local invItem, itemIdx = self:GetItem(currentSlot, "slot") -- itemek z inv

  itemData = Item:GetInventoryFormat(invItem)
  itemData.slot = targetSlot
  if invItem then
    if count > invItem.limit then
      count = invItem.limit
    end

    if count > invItem.count then
      count = invItem.count
    end

    itemData.count = count

    data.quantity = count

    table.insert(inv, itemData)

    local newCount = invItem.count - count

    if newCount > 0 then
      invItem.count = newCount
    else
      table.remove(self.char.inventory, itemIdx)
      self:RemovedItem(invItem)
    end

    return true
  end
end

function Inventory:ChangedItem(invItem, targetInvItem)
  Event:Trigger("dwb:inventory:item:change", self, invItem, targetInvItem)
  local obj = self.ChangedItemCbs[invItem.name] or self.ChangedItemCbs[invItem.type]
  if obj and (obj[targetInvItem.name] or obj[targetInvItem.type]) then
    for k, v in pairs(obj[targetInvItem.name] or obj[targetInvItem.type]) do
      xpcall(v, function(e)
        Log:Error("Erorr Joined", json.encode(e))
      end, self, invItem, targetInvItem)
    end
    self:Sync()
  end
end

function Inventory:OnChangedItem(itemName, itemName2, cb)
  if not self.ChangedItemCbs[itemName] then
    self.ChangedItemCbs[itemName] = {}
  end

  if not self.ChangedItemCbs[itemName][itemName2] then
    self.ChangedItemCbs[itemName][itemName2] = {}
  end

  table.insert(self.ChangedItemCbs[itemName][itemName2], cb)
end

function Inventory:ChangeItem(
  inv,
  itemData,
  count,
  currentSlot,
  targetSlot,
  from,
  same,
  doNotRemove,
  data
)
  if not inv then
    local invItem, itemIdx = self:GetItem(currentSlot, "slot") -- itemek z inv
    local targetInvItem, targetItemIdx = self:GetItem(targetSlot, "slot") -- itemek z inv
    if invItem and targetInvItem and invItem.name == targetInvItem.name then
      if count > invItem.count then
        count = invItem.count
      end

      local newCount = targetInvItem.count + count
      if newCount <= invItem.limit then
        targetInvItem.count = newCount
        local newCount = invItem.count - count
        if newCount > 0 then
          invItem.count = newCount
          return true
        else
          table.remove(self.char.inventory, itemIdx)
          return true
        end
      end
    elseif invItem and targetInvItem then
      self:ChangedItem(invItem, targetInvItem)
    end
  elseif from then
    local invItem, itemIdx = self:GetItem(currentSlot, "slot") -- itemek z inv
    local targetInvItem, targetItemIdx = self:GetItem(targetSlot, "slot", inv) -- itemek z inv
    if invItem and targetInvItem and invItem.name == targetInvItem.name then
      if count > invItem.count then
        count = invItem.count
      end

      data.quantity = count

      local newCount = targetInvItem.count + count
      if newCount <= invItem.limit then
        targetInvItem.count = newCount
        local newCount = invItem.count - count
        if newCount > 0 then
          invItem.count = newCount
          return true
        else
          table.remove(self.char.inventory, itemIdx)
          return true
        end
      end
    end
  elseif not same then
    local invItem, itemIdx = self:GetItem(currentSlot, "slot", inv) -- itemek z inv
    local targetInvItem, targetItemIdx = self:GetItem(targetSlot, "slot") -- itemek z inv
    if invItem and targetInvItem and invItem.name == targetInvItem.name then
      if count > invItem.count then
        count = invItem.count
      end

      data.quantity = count

      local newCount = targetInvItem.count + count
      if newCount <= invItem.limit then
        targetInvItem.count = newCount
        local newCount = invItem.count - count
        if newCount > 0 then
          if not doNotRemove then
            invItem.count = newCount
          end
          return true
        else
          if not doNotRemove then
            table.remove(inv, itemIdx)
          end
          return true
        end
      end
    end
  else
    local invItem, itemIdx = self:GetItem(currentSlot, "slot", inv) -- itemek z inv
    local targetInvItem, targetItemIdx = self:GetItem(targetSlot, "slot", inv) -- itemek z inv
    if invItem and targetInvItem and invItem.name == targetInvItem.name then
      if count > invItem.count then
        count = invItem.count
      end

      local newCount = targetInvItem.count + count
      if newCount <= invItem.limit then
        targetInvItem.count = newCount
        local newCount = invItem.count - count
        if newCount > 0 then
          invItem.count = newCount
          return true
        else
          table.remove(inv, itemIdx)
          return true
        end
      end
    end
  end
end

function Inventory:AddItem(itemData)
  local slot = itemData.slot
  local item = Item:GetInventoryFormat(itemData)
  if not slot then
    local newSlot, newItem = self:GetFreeSlot2(item)
    if newSlot then
      if newItem then
        newItem.count = newItem.count + item.count
        Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
        return true
      else
        item.slot = newSlot
        table.insert(self.char.inventory, item)
        Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
        return true
      end
    end
  else
    local newItem = self:GetItem(slot, "slot")
    if newItem then
      if newItem.name == item.name then
        local newCount = newItem.count + item.count
        if newCount <= item.limit then
          newItem.count = newCount
          Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
          return true
        else
          item.slot = self:GetFreeSlot()
          table.insert(self.char.inventory, item)
          Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
          return true
        end
      else
        item.slot = self:GetFreeSlot()
        table.insert(self.char.inventory, item)
        Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
        return true
      end
    else
      item.slot = self:GetFreeSlot()
      table.insert(self.char.inventory, item)
      Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, false)
      return true
    end
  end
end

function Inventory:RemoveItem(value, key, count, sync)
  local item, idx = self:GetItem(value, key)
  if not item then
    return
  end
  local newCount = item.count - count
  if newCount == 0 then
    self:RemovedItem(item)
    table.remove(self.char.inventory, idx)
    Event:TriggerNet("dwb:inventory:notify", self.source, item.name, item.count, true)
    if sync then
      self:Sync()
    end
    return true
  elseif newCount > 0 then
    item.count = newCount
    Event:TriggerNet("dwb:inventory:notify", self.source, item.name, count, true)

    if sync then
      self:Sync()
    end
    return true
  end
end

function Inventory:Sync(inv)
  local data = inv or self.currentInventory and self.currentInventory.data or {}
  data.slots = data.slots or 50
  local Inventories = {
    {
      name = "inventory",
      label = "Ekwipunek",
      weight = 0.0,
      maxWeight = 40.0,
      items = self.char.inventory,
    },
    {
      name = data.name or "drop",
      label = data.label or "Ziemia",
      items = data.items or {},
      weight = data.weight or 40.0,
      maxWeight = 40.0,
      slots = data.slots or 50,
      align = data.align,
    },
  }

  Event:TriggerNet("dwb:inventory:open", self.source, Inventories)
end

function Inventory:Changed(type, itemData)
  if type == "removed" then
    self.currentInventory.removedCb(itemData)
  elseif type == "added" then
    self.currentInventory.addedCb(itemData)
  elseif type == "change" then
    self.currentInventory.itemChange(itemData)
  elseif type == "change-slot" then
    self.currentInventory.slotChange(itemData)
  end
end

function Inventory:Open(data, addedCb, removedCb, itemChange, slotChange, closedCb)
  data.slots = data.slots or 50
  self.currentInventory = {
    data = data,
    addedCb = addedCb,
    removedCb = removedCb,
    itemChange = itemChange,
    slotChange = slotChange,
    closedCb = closedCb,
  }

  self:Sync()
end

function Inventory:Close()
  if self.currentInventory and self.currentInventory.closedCb then
    self.currentInventory.closedCb()
  end
  self.currentInventory = nil
end

function Inventory:OpenEasy(pedInventory, data, canAddCb, canRemoveCb, onChangeCb, onCloseCb)
  -- local ped = entity
  local canChangeSlot = data and data.canChangeSlot
  local canChangeItem = data and data.canChangeItem
  local doNotRemoveItem = data and data.doNotRemoveItem
  local autoSync = data and data.autoSync or true
  self:Open(pedInventory, function(data)
    if canAddCb(data) then
      if
        self:AddRemove(
          pedInventory.items,
          data.current,
          data.quantity,
          data.currentSlot,
          data.targetSlot,
          doNotRemoveItem,
          data
        )
      then
        onChangeCb(data, pedInventory)
        if autoSync then
          self:Sync(pedInventory)
        end
      end
    end
  end, function(data)
    if canRemoveCb(data) then
      if
        self:RemoveAdd(
          pedInventory.items,
          data.current,
          data.quantity,
          data.currentSlot,
          data.targetSlot,
          data
        )
      then
        onChangeCb(data, pedInventory)
        if autoSync then
          self:Sync(pedInventory)
        end
      end
    end
  end, function(data)
    -- item chane
    if data.oldInv == "inventory" and data.newInv == "inventory" then
      if self:ChangeItem(false, data.current, data.quantity, data.currentSlot, data.targetSlot) then
        self:Sync()
      end
    elseif data.oldInv == "inventory" then
      if canChangeItem then
        if
          self:ChangeItem(
            pedInventory.items,
            data.current,
            data.quantity,
            data.currentSlot,
            data.targetSlot,
            true,
            nil,
            doNotRemoveItem,
            data
          )
        then
          onChangeCb(data, pedInventory)
          if autoSync then
            self:Sync(pedInventory)
          end
          -- Entity(ped).state.inventory = pedInventory
        end
      end
    elseif data.newInv == "inventory" then
      if canAddCb(data) then
        if
          self:ChangeItem(
            pedInventory.items,
            data.current,
            data.quantity,
            data.currentSlot,
            data.targetSlot,
            false,
            nil,
            doNotRemoveItem,
            data
          )
        then
          onChangeCb(data, pedInventory)
          if autoSync then
            self:Sync(pedInventory)
          end
          -- Entity(ped).state.inventory = pedInventory
          -- self:Sync(pedInventory)
        end
      end
    else
      if canChangeItem then
        if canRemoveCb(data) then
          if
            self:ChangeItem(
              pedInventory.items,
              data.current,
              data.quantity,
              data.currentSlot,
              data.targetSlot,
              false,
              true,
              doNotRemoveItem,
              data
            )
          then
            onChangeCb(data, pedInventory)
            -- Entity(ped).state.inventory = pedInventory
            if autoSync then
              self:Sync(pedInventory)
            end
          end
        end
      end
    end
  end, function(data)
    -- slot change
    -- -- print(data)
    if data.newInv == "inventory" then
      if
        self:ChangeSlot(
          nil,
          data.current,
          data.quantity,
          data.currentSlot,
          data.targetSlot,
          false,
          true
        )
      then
        self:Sync(pedInventory)
      end
    else
      if canChangeSlot then
        if
          self:ChangeSlot(
            pedInventory.items,
            data.current,
            data.quantity,
            data.currentSlot,
            data.targetSlot,
            false,
            true
          )
        then
          onChangeCb(data, pedInventory)
          if autoSync then
            -- Entity(ped).state.inventory = pedInventory
            self:Sync(pedInventory)
          end
        end
      end
    end
  end, function(data)
    if onCloseCb then
      onCloseCb(data, pedInventory)
    end
  end)
end

function Inventory:OpenEntity(entity, inv, noDelete)
  Entity(entity).state.occupied = true
  self:OpenEasy(inv, {
    canChangeSlot = true,
    canChangeItem = true,
    doNotRemoveItem = false,
    autoSync = true,
  }, function(data)
    return true
  end, function(data)
    return true
  end, function(data, inv)
    Entity(entity).state.data = inv
  end, function(data, inv)
    if #inv.items <= 0 and not noDelete then
      DeleteEntity(entity)
    else
      Entity(entity).state.data = inv
      Entity(entity).state.occupied = false
    end
  end)
end

function Inventory:OpenSimple(data, closeCb)
  self:OpenEasy(data, {
    canChangeSlot = true,
    canChangeItem = true,
    doNotRemoveItem = false,
  }, function(data)
    return true
  end, function(data)
    return true
  end, function(data, inv)
    closeCb(data, inv)
    return true
  end)
end
