Thread:Create(function()
  for k, v in pairs(Config.UnloadIpls) do
    Wait(0)
    if IsIplActive(v) then
      Log:Info("Unloading interior", v)
      Interior:Unload(v)
    end
  end
  Log:Info("Unloaded all interiors")
end)
local lobbies = {}
Event:Register("dwb:mode:refresh", function(lobbies4)
  lobbies = lobbies4
end, true)

Event:Register("dwb:lobby:rejoin", function(lobby)
  UI:CloseAll()
  PluginLoader:Unload(lobby.data.scripts)
  User:Teleport(Config.Default.Spawn)
  Marker:Active("lobby")
  for k, v in pairs(lobby.data.ipls or {}) do
    Wait(0)
    if IsIplActive(v) then
      Log:Info("Unloading interior", v)
      Interior:Unload(v)
    end
  end
  Log:Info("Unloading interiors done")
end, true)
Event:Register("dwb:lobby:load", function(lobs)
  while not IsIplActive("ad_milo") do
    Wait(0)
  end

  User:Teleport(Config.Default.Spawn)
  lobbies = lobs
  for k, v in pairs(lobbies or {}) do
    v.pos = vec3(v.pos.x, v.pos.y, v.pos.z + 0.5)
  end

  Marker:Add("lobby", {
    marker = {
      scale = vec3(3.5, 3.5, 2.0),
      type = 23,
    },
    data = {},
    settings = {
      drawDist = 34.0,
      drawMarker = false,
    },
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby dołączyć do trybu",
    },
    functions = {
      onClickCb = function(zone, posData)
        local lobby = lobbies[posData.index]
        if lobby.data.enabled then
          inLobby = false
          Marker:Deactive("lobby")
          if lobby.data.ipls or lobby.data.map then
            if type(lobby.data.ipls) == "table" then
              for k, v in pairs(lobby.data.ipls) do
                Wait(0)
                if not IsIplActive(v) then
                  Log:Info("Loading interior", v)
                  Interior:Load(v)
                end
              end
            else
              if not IsIplActive(lobby.data.map) then
                Interior:Load(lobby.data.map)
              end
            end
          end
          if lobby.data.event then
            Event:Trigger(lobby.data.event)
          else
            User:Teleport(lobby.data.spawns[1])
            Event:TriggerNet("dwb:mode:join", lobby)
            print("STARTED JOIN MODE")
          end
        end
      end,
      onDrawDistEnter = function(zone, posData) end,

      onCloseDist = function(zone, posData)
        local lobby = lobbies[posData.index]
        if not lobby then
          return print(json.encode(posData))
        end
        local color = {
          r = 255,
          g = 255,
          b = 255,
          a = 255,
        }
        if lobby.data.enabled == false then
          lobby.data.text = "soon"
          color.g = 55
          color.b = 55
          color.a = 55
        end
        if lobby.data.color then
          color = lobby.data.color
        end
        local offset = lobby.data.textOffset or 1.5
        Text:Draw3D(
          vec3(posData.pos.x, posData.pos.y, posData.pos.z + offset),
          lobby.data.name,
          { font = 7, size = 4, r = color.r, g = color.g, b = color.b }
        )

        Text:Draw3D(
          vec3(posData.pos.x, posData.pos.y, posData.pos.z + offset - 0.5),
          lobby.data.text or TR("players", lobby.data.players),
          { font = 7, size = 3 }
        )

        for i = 1, #(lobby.data.motds or {}) do
          Text:Draw3D(
            vec3(posData.pos.x, posData.pos.y, posData.pos.z + (offset - 1) / i),
            lobby.data.motds[i],
            { font = 7, size = 3 }
          )
        end
      end,

      onDrawDistExit = function(zone, posData)
        print("x d")
      end,

      onEnterCb = function(zone, posData)
        print(posData.data.name)
      end,

      onExitCb = function(zone, posData)
        print(posData.data.name)
      end,
    },
    coords = lobbies,
  })
end, true)

Event:Register("dwb:mode:joined4", function(mode)
  Thread:Create(function()
    print("JOINED MODE")
    local data = mode.data
    if data.scripts then
      PluginLoader:StartScripts(data.scripts)
    end
  end)
end, true)
