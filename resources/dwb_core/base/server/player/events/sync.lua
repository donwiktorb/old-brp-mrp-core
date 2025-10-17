User.OnKilledCbs = {}
User.OnKilledByPlayerCbs = {}
User.OnRespawnCbs = {}

function User:OnRespawn(cb)
  table.insert(self.OnRespawnCbs, cb)
end

function User:OnKilled(cb)
  table.insert(self.OnKilledCbs, cb)
end

function User:OnKilledByPlayer(cb)
  table.insert(self.OnKilledByPlayerCbs, cb)
end

function User:Killed(data, cb)
  for k, v in pairs(self.OnKilledCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr Joined", json.encode(e))
    end, self, data)
  end

  if cb then
    cb()
  end
end

function User:KilledByPlayer(data, cb)
  for k, v in pairs(self.OnKilledByPlayerCbs) do
    local done, res = xpcall(v, function(e)
      Log:Error("Erorr killed", json.encode(e))
    end, self, data)
  end

  if cb then
    cb()
  end
end

function User:Respawn()
  self:Respawned(self.char and function()
    self:SetCharData("IsDead", false)
  end)
  Event:TriggerNet("dwb:player:respawn", self.source)
end

function User:Respawned(cb)
  for k, v in pairs(self.OnRespawnCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr killed", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

Event:Register("dwb:player:died", function(source, xPlayer, data)
  if data.killedByPlayer then
    xPlayer:KilledByPlayer(data, xPlayer.char and function()
      data.IsDead = true
      xPlayer:SetCharData({
        IsDead = true,
        deadData = data,
      })
    end)
  else
    xPlayer:Killed(data, xPlayer.char and function()
      data.IsDead = true
      xPlayer:SetCharData({
        IsDead = true,
        deadData = data,
      })
    end)
  end
end, true)
Event:Register("dwb:player:respawn", function(source, xPlayer, data)
  xPlayer:Respawned(function()
    xPlayer:SetCharData("IsDead", false)
  end)
end, true)
