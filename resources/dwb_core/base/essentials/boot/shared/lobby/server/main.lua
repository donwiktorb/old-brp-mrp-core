User:OnLoaded(function(self)
  local lobby = Lobby:SetPlayerLobby(self.source)
  self.lobby = lobby
  Event:TriggerNet("dwb:lobby:load", self.source, Config.Lobby.Modes)
end)

Event:Register("dwb:mode:join", function(source, xPlayer, mode)
  local data = mode.data
  Lobby:RemovePlayer(source)
  xPlayer.lobby = nil
  SetPlayerRoutingBucket(source, data.bucket)
  Mode:Joined(source, data.mode)
  xPlayer:SetData("mode", data.mode)
  xPlayer:SetData("modeData", mode)
  xPlayer:TriggerEvent("mode:joined", mode, data)
  Event:TriggerNet("dwb:mode:joined4", source, mode)
end, true)
Thread:Create(function()
  for i = 0, Config.Lobby.numLobbies do
    SetRoutingBucketEntityLockdownMode(i, "strict")
  end
  while true do
    Wait(1000 * 40)
    Lobby:Refresh()
  end
end)

User:OnUnloaded(function(self)
  Lobby:RemovePlayer(self.source)
  if self.data and self.data.mode then
    Mode:Left(self.source, self.data.mode)
  end
end)

Command:Register("leave", { "leave" }, function(xPlayer, args)
  local mode = xPlayer.data.mode
  if xPlayer.data.mode then
    Mode:Left(xPlayer.source, xPlayer.data.mode)
    xPlayer:SetData("mode", false)
    local lobby = Lobby:SetPlayerLobby(xPlayer.source)
    xPlayer.lobby = lobby
    xPlayer:TriggerEvent("mode:left", mode, xPlayer.data.modeData)
    Event:TriggerNet("dwb:lobby:rejoin", xPlayer.source, xPlayer.data.modeData)
  end
end, groups)
