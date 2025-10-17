-- -- local function InitDefaultModel(cb)
-- --     local playerPed = PlayerPedId()
-- -- 	local characterModel = GetHashKey('mp_m_freemode_01')

-- -- 	RequestModel(characterModel)

-- --     while not HasModelLoaded(characterModel) do
-- --         RequestModel(characterModel)
-- --         Citizen.Wait(1000)
-- --     end

-- --     if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
-- --         SetPlayerModel(PlayerId(), characterModel)
-- --         SetPedDefaultComponentVariation(playerPed)
-- --     end

-- --     SetModelAsNoLongerNeeded(characterModel)

-- --     if cb ~= nil then
-- --         cb()
-- --     end
-- -- end

-- -- Event:Register('dwb:player:loaded', function(xPlayer)
-- --     Log:Info("[Player Loaded]", "Player loaded!" )

-- -- 	DWB.PlayerLoaded = true

-- --     for k,v in pairs(xPlayer) do
-- --         DWB.PlayerData[k] = v
-- --     end

-- --     LocalPlayer.state.data = DWB.PlayerData

-- --     if not LocalPlayer.state.spawned then
-- --         while not IsIplActive('ad_milo') do
-- --             Wait(0)
-- --         end
-- --         Skinchanger:LoadDefault('m', function(pos)
-- --             SpawnPlayer(Config.DefaultSpawn or pos, function()
-- --                 LocalPlayer.state.spawned = true
-- --                 DWB.PlayerData.Spawned = true
-- --                 ShutdownLoadingScreenNui()
-- --                 ShutdownLoadingScreen()
-- --                 DoScreenFadeIn(500)
-- --             end)
-- --         end, xPlayer.position)
-- --         -- -- InitDefaultModel(function()
-- --         -- -- end)
-- --     else
-- --         if Config.Mode == 'rp' then
-- --             Event:Trigger('dwb:skin:check', function()
-- --                 local ped = PlayerPedId()
-- --                 SetEntityCoords(ped, vector3(405.446442, -961.942810, -99.004089))
-- --                 SetEntityHeading(ped, 0)
-- --                 Event:TriggerNet('dwb:spawn:start')
-- --             end, function()
-- --                 Event:Trigger('dwb:spawn:intro:start')
-- --             end, function()
-- --                 Event:Trigger('dwb:spawn:intro:start')
-- --             end)
-- --         else
-- --             Event:Trigger('dwb:player:state:spawned')
-- --         end
-- --         -- SpawnPlayer(xPlayer.position)
-- --         DWB.PlayerData.Spawned = true
-- --     end
-- --     passiveMode()
-- --     Log:Info("[Player Loaded]", "Player loaded!" )
-- -- end, true)

-- -- Event:Register('dwb:player:update', function(data)
-- --     while not DWB.PlayerLoaded do
-- --         Wait(0)
-- --     end
-- --     for k,v in pairs(data) do
-- --         DWB.PlayerData[k] = v
-- --     end
-- -- end, true)

-- -- Event:Register('dwb:player:update:char', function(data)
-- --     while not DWB.PlayerData.char do
-- --         Wait(0)
-- --     end
-- --     for k,v in pairs(data) do
-- --         DWB.PlayerData.char[k] = v
-- --     end
-- -- end, true)

-- -- Event:Register('dwb:player:died', function(data)
-- --     DWB.PlayerData.isDead = true
-- -- end, true)

-- Event:Register('dwb:player:state:spawned', function()
--     DWB.PlayerData.Spawned = true
-- end)

-- Event:Register('dwb:player:sync:data', function(name, data)
--     for k,v in pairs(User.SyncDataCbs) do
--         if v.name == name then
--             v.cb(data)
--         end
--     end
-- end, true)

Event:Register("dwb:player:sync:char", function(data, key)
  while not DWB.PlayerData.char do
    Wait(0)
  end

  if key then
    DWB.PlayerData.char[key] = data
  else
    DWB.PlayerData.char = data
  end
  User:SyncCharData(nil, key, data)
end, true)

Event:Register("dwb:player:sync:data", function(data, key)
  if data and type(data) == "table" then
    data.char = nil
  end
  if key then
    DWB.PlayerData[key] = data
  else
    for k, v in pairs(data) do
      Wait(0)
      DWB.PlayerData[k] = v
    end
  end
end, true)

Event:Register("dwb:player:loaded", function(xPlayer, ...)
  for k, v in pairs(xPlayer) do
    DWB.PlayerData[k] = v
  end
  DWB.PlayerData.Loaded = true
  DWB.PlayerLoaded = true
  while not Skinchanger.LoadDefault do
    Wait(0)
  end

  Skinchanger:LoadDefault("m", function(a)
    SpawnPlayer(Config.Default.Spawn.coords, function()
      LocalPlayer.state.spawned = true
      DWB.PlayerData.Spawned = true
      ShutdownLoadingScreenNui()
      ShutdownLoadingScreen()
      DoScreenFadeIn(500)
    end)
  end, "hello")
end, true)

Event:Register("dwb:player:char:loaded", function(char, ...)
  DWB.PlayerData.char = char
  DWB.PlayerData.CharLoaded = true
  User:LoadedChar(nil, ...)
end, true)

Event:Register("dwb:player:char:unloaded", function()
  User:UnloadedChar(function()
    DWB.PlayerData.char = nil
    DWB.PlayerData.CharLoaded = false
    Skinchanger:LoadDefault("m")
  end)
end, true)

Event:Register("dwb:player:respawn", function(coords, heading)
  User:Respawn(coords, heading)
end, true)
