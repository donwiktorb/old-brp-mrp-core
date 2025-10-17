--DWB.ENV = _G

PluginLoader = class({ cachedScripts = {} })

function PluginLoader:HandleError(err, res, file, ...)
  Log:Error("Error loading resource", res, "in file", file, err, ...)
end
function PluginLoader:Decode(encoded)
  local decoded = encoded:gsub("\\x(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
  return decoded
end

local loaded = false

function PluginLoader:LoadClientScripts(scripts)
  while not DWB.PlayerLoaded do
    Wait(0)
    Log:Info("waiting for player to load scripts")
  end
  for k, v in pairs(scripts) do
    if Config.Debug.Log.Resources then
      Log:Info("starting", v.name, v.dir)
    end

    --DWB.ENV[v.name] = _G
    table.insert(self.cachedScripts, {
      name = v.name,
      type = v.type,
      code = load(
        self:Decode(v.code),
        string.format("%s/%s", v.dir, v.name),
        "bt" --,
        --DWB.ENV[v.name]
      ),
      dir = v.dir,
    })
    -- -- -- -- xpcall(load(self:Decode(v.code),string.format('%s/%s', v.dir, v.name), nil, _G ), function(error)
    -- -- -- --     self:HandleError(debug.traceback(error, 1), v.dir, v.name, error, debug.traceback(error, 2))
    -- -- -- -- end)
  end
end

function PluginLoader:Unload(type)
  Key:RemoveBy("mode", type)
  Event:RemoveBy("mode", type)
  Thread:RemoveBy("mode", type)
end
function PluginLoader:StartScripts(type)
  print("REQUEST START")
  for k, v in pairs(self.cachedScripts) do
    if v.type == type then
      --print("Starting", v.name, v.dir, type)
      xpcall(v.code, function(error)
        self:HandleError(debug.traceback(error, 1), v.dir, v.name, error, debug.traceback(error, 2))
      end)
    end
  end
end

Event:Register("dwb:scripts:load", function(scripts)
  print("REQUEST START EVENT")
  PluginLoader:LoadClientScripts(scripts)
  PluginLoader:StartScripts("shared")
end, true)
