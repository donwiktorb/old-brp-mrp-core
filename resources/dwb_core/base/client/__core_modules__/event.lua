Event = class()
Event.waiting = false
Event.token = tonumber(GlobalState.Token)

function Event:TriggerNet(name, ...)
  if Config.Debug.Log.Events then
    Log:Info(name, source, ...)
  end
  -- TriggerServerEvent('dwb:events:server:net', name, Event.token, ...)
  TriggerServerEvent(name, self.token, ...)
end

function Event:TriggerNet2(name, ...)
  if Config.Debug.Log.Events then
    Log:Info(name, source, ...)
  end
  TriggerServerEvent("dwb:events:server:net2", name, Event.token, ...)
end

function Event:Trigger(name, ...)
  if Config.Debug.Log.Events then
    Log:Info("trigger", name, ...)
  end

  local event = DWB.Events[name]
  if event then
    if type(event) == "table" then
      for _, ev in pairs(event) do
        if not ev.net then
          ev.cb(...)
        end
      end
    else
      event(...)
    end
  end
end
function Event:RemoveBy(key, value)
  for k, v in pairs(DWB.Events) do
    Wait(0)
    for k4, v4 in pairs(v) do
      Wait(0)
      if v4[key] == value then
        DWB.Events[k][k4] = nil
      end
    end

    if #v <= 0 then
      DWB.Events[k] = nil
    end
  end
end
function Event:Register(name, cb, net)
  local dbg = debug.getinfo(2, "Sl")
  if Config.Debug.Log.Events then
    Log:Info("register", name, dbg.currentline, dbg.source)
  end
  local mode = string.match(dbg.source, "%w+")
  if not DWB.Events[name] then
    DWB.Events[name] = {}
  end
  table.insert(DWB.Events[name], { cb = cb, net = net, mode = mode })
end

function Event:RegisterOnce(name, cb)
  if not DWB.Events[name] then
    DWB.Events[name] = AddEventHandler(name, function()
      RemoveEventHandler(DWB.Events[name])
      cb()
    end)
  else
    Log:Warn("Event " .. name .. " is already registered")
  end
end

function Event:RegisterNetOnce(name, cb)
  if not DWB.Events[name] then
    -- RegisterNetEvent(name)
    -- AddEventHandler -> returns one good native
    DWB.Events[name] = RegisterNetEvent(name, function()
      RemoveEventHandler(DWB.Events[name])
      cb()
    end)
  else
    Log:Warn("Event " .. name .. " is already registered")
  end
end

function Event:TriggerCb(name, cb, ...)
  if not DWB.Callbacks[name] then
    DWB.Callbacks[name] = cb
    Event:TriggerNet("dwb:callback:server", name, ...)
  else
    Log:Warn("Callback " .. name .. " is already registered")
  end
end

function Event:AsyncResponse(name, ...)
  if DWB.Callbacks[name] then
    DWB.Callbacks[name].response = { ... }
  end
end

function Event:TriggerCbSync(name, ...)
  -- if not DWB.Callbacks[name] then
  DWB.Callbacks[name] = {
    response = nil,
  }

  Event:TriggerNet("dwb:callback:server:async", name, ...)

  while not DWB.Callbacks[name].response do
    Wait(0)
  end

  local resp = DWB.Callbacks[name].response

  DWB.Callbacks[name] = nil

  return table.unpack(resp)
  -- else
  --     Log:Warn('Callback '..name..' is already registered')
  -- end
end
