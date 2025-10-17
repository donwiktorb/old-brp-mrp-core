User = class(nil, {
  SyncDataCbs = {},
  SyncCharDataCbs = {},
  LoadedCharCbs = {},
  UnloadedCharCbs = {},
})

function User:IsLoaded()
  return DWB.PlayerLoaded
end

function User:GetPlayerData()
  return DWB.PlayerData
end

function User:Set(key, value)
  DWB.PlayerData[key] = value
end

function User:OnSyncCharData(cb)
  table.insert(self.SyncCharDataCbs, cb)
end

function User:OnLoadedChar(cb, highPriority)
  if self.InitLoadedChar then
    return cb(self)
  end
  if not highPriority then
    table.insert(self.LoadedCharCbs, cb)
  else
    table.insert(self.LoadedCharCbs, 1, cb)
  end
end

function User:LoadedChar(cb, ...)
  self.InitLoadedChar = true
  for k, v in pairs(self.LoadedCharCbs) do
    Wait(0)
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self, ...)
  end

  if cb then
    cb()
  end
end

function User:UnloadedChar(cb)
  self.InitLoadedChar = false
  for k, v in pairs(self.UnloadedCharCbs) do
    Wait(0)
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:OnUnloadedChar(cb)
  table.insert(self.UnloadedCharCbs, cb)
end

function User:SyncCharData(cb, key, value)
  for k, v in pairs(self.SyncCharDataCbs) do
    Wait(0)
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self, key, value)
  end

  if cb then
    cb()
  end
end

function User:OnSyncData(name, cb)
  table.insert(self.SyncDataCbs, {
    name = name,
    cb = cb,
  })
end
