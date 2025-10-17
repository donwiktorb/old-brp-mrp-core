local IsOpen = false

local uptimeHour, uptimeMinute = 0, 0
local playMinute, playHour = 0, 0
local headIds = {}

Thread:Create(function()
  print("x d")
  Citizen.Wait(8000)
  for k, v in pairs(Config.Scoreboard.Fractions) do
    UI:Action("Scoreboard", "scoreboard", "fractions", {
      action = "add",
      name = v.name,
      label = v.label,
      count = v.count,
      icon = v.icon,
    })
  end

  for k, v in pairs(Config.Scoreboard.Stats) do
    UI:Action("Scoreboard", "scoreboard", "stats", {
      action = "add",
      name = v.name,
      label = v.label,
      value = v.value,
    })
  end

  Event:TriggerCb("dwb:scoreboard:getPlayers", Update)
end)

Event:Register("dwb:tick:minute", function()
  uptimeMinute = uptimeMinute + 1

  if uptimeMinute == 60 then
    uptimeMinute = 0
    uptimeHour = uptimeHour + 1
  end
end, true)

Event:Register("dwb:scoreboard:updatePlayers", function(players)
  Update(players)
end, true)

function Update(players)
  local newPlayers = {}
  local newJobs = {}
  local keys = {}

  for k in pairs(players) do
    table.insert(keys, k)
  end

  table.sort(keys)

  for _, k in ipairs(keys) do
    local player = players[k]
    table.insert(newPlayers, {
      id = player.id,
      name = player.name,
      ping = player.ping,
    })

    if player.job then
      if not newJobs[player.job] then
        newJobs[player.job] = 1
      else
        newJobs[player.job] = newJobs[player.job] + 1
      end
    end

    -- for k,v in pairs(player.jobs) do
    --     if not newJobs[v.name] then
    --         newJobs[v.name] = 0
    --     else
    --         newJobs[v.name] = newJobs[v.name] + 1
    --     end
    -- end
  end

  UI:Action("Scoreboard", "scoreboard", "players", {
    action = "set",
    players = newPlayers,
  })

  UI:Action("Scoreboard", "scoreboard", "stats", {
    action = "update",
    name = "players",
    value = #keys,
  })

  for k, v in pairs(Config.Scoreboard.Fractions) do
    UI:Action("Scoreboard", "scoreboard", "fractions", {
      action = "update",
      name = v.name,
      count = 0,
    })
  end

  local fractions = {}

  for k, v in pairs(newJobs) do
    UI:Action("Scoreboard", "scoreboard", "fractions", {
      action = "update",
      name = string.lower(k),
      count = v,
    })
  end

  -- -- UI:Action('Scoreboard', 'scoreboard', 'players', {
  -- --     action = 'set',
  -- --     players = newPlayers
  -- -- })
end

Thread:Create(function()
  while true do
    Citizen.Wait(60 * 1000)
    playMinute = playMinute + 1

    if playMinute == 60 then
      playMinute = 0
      playHour = playHour + 1
    end
  end
end)

Key:onPressed("UP", "Góra w liście graczy (STRZAŁKA W GÓRĘ)", function()
  if IsOpen then
    UI:Action("Scoreboard", "scoreboard", "scroll", {
      action = "up",
    })
  end
end)

Key:onPressed("DOWN", "Dół w liście graczy (STRZAŁKA W DÓŁ)", function()
  if IsOpen then
    UI:Action("Scoreboard", "scoreboard", "scroll", {
      action = "down",
    })
  end
end)

Key:onJustPressed("Z", "Lista graczy (otwarcie)", function()
  Event:TriggerNet("dwb:scoreboard:updatePlayers")

  UI:Open("Scoreboard", {
    name = "scoreboard",
    forceOpen = true,
    forceClose = true,
  }, true)

  UI:Action("Scoreboard", "scoreboard", "stats", {
    action = "update",
    name = "playtime",
    value = string.format("%02dh %02dm", playHour, playMinute),
  })

  uptimeHour = tonumber(GetConvar("uptimeHour", "0"))
  uptimeMinute = tonumber(GetConvar("uptimeMinute", "0"))

  UI:Action("Scoreboard", "scoreboard", "stats", {
    action = "update",
    name = "svuptime",
    value = string.format("%02dh %02dm", uptimeHour, uptimeMinute),
  })

  IsOpen = true

  local players = GetActivePlayers()
  local playerPed = PlayerPedId()

  for _, player in pairs(players) do
    local ped = GetPlayerPed(player)
    local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(ped))
    if ped ~= nil and (dist < 15) and HasEntityClearLosToEntity(playerPed, ped, 17) then
      if GetPlayerServerId(player) ~= nil then
        local srvId = GetPlayerServerId(player)
        -- local data = Player(srvId).state.data and Player(srvId).state.data.char or {
        --     data = {
        --         firstname = '',
        --         lastname = ""
        --     }
        -- }
        -- local job = (Player(srvId).state.data and Player(srvId).state.data.char.jobs) or {
        --     ['military'] = {
        --         grade_label= ''
        --     }
        -- }
        -- -- print(data.char.firstname)
        headIds[player] = CreateFakeMpGamerTag(
          ped,
          -- string.format("%s %s %s %s", srvId, data.data.firstname, data.data.lastname, job['military'] and '| '..job['military'].grade_label or '')
          -- string.format("%s %s %s %s", srvId, data.data.firstname, data.data.lastname, job['military'] and '| '..job['military'].grade_label or '')
          srvId,
          false,
          false,
          "BRP",
          5
        )
        -- headIds[player] = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, tostring(GetPlayerServerId(player)), false, false, "", false )
        if NetworkIsPlayerTalking(player) then
          -- SetMpGamerTagColour(headIds[player], false, 200)
          SetMpGamerTagVisibility(headIds[player], 4, true)
        else
          -- SetMpGamerTagColour(headIds[player], false, 0)
          SetMpGamerTagVisibility(headIds[player], 4, false)
        end

        if Player(srvId).state.scoreboard then
          -- SetMpGamerTagColour(headIds[player], false, 200)
          SetMpGamerTagVisibility(headIds[player], 18, true)
        else
          -- SetMpGamerTagColour(headIds[player], false, 0)
          SetMpGamerTagVisibility(headIds[player], 18, false)
        end
        N_0x63bb75abedc1f6a0(headIds[player], false, true)
      end
    end
  end
end)

Key:onJustReleased("Z", "Lista graczy (zamknięcie)", function()
  local players = GetActivePlayers()

  UI:Close("Scoreboard", { forceClose = true, name = "scoreboard" })

  IsOpen = false
  Event:TriggerNet("dwb:scoreboard:close")
  for _, player in ipairs(players) do
    N_0x63bb75abedc1f6a0(headIds[player], false, false)
    RemoveMpGamerTag(headIds[player])
    headIds[player] = nil
  end
end)
