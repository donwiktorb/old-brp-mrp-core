function comma_value(n) -- credit http://richard.warburton.it
  local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
  return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
end

User:OnCustomEvent("shop", function(self, zoneData, posData)
  local items = zoneData.data and zoneData.data.items or posData.data.items
  for k, v in pairs(items) do
    if not v.slot then
      v.slot = k
    end

    if not v.price then
      v.price = 0
    end

    local item = Item:GetInventoryFormat2(v)
    items[k] = item or v
    v.count = v.limit
  end
  local label = posData.label or zoneData.label
  local blackMoney = zoneData.data and zoneData.data.blackMoney
    or posData.data and posData.data.blackMoney
  local moneyItem = blackMoney and Config.Items.BlackMoney or Config.Items.Money
  self.inventory:OpenEasy({
    name = "shop",
    label = posData.label or zoneData.label,
    items = items,

    --align = "center",
  }, {
    canChangeSlot = false,
    canChangeItem = false,
    doNotRemoveItem = true,
  }, function(data)
    local currentItem = data.current
    local price = currentItem.price * tonumber(data.quantity)
    local items, itemCount = self.inventory:GetItems(moneyItem, "name")
    -- local itemCount = item and item.count or 0
    local has = itemCount >= price
    if not has then
      if blackMoney then
        self:ShowNotify("info", label, TR("not_enough_black_money", comma_value(price - itemCount)))
      else
        self:ShowNotify("info", label, TR("not_enough_money", comma_value(price - itemCount)))
      end
    end
    if has and currentItem.license then
      has = self:HasLicense(currentItem.license)
      if not has then
        self:ShowNotify("info", label, ("Nie masz licencji %s"):format(currentItem.license))
      end
    end
    return has
  end, function(data)
    return false
  end, function(data, inv)
    local currentItem = data.current
    local price = currentItem.price * data.quantity
    print(price)
    self.inventory:RemoveItems(moneyItem, "name", price)
  end)
end)

Event:RegisterCb("dwb:has:enough:item", function(source, cb, itemName, quantity)
  local xPlayer = DWB.Players[source]
  local item, itemCount = xPlayer.inventory:GetItems(itemName, "name")
  local has = itemCount >= quantity
  -- if has then
  --     xPlayer.inventory:RemoveItem(itemName, 'name', quantity)
  -- end
  cb(has)
end, true)

Event:Register("dwb:shop:pay", function(source, xPlayer, item, count)
  xPlayer.inventory:RemoveItems(item, "name", count)
end, true)

User:OnCustomEvent("clotheshop", function(self, zoneData, posData)
  local price = zoneData.data and zoneData.data.price or posData.data.price
  local elements = zoneData.data and zoneData.data.elements
    or posData.data and posData.data.elements
  Event:TriggerNet("dwb:open:skin:shop", self.source, elements, "cash", price)
end)

User:OnCustomEvent("rob", function(self, zoneData, posData)
  local cursorMarker = posData or Config.Gameplay.Markers[zoneData.index].coords[posData.index]
  if cursorMarker.started then
    if os.difftime(os.time(), cursorMarker.started) / 60 >= 15 then
      cursorMarker.started = nil
    else
      return self:ShowNotify("info", TR("robbery"), TR("come_back_soon"))
    end
  end

  local requiredJobs = posData.data and posData.data.requiredJobs
    or zoneData.data and zoneData.data.requiredJobs
    or {}

  local canRob = true

  for k, v in pairs(requiredJobs) do
    local count = 0
    for k2, v2 in pairs(v.job) do
      local counter, players = Job:GetPlayersByJob(v2)
      count = count + counter
    end
    if count < v.count then
      canRob = false
      self:ShowNotify("info", TR("robbery"), TR("not_enough_fraction", count, v.count))
    end
  end

  local data = posData.data
  for k, v in pairs(data.requiredItems) do
    local item = self.inventory:GetItem(k, "name")
    if not item or item.count < v then
      self:ShowNotify("info", TR("robbery"), TR("missing_item_count", k, v))
      return
    else
      self.inventory:RemoveItem(k, "name", v)
    end
  end

  if canRob then
    addReport("police", "Ochrona", "Napad na " .. data.label, {
      type = "gps",
      ["coords"] = posData.pos,
    })
    cursorMarker.started = os.time()
    Event:TriggerNet("dwb:shop:rob", self.source, data, zoneData, posData)
  end
end)

Event:Register("dwb:shop:stopped", function(source, xPlayer, data, zoneData, posData)
  local cursorMarker = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
  xPlayer:ShowNotify("info", TR("robbery"), TR("rob_cancelled"))
end, true)

Event:Register("dwb:shop:robbed", function(source, xPlayer, data, zoneData, posData)
  if data.randomizeItems then
    for i = 1, data.randomAmount do
      local item = data.rewardItems[i]
      if type(item.count) == "table" then
        item.count = math.random(table.unpack(item.count))
      end
      xPlayer.inventory:AddItem({
        name = item.name,
        count = item.count,
      })
    end
  else
    for i = 1, #data.rewardItems do
      local item = data.rewardItems[i]
      if type(item.count) == "table" then
        item.count = math.random(table.unpack(item.count))
      end
      xPlayer.inventory:AddItem({
        name = item.name,
        count = item.count,
      })
    end
  end
end, true)

-- User:OnCustomEvent('rob', function(self, zoneData, posData)
--     local cursorMarker = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
-- end)
