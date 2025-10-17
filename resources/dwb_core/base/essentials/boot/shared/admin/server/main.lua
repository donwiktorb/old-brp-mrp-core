local cachePlayers = {}

-- -- Thread:Create(function()
-- --     while true do
-- --         Wait(150 * 1000 * 2)
-- --         for k, v in pairs(DWB.Players) do

-- --         end
-- --     end
-- -- end)

Thread:Create(function()
  while true do
    Wait(60 * 1000)
    for k, v in pairs(cachePlayers) do
      local time = os.time()
      local d = time - v.time
      if d >= 2700 then
        table.remove(cachePlayers, k)
      end
    end
  end
end)

RegisterCommand("coord", function(source)
  local ped = GetPlayerPed(source)
  local coords = GetEntityCoords(ped)
  local heading = GetEntityHeading(ped)

  Discord:Logs("Coords", source, coords, heading)
end)

User:OnUnloaded(function(self)
  local rawIdentifiers = GetPlayerIdentifiers(self.source)

  for k, v in pairs(rawIdentifiers) do
    if string.sub(v, 1, string.len("ip:")) == "ip:" then
      table.remove(rawIdentifiers, k)
    end
  end
  table.insert(cachePlayers, {
    id = self.id,
    identifiers = rawIdentifiers,
    time = os.time(),
    name = self.name,
    source = self.source,
  })
end)

function getPerm(str, t)
  local keys = {}
  for key in string.gmatch(str, "([^%.]+)") do
    table.insert(keys, key)
  end
  local value = t
  for k, v in pairs(keys) do
    if value[v] then
      value = value[v]
    end
  end
  return value
end

function IsAllowed(xPlayer, perm)
  if xPlayer and xPlayer.data.group then
    local perms = Config.Admin.Permissions[xPlayer.data.group]
    if perms then
      return getPerm(perm, perms)
    end
  end
end

Event:Register("dwb:admin:ban:me", function(source, reason, time2, banner)
  local id = source
  local xPlayer2 = DWB.Players[id]
  local xPlayer4
  if not xPlayer2 then
    for k, v in pairs(cachePlayers) do
      if v.source == id then
        xPlayer4 = v
      end
    end
  end

  local time = time2
  time = convertTime(time)
  local message = reason

  local rawIdentifiers = xPlayer2 and GetPlayerIdentifiers(id) or xPlayer4.identifiers

  for k, v in pairs(rawIdentifiers) do
    if string.sub(v, 1, string.len("ip:")) == "ip:" then
      table.remove(rawIdentifiers, k)
    end
  end

  local insertId = Mysql.Sync:Insert("INSERT INTO bans SET ?", {
    userId = xPlayer2 and xPlayer2.id or (xPlayer4 and xPlayer4.id or 0),
    username = xPlayer2 and xPlayer2.name or (xPlayer4 and xPlayer4.name or ""),
    tokens = json.encode(rawIdentifiers),
    reason = message,
    banner = banner or "Konsola",
    active = 1,
    till = time,
  })

  local firstDate = os.date("%X %x", tonumber(time))
  local firstDate2 = os.date("%X %x", tonumber(os.time()))
  local banStr = TR("ban", message, banner or "Konsola", firstDate, firstDate2, insertId)
  Discord:Logs("Ban", banStr)

  DropPlayer(id, banStr)
end)

Event:Register("dwb:admin:ban:me", function(source, xPlayer, reason, time2)
  local id = source
  local xPlayer2 = DWB.Players[id]
  local xPlayer4
  if not xPlayer2 then
    for k, v in pairs(cachePlayers) do
      if v.source == id then
        xPlayer4 = v
      end
    end
  end

  local time = time2
  time = convertTime(time)
  local message = reason

  local rawIdentifiers = xPlayer2 and GetPlayerIdentifiers(id) or xPlayer4.identifiers

  for k, v in pairs(rawIdentifiers) do
    if string.sub(v, 1, string.len("ip:")) == "ip:" then
      table.remove(rawIdentifiers, k)
    end
  end

  local insertId = Mysql.Sync:Insert("INSERT INTO bans SET ?", {
    userId = xPlayer2 and xPlayer2.id or (xPlayer4 and xPlayer4.id or 0),
    username = xPlayer2 and xPlayer2.name or (xPlayer4 and xPlayer4.name or ""),
    tokens = json.encode(rawIdentifiers),
    reason = message,
    banner = "Konsola",
    active = 1,
    till = time,
  })

  local firstDate = os.date("%X %x", tonumber(time))
  local firstDate2 = os.date("%X %x", tonumber(os.time()))

  local banStr = TR("ban", message, "Konsola", firstDate, firstDate2, insertId)
  Discord:Logs("Ban", banStr)
  DropPlayer(id, banStr)
end, true)

Event:Register("dwb:player:connecting", function(source, name, kick, defferals)
  defferals.defer()
  Wait(0)
  local rawIdentifiers = GetPlayerIdentifiers(source)

  for k, v in pairs(rawIdentifiers) do
    if string.sub(v, 1, string.len("ip:")) == "ip:" then
      table.remove(rawIdentifiers, k)
    end
  end

  Wait(0)

  local result = Mysql.Sync:fetchAll(
    "SELECT id, userId, reason, banner, till, time FROM bans WHERE active = 1 AND JSON_OVERLAPS(tokens, ?)",
    {
      -- 'SELECT id, userId, reason, banner, till, time FROM bans WHERE active = 1 AND tokens ?| $1', {
      json.encode(rawIdentifiers),
    }
  )

  Wait(0)

  if result and result[1] then
    result = result[1]
    local currentTime = os.time()
    if currentTime > result.till then
      Mysql.Async:Execute("UPDATE bans SET active = 0 WHERE id = ?", {
        result.id,
      })
    else
      local firstDate = os.date("%X %x", tonumber(result.till))
      local firstDate2 = os.date("%X %x", tonumber(result.time))

      return defferals.done(
        TR("ban", result.reason, result.banner, firstDate, firstDate2, result.id)
      )
    end
  end
end)

Event:RegisterCb("dwb:admin:get:players", function(source, cb)
  local xPlayer = DWB.Players[source]
  if IsAllowed(xPlayer, "menu.players") then
    local players = {}
    for k, v in pairs(DWB.Players) do
      table.insert(players, {
        name = v.name,
        source = v.source,
      })
    end
    cb(players)
  end
end)

Event:Register("dwb:admin:unban:player", function(source, xPlayer, data)
  local xPlayer = DWB.Players[source]
  if IsAllowed(xPlayer, "menu.unban") then
    Mysql.Async:Execute("UPDATE bans SET active = ? WHERE id = ?", {
      data.current.value,
      data.current.id,
    })
  end
end, true)

Event:RegisterCb("dwb:admin:get:banned:players", function(source, cb)
  local xPlayer = DWB.Players[source]
  if IsAllowed(xPlayer, "menu.players") then
    local players = {}
    local result =
      Mysql.Sync:fetchAll("SELECT id, userId, username, reason, banner, till, time FROM bans", {})
    for k, v in pairs(result) do
      local firstDate = os.date("%X %x", tonumber(v.till))
      local firstDate2 = os.date("%X %x", tonumber(v.time))
      table.insert(players, {
        id = v.id,
        label = v.username
          .. " Od "
          .. v.banner
          .. " "
          .. v.reason
          .. " do "
          .. firstDate
          .. " od "
          .. firstDate2,
        type = "checkbox",
        value = not v.active and false or true,
      })
    end
    cb(players)
  end
end)

Event:RegisterCb("dwb:admin:get:cache:players", function(source, cb)
  local xPlayer = DWB.Players[source]
  if IsAllowed(xPlayer, "menu.players") then
    local players = {}
    for k, v in pairs(cachePlayers) do
      table.insert(players, {
        name = v.name,
        source = v.source,
      })
    end
    cb(players)
  end
end)

function getAction(cat, value)
  for k, v in pairs(Config.Admin.Actions[cat]) do
    if v.value == value then
      return v
    end
  end
end

Event:Register("dwb:admin:photo", function(source, xPlayer, eq, url)
  Discord:Logs("Screenshot", source, xPlayer.name, json.encode(xPlayer.identifiers), url)
  Event:TriggerNet(
    "dwb:chat:addMessage",
    eq,
    { template = '<img src="{0}" style="" class="w-full h-full" />', args = { url } }
  )
end, true)

Event:Register("dwb:admin:player:manage", function(source, xPlayer, action, player)
  local newAction = getAction("player", action.value)
  Discord:Logs(
    "Admin",
    source,
    xPlayer.name,
    json.encode(xPlayer.identifiers),
    newAction.value,
    player.source,
    GetPlayerName(player.source)
  )
  if newAction then
    if not newAction.requires or IsAllowed(xPlayer, newAction.requires) then
      if newAction.value == "spectate" then
        SetPlayerCullingRadius(source, 4444444.0)
        SetPlayerRoutingBucket(source, GetPlayerRoutingBucket(player.source))
        Event:TriggerNet("dwb:admin:spectate", source, player.source)
        Event:TriggerNet("dwb:admin:spectate:target", player.source, source)
      elseif newAction.value == "freeze" then
        Event:TriggerNet("dwb:admin:freeze", player.source)
      elseif newAction.value == "teleportto" then
        local ped = GetPlayerPed(player.source)
        local coords = GetEntityCoords(ped)
        local adminPed = GetPlayerPed(source)
        local adminPos = GetEntityCoords(adminPed)
        if not Player(source).state.tp then
          SetEntityCoords(adminPed, coords)
          Player(source).state.tp = adminPos
        else
          SetEntityCoords(adminPed, Player(source).state.tp)
          Player(source).state.tp = false
        end
      elseif newAction.value == "teleporttome" then
        local ped = GetPlayerPed(player.source)
        local coords = GetEntityCoords(ped)
        local adminPed = GetPlayerPed(source)
        local adminPos = GetEntityCoords(adminPed)
        if not Player(source).state.tpme then
          SetEntityCoords(ped, adminPos)
          Player(source).state.tpme = coords
        else
          SetEntityCoords(ped, Player(source).state.tpme)
          Player(source).state.tpme = false
        end
      elseif newAction.value == "check" then
        local elements = {}
        for k, v in pairs(DWB.Players[player.source].char.inventory) do
          table.insert(elements, {
            label = v.label .. " " .. v.count,
          })
        end
        Event:TriggerNet("dwb:admin:check", source, elements)
      elseif newAction.value == "photo" then
        Event:TriggerNet("dwb:admin:photo", player.source, source)
      end
    end
  end
end, true)

Event:Register("dwb:admin:spectate:stop", function(source, xPlayer, player)
  SetPlayerRoutingBucket(source, 0)
  SetPlayerCullingRadius(source, 0.0)
  Event:TriggerNet("dwb:admin:spectate:target", player, source)
end)

Command:Register("kick", { "id", "reason" }, function(xPlayer, args)
  local id = tonumber(args[1])
  table.remove(args, 1)
  local message = table.concat(args, " ")
  DropPlayer(id, TR("kick", xPlayer.name, message))
end, { "superadmin", "admin" })

function convertTime(time)
  local expires
  if string.find(time, "d") then
    expires = tonumber((string.gsub(time, "d", ""))) * 24 * 60 * 60
  elseif string.find(time, "h") then
    expires = tonumber((string.gsub(time, "h", ""))) * 3600
  elseif string.find(time, "m") then
    expires = tonumber((string.gsub(time, "m", ""))) * 60
  end
  if expires and expires < os.time() then
    expires = os.time() + expires
  elseif not expires then
    expires = 10444633200
  end
  return expires
end

Command:Register("ban", { "id", "time", "reason" }, function(xPlayer, args)
  local id = tonumber(args[1])
  local xPlayer2 = DWB.Players[id]
  local xPlayer4
  if not xPlayer2 then
    for k, v in pairs(cachePlayers) do
      if v.source == id then
        xPlayer4 = v
      end
    end
  end

  table.remove(args, 1)
  local time = args[1]
  table.remove(args, 1)
  time = convertTime(time)
  local message = table.concat(args, " ")

  local rawIdentifiers = xPlayer2 and GetPlayerIdentifiers(id) or xPlayer4.identifiers

  for k, v in pairs(rawIdentifiers) do
    if string.sub(v, 1, string.len("ip:")) == "ip:" then
      table.remove(rawIdentifiers, k)
    end
  end

  local insertId = Mysql.Sync:Insert("INSERT INTO bans SET ?", {
    userId = xPlayer2 and xPlayer2.id or (xPlayer4 and xPlayer4.id or 0),
    username = xPlayer2 and xPlayer2.name or (xPlayer4 and xPlayer4.name or ""),
    tokens = json.encode(rawIdentifiers),
    reason = message,
    banner = xPlayer and xPlayer.name or "Konsola",
    active = 1,
    till = time,
  })

  local firstDate = os.date("%X %x", tonumber(time))
  local firstDate2 = os.date("%X %x", tonumber(os.time()))

  local banStr =
    TR("ban", message, xPlayer and xPlayer.name or "Konsola", firstDate, firstDate2, insertId)
  DropPlayer(id, banStr)

  Discord:Logs("Ban", banStr)
end, { "superadmin", "admin" })

Command:Register("unban", { "id", "time", "reason" }, function(xPlayer, args)
  local id = tonumber(args[1])

  local insertId = Mysql.Sync:Execute("UPDATE bans SET active = 0 WHERE id = ?", {
    id,
  })
end, { "superadmin", "admin" })
