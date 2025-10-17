Event:Register("dwb:driving:done", function(source, xPlayer, lic, errors)
  local maxErrors = Config.Driving.maxErrors
  if errors <= maxErrors then
    xPlayer:ShowNotify("success", TR("driving"), TR("driving_pass", lic))
    xPlayer:AddLicense(lic)
  else
    xPlayer:ShowNotify("warning", TR("driving"), TR("driving_fail"))
  end
end, true)

User:OnCustomEvent("dmvschool", function(self, zoneData, posData)
  local price = zoneData.data and zoneData.data.price or posData.data and posData.data.price or 200
  local hasDMV = self:HasLicense("dmv")
  -- local type = zoneData.data and zoneData.data.license or posData.data and posData.data.license
  -- local item = xPlayer.inventory:GetItem(Config.Items.Money, 'name')
  -- if item and item.count >= price then
  --     xPlayer.inventory:RemoveItem(Config.Items.Money, 'name')
  --     Event:TriggerNet('dwb:driving:open', self.source, type)
  -- else
  --     xPlayer:ShowNotify('warning', 'Szkoła jazdy', 'Nie posiadasz wystarczającej ilości gotówki.')
  -- end
  Event:TriggerNet("dwb:driving:open", self.source, price, hasDMV)
end)

Event:Register("dwb:driving:start", function(source, xPlayer, license, hasDMV)
  local price = Config.Driving.Prices[license]
  local item = xPlayer.inventory:GetItem(Config.Items.Money, "name")
  if item and item.count >= price then
    xPlayer.inventory:RemoveItem(Config.Items.Money, "name", price)
    Event:TriggerNet("dwb:driving:start", xPlayer.source, license, hasDMV)
  else
    xPlayer:ShowNotify("warning", TR("driving"), TR("not_enough_money"))
  end
end, true)
