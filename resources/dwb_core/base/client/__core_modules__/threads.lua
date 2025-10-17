Thread = class()

Thread.threads = {}
Thread.states = {}

function Thread:RemoveBy(k, v)
  for k4, v4 in pairs(self.threads) do
    for m, n in pairs(v4) do
      if n[k] == v then
        TerminateThread(n.id)
        self.threads[k4][m] = nil
      end
    end
    if #v4 <= 0 then
      self.threads[k4] = nil
    end
  end
end
function Thread:Exists(name)
  return self.threads[name]
end

function Thread:CreateEx(name, cb, time)
  local dbg = debug.getinfo(2, "Sl")
  if not cb then
    cb = name
    name = math.random(1, 9999)
  end

  self.threads[name] = {}
  -- Citizen.CreateThread(cb)
  Citizen.CreateThread(function(id)
    local line = dbg.currentline
    local source = dbg.source
    table.insert(self.threads[name], { id = id, mode = string.match(source, "%w+") })
    if Config.Debug.Log.Threads then
      Log:Info("starting thread ", line, source, string.match(source, "%w+"))
    end
    xpcall(cb, function(...)
      return Log:Info("Error", ..., debug.traceback("Sl", 2))
    end)
    while self.threads[name] do
      if time then
        Wait(time)
      end
      cb()
    end
  end)

  -- Citizen.CreateThread(cb)
end

function Thread:Create(name, cb)
  local dbg = debug.getinfo(2, "Sl")
  if not cb then
    cb = name
    name = math.random(1, 9999)
  end

  self.threads[name] = {}
  -- Citizen.CreateThread(cb)
  Citizen.CreateThread(function(id)
    local line = dbg.currentline
    local source = dbg.source
    table.insert(self.threads[name], { id = id, mode = string.match(source, "%w+") })
    if Config.Debug.Log.Threads then
      Log:Info("starting thread ", line, source, string.match(source, "%w+"))
    end
    xpcall(cb, function(...)
      Log:Info("Error", ..., debug.traceback(2, "Sl"))
    end)
  end)

  -- Citizen.CreateThread(cb)
end

function Thread:Remove(name)
  for k, v in pairs(self.threads[name]) do
    TerminateThread(v.id)
  end
  self.threads[name] = nil
end
