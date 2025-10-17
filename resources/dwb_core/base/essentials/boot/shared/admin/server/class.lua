Admin = class()
Admin.CachePlayers = {}

function Admin:GetPermsFormat(str, t)
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

function Admin:IsAllowed(xPlayer, perm)
  if xPlayer and xPlayer.data.group then
    local perms = Config.Admin.Permissions[xPlayer.data.group]
    if perms then
      return self:GetPermsFormat(perm, perms)
    end
  end
end

function Admin:GetPlayerFromCache(src)
  for k, v in pairs(self.CachePlayers) do
    if v.source == src then
      return v
    end
  end
end

function Admin:GetCachedPlayers()
  local players = {}
  for k, v in pairs(self.CachePlayers) do
    table.insert(players, {
      name = v.name,
      source = v.source,
    })
  end
  return players
end

function Admin:GetBannedPlayers()
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
  return players
end

function Admin:ConvertTime(time)
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

function Admin:Ban(src, message, time, banner)
  local xPlayer = DWB.Players[src]
  if not xPlayer then
    xPlayer = self:GetPlayerFromCache(src)
  end

  local time = self:ConvertTime(time)

  local insertId = Mysql.Sync:Insert("INSERT INTO bans SET ?", {
    userId = xPlayer.id or src,
    username = xPlayer.name,
    tokens = json.encode(xPlayer.identifiers),
    reason = message,
    banner = banner or "Konsola",
    active = 1,
    till = time,
  })

  local firstDate = os.date("%X %x", tonumber(time))
  local firstDate2 = os.date("%X %x", tonumber(os.time()))
  local banStr = TR("admin.ban", message, banner or "Konsola", firstDate, firstDate2, insertId)

  Discord:Logs("Ban", banStr)

  DropPlayer(src, banStr)
end

function Admin:IsBanned(rawIdentifiers)
  local result = Mysql.Sync:fetchAll(
    "SELECT id, userId, reason, banner, till, time FROM bans WHERE active = 1 AND JSON_OVERLAPS(tokens, ?)",
    {
      rawIdentifiers,
    }
  )

  if result and result[1] then
    result = result[1]
    local currentTime = os.time()
    if currentTime > result.till then
      Mysql.Async:Execute("UPDATE bans SET active = 0 WHERE id = ?", {
        result.id,
      })
    else
      return result[1]
    end
  end
end

function Admin:UnbanPlayer(id)
  Mysql.Async:Execute("UPDATE bans SET active = 0 WHERE id = ?", {
    id,
  })
end

