User:OnLoadedChar(function(self)
  if not self.charId then
    return
  end
  self.tattoo = Mysql.Sync:fetchAll("SELECT * FROM tattoo WHERE owner = ?", {
    self.charId,
  })[1]
  if not self.tattoo or not self.tattoo.owner then
    Mysql.Async:Execute("INSERT INTO tattoo SET ?", {
      owner = self.charId,
      data = json.encode({}),
    }, function(rowsChanged)
      self.tattoo = Mysql.Sync:fetchAll("SELECT * FROM tattoo WHERE owner = ?", {
        self.charId,
      })[1]
    end)
    return
  else
    self.tattoo.data = json.decode(self.tattoo.data)
  end
  Event:TriggerNet("dwb:shop:tattoo:sync", self.source, self.tattoo.data)
end)

User:OnUnloaded(function(self)
  if self.tattoo then
    Mysql.Async:Execute("REPLACE INTO tattoo SET ?", {
      id = self.tattoo.id,
      owner = self.tattoo.owner,
      data = json.encode(self.tattoo.data),
    }, function(rowsChanged)
      Log:Info("Saved bank for ", self.source)
    end)
  end
end)

User:OnSaved(function(self)
  if not self.tattoo then
    return
  end
  Mysql.Async:Execute("REPLACE INTO tattoo SET ?", {
    id = self.tattoo.id,
    owner = self.tattoo.owner,
    data = json.encode(self.tattoo.data),
  })
end)

function User:SetTattoos(data)
  self.tattoo.data = data
end

Event:Register("dwb:cursor:submit", function(source, xPlayer, action, entityId, data, entData)
  if action.name == "tattoo-shop" and data.current.value == "open" then
    Event:TriggerNet("dwb:shop:tattoo:open", source)
  end
end, true)

Event:Register("dwb:shop:tattoo:buy", function(source, xPlayer, price, data)
  local xPlayer = DWB.Players[source]
  local money = xPlayer.inventory:GetItem("cash", "name")
  if money and money.count >= price then
    xPlayer.inventory:RemoveItem("cash", "name", price)
    xPlayer:SetTattoos(data)
  end
end, true)

User:OnCustomEvent("tattooshop", function(self, zoneData, posData)
  local source = self.source
  Event:TriggerNet("dwb:shop:tattoo:open", source)
end)
