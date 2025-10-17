User:OnLoaded(function(self)
  --SetPlayerRoutingBucket(self.source, self.source)
  --Event:TriggerNet("dwb:lobby:select:char", self.source, self.data)
end)
User:OnUnloaded(function(self) end)
User:OnEvent("mode:joined", function(self, mode, data)
  if data.mode == "boskierp" or data.mode == "militaryrp" then
    Event:TriggerNet("dwb:lobby:select:char", self.source, self.data)
  end
end)

Event:Register("dwb:lobby:char:choose", function(source, xPlayer, charId)
  SetPlayerRoutingBucket(source, 0)
  local charId = charId
  xPlayer:LoadChar(charId, function()
    Player(xPlayer.source).state.data = xPlayer
    xPlayer:CharLoaded()
  end)
end, true)

Event:Register("dwb:lobby:char:new", function(source, xPlayer, charData, gameData)
  SetPlayerRoutingBucket(source, 0)
  charData.type = xPlayer.data.mode
  local charData2 = {
    data = charData,
    inventory = Table:Copy({}),
  }
  local _xPlayer = xPlayer
  _xPlayer:CreateChar(charData2, function(charId)
    charData2.id = charId
    _xPlayer:LoadCharFromData(charId, charData2, function()
      Player(_xPlayer.source).state.data = _xPlayer
      _xPlayer:CharLoaded(true)
    end)
  end)
end, true)
