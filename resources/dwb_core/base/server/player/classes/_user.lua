User = class(function(this, data, loaded)
  for k, v in pairs(data) do
    this[k] = v
  end

  -- this:Joined()
end, {
  JoinedCbs = {},
  LoadedCbs = {},
  LoadedCharCbs = {},
  UnloadedCharCbs = {},
  SavedCbs = {},
  SavedCharCbs = {},
  UnloadedCbs = {},
  ChangedCbs = {},
  CustomEvents = {},
  Events = {},
})

function User:Set(k, v)
  if type(k) == "table" then
    for n, m in pairs(k) do
      self[n] = m
    end
  else
    self[k] = v
  end
end

function User:Get(k)
  return self[k]
end

function User:SetData(k, v)
  if type(k) == "table" then
    for n, m in pairs(k) do
      self.data[n] = m
    end
  else
    self.data[k] = v
  end
  self:SyncData(k)
end

function User:GetData(k)
  return self.data[k]
end

function User:SetCharData(k, v)
  if type(k) == "table" then
    for n, m in pairs(k) do
      self.char.data[n] = m
    end
  else
    self.char.data[k] = v
  end

  self:SyncChar("data")
end

function User:SetChar(k, v)
  if type(k) == "table" then
    for n, m in pairs(k) do
      self.char[n] = m
    end
  else
    self.char[k] = v
  end
  self:SyncChar(k)
end

function User:GetChar(k)
  return self.char[k]
end

function User:GetCharsByKey(key, val)
  local chars = {}
  for k, v in pairs(self.chars) do
    if v[key] and v[key] == val then
      table.insert(chars, v)
    end
  end
  return chars
end

function User:GetCharData(k)
  if not k then
    return self.char.data
  end
  return self.char.data[k]
end

function User:OnJoined(cb)
  if self.Joined then
    return cb(self)
  end
  table.insert(self.JoinedCbs, cb)
end

function User:OnLoaded(cb)
  if self.InitLoaded then
    return cb(self)
  end
  table.insert(self.LoadedCbs, cb)
end

function User:OnEvent(name, cb)
  if not self.Events[name] then
    self.Events[name] = {}
  end
  table.insert(self.Events[name], cb)
end

function User:OnCustomEvent(name, cb)
  if not self.CustomEvents[name] then
    self.CustomEvents[name] = {}
  end
  table.insert(self.CustomEvents[name], cb)
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

function User:OnChanged(cb)
  table.insert(self.ChangedCbs, cb)
end

function User:OnSaved(cb)
  table.insert(self.SavedCbs, cb)
end

function User:OnSavedChar(cb)
  table.insert(self.SavedCharCbs, cb)
end

function User:OnUnloaded(cb)
  table.insert(self.UnloadedCbs, cb)
end

function User:OnUnloadedChar(cb)
  table.insert(self.UnloadedCharCbs, cb)
end

function User:Joined(cb)
  self.Joined = true

  for k, v in pairs(self.JoinedCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr Joined", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:CustomEvent(name, ...)
  if not self.CustomEvents[name] then
    Log:Info("No custom event", name)
    return
  end
  for k, v in pairs(self.CustomEvents[name]) do
    xpcall(v, function(e)
      Log:Error("Erorr Joined", json.encode(e))
    end, self, ...)
  end
end

function User:TriggerEvent(name, ...)
  if not self.Events[name] then
    Log:Info("No custom event", name)
    return
  end
  for k, v in pairs(self.Events[name]) do
    xpcall(v, function(e)
      Log:Error("Erorr Joined", json.encode(e))
    end, self, ...)
  end
end

function User:Loaded(cb)
  self.InitLoaded = true
  for k, v in pairs(self.LoadedCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:LoadedChar(cb)
  self.InitLoadedChar = true
  for k, v in pairs(self.LoadedCharCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:UnloadedChar(cb)
  self.InitLoadedChar = false
  for k, v in pairs(self.UnloadedCharCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr Loaded", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:Changed()
  for k, v in pairs(self.ChangedCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr changed", json.encode(e))
    end, self)
  end
end

function User:Saved(cb)
  for k, v in pairs(self.SavedCbs) do
    xpcall(v, function(e)
      Log:Error("Error saving", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:SavedChar(cb)
  for k, v in pairs(self.SavedCharCbs) do
    xpcall(v, function(e)
      Log:Error("Error saving", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:Unloaded(cb)
  self.InitLoaded = false
  for k, v in pairs(self.UnloadedCbs) do
    xpcall(v, function(e)
      Log:Error("Erorr exiting", json.encode(e))
    end, self)
  end

  if cb then
    cb()
  end
end

function User:CharLoaded(...)
  Event:TriggerNet("dwb:player:char:loaded", self.source, self.char, ...)
end

function User:CharUnloaded()
  Event:TriggerNet("dwb:player:char:unloaded", self.source, self.char)
end

function User:SyncData(k)
  if not k then
    Event:TriggerNet("dwb:player:sync:data", self.source, self.data)
  else
    Event:TriggerNet("dwb:player:sync:data", self.source, self.data[k], k)
  end
end

function User:SyncChar(k)
  if not k then
    Event:TriggerNet("dwb:player:sync:char", self.source, self.char)
  else
    Event:TriggerNet("dwb:player:sync:char", self.source, self.char[k], k)
  end
end

function User:ServerSync()
  if self.InitLoaded and not DoesPlayerExist(self.source) then
    Log:Error("player not playin", self.source)
    self:Unload()
    -- DWB.Players[self.source] = nil
    return
  end
  local ped = GetPlayerPed(self.source)
  local pos = GetEntityCoords(ped)
  if self.char then
    self.char.position = pos
  end
end

-- function User:SyncData(name, value)
--     Event:TriggerNet('dwb:player:sync:data', self.source, name, value)
-- end

-- -- Garage = class(nil, nil, nil, User)

-- -- function Garage:Open()
-- --     print(self.source)
-- --     self.test = 'x d'
-- --     print(self.test)
-- -- end

-- -- local pl = User({source = 5})
-- -- local garage = Garage(pl)
-- -- garage:Open()
-- -- print(json.encode(pl), json.encode(garage))
-- -- -- user, set, source, identifier, wszystkie funkcje

-- -- -- garage , source, identifier, Load, same wartosci
