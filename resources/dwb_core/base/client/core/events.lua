RegisterNetEvent("dwb:events:client:net:async", function(name, ...)
  while not DWB.Events[name] do
    Citizen.Wait(1000)
  end
  local events = DWB.Events[name]
  if type(events) == "table" then
    for _, ev in pairs(events) do
      if ev.net then
        ev.cb(...)
      end
    end
  end
end)

RegisterNetEvent("dwb:events:client:net", function(name, ...)
  if Config.Debug.Log.Events then
    Log:Info("event", name, ...)
  end
  while not DWB.Events[name] do
    Wait(1000)
  end
  local events = DWB.Events[name]
  if type(events) == "table" then
    for _, ev in pairs(events) do
      if ev.net then
        ev.cb(...)
      end
    end
  else
    Log:Error("no event table")
  end
end)

AddEventHandler("dwb:client", function(name, ...)
  local events = DWB.Events[name]
  if events then
    if type(events) == "table" then
      for _, ev in pairs(events) do
        if not ev.net then
          ev.cb(...)
        end
      end
    end
  end
end)

Event:Register("dwb:callback:server:response", function(name, ...)
  if DWB.Callbacks[name] then
    DWB.Callbacks[name](...)
    DWB.Callbacks[name] = nil
  else
    Log:Info("Callback " .. name .. " doesnt exist")
  end
end, true)

Event:Register("dwb:callback:server:response:async", function(name, ...)
  Event:AsyncResponse(name, ...)
end, true)
