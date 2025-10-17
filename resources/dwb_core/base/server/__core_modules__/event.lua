Event = class()

Event.token = GlobalState.Token

local msgpack = msgpack
local msgpack_pack = msgpack.pack
local msgpack_unpack = msgpack.unpack
local msgpack_pack_args = msgpack.pack_args

function Event:TriggerNetAsync(name, source, ...)
  if Config.Debug.Log.Events then
  end

  TriggerClientEvent("dwb:events:client:net:async", source, name, ...)
end

function Event:TriggerNet(name, _src, ...)
  local source = _src
  if Config.Debug.Log.Events then
    Log:Info(name, source, ...)
  end

  local args = { ... }
  --for k, v in pairs(args) do
  --  if not v then
  --    args[k] = false
  --  end
  --end
  table.insert(args, 1, name)
  local payload = msgpack_pack_args(table.unpack(args))
  return TriggerClientEventInternal("dwb:events:client:net", source, payload, payload:len())
  --print(name, source, ...)
  --return TriggerClientEvent("dwb:events:client:net", source, name, ...)
  --return TriggerClientEvent(name, source, ...)
end

function Event:Trigger(name, ...)
  -- -- -- -- TriggerEvent(name, ...)
  local event = DWB.Events[name]
  if event then
    if type(event) == "table" then
      for i = 1, #event do
        local ev = event[i]
        if not ev.net then
          ev.cb(...)
        end
      end
      -- for _, ev in pairs(event) do
      --     if not ev.net then
      --         ev.cb(...)
      --     end
      -- end
      return
    else
      return event(...)
    end
  end
end

function Event:RegisterNet(name, cb)
  if not DWB.Events[name] then
    DWB.Events[name] = {}
  end

  table.insert(DWB.Events[name], { cb = cb, net = true })
end

function Event:Register(name, cb, net)
  if not DWB.Events[name] then
    DWB.Events[name] = {}
  end
  if net then
    DWB.Events[name] = RegisterNetEvent(name, function(token, ...)
      local _src = source
      if Config.Debug.Log.Events then
        Log:Info(name, _src, ...)
      end
      if token == Event.token then
        cb(_src, DWB.Players[_src], ...)
      else
        Log:Info("Wrong token event:", name)
      end
    end)
  else
    table.insert(DWB.Events[name], { cb = cb, net = net })
    -- -- -- -- -- DWB.Events[name] = AddEventHandler(name, function(...)
    -- -- -- -- --     cb(...)
    -- -- -- -- -- end)
  end
  -- local function wrappedCallback(source, xPlayer, ...)
  --     local _src, _xPl = source, xPlayer
  --     local env, index = Env:getfenv(cb)
  --     if not env then
  --         env = {}
  --     end
  --     env.source = _src
  --     env.xPlayer = DWB.Players[_src]
  --     Env:setfenv(cb, env)
  --     -- debug.setupvalue(cb, 1, env)
  --     cb(...)
  -- end

  -- table.insert(DWB.Events[name], {cb = cb, net = net})
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
    DWB.Events[name] = RegisterNetEvent(name, function()
      RemoveEventHandler(DWB.Events[name])
      cb()
    end)
  else
    Log:Warn("Event " .. name .. " is already registered")
  end
end

function Event:CallServerNet(name, token, source, ...)
  local _src = source
  if token ~= Event.token then
    Log:Warn("Event", name, "tried wrong token", token, Event.token)
  end
  local events = DWB.Events[name]
  if events then
    if type(events) == "table" then
      for i = 1, #events do
        local ev = events[i]
        if ev.net then
          ev.cb(_src, DWB.Players[_src], ...)
        end
      end
      -- for _, ev in pairs(events) do
      --     if ev.net then
      --         ev.cb(source, DWB.Players[source], ...)
      --     end
      -- end
    end
  end
end

function Event:CallServerNet2(name, token, source, ...)
  if token ~= Event.token then
    Log:Warn("Event", name, "tried wrong token", token, Event.token)
  end
  local events = DWB.Events[name]
  if events then
    if type(events) == "table" then
      for _, ev in pairs(events) do
        if ev.net then
          ev.cb(source, DWB.Players[source], ...)
        end
      end
    end
  end
end

function Event:CallServer(name, ...)
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
end

function Event:RegisterCb(name, cb)
  if not DWB.Callbacks[name] then
    DWB.Callbacks[name] = cb
  end
end
