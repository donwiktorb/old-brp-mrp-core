local reasonData =
  json.decode(LoadResourceFile(GetCurrentResourceName(), "base/data/server/config/reasons.json"))

User:OnKilledByPlayer(function(xPlayer, data)
  local zPlayer = DWB.Players[data.killerServerId]
  local reason = data.deathCause
  if reasonData[reason] then
    reason = reasonData[reason]
  end
  Discord:Logs(
    "Killed",
    source,
    xPlayer.name,
    json.encode(xPlayer.identifiers),
    zPlayer.source,
    zPlayer.name,
    json.encode(zPlayer.identifiers),
    reason
  )
end)

User:OnKilled(function(xPlayer, data)
  local reason = data.deathCause
  if reasonData[reason] then
    reason = reasonData[reason]
  end
  Discord:Logs(
    "Killed",
    source,
    xPlayer.name,
    json.encode(xPlayer.identifiers),
    xPlayer.source,
    xPlayer.name,
    json.encode(xPlayer.identifiers),
    reason
  )
end)

Event:Register("dwb:chat:sendMessage", function(source, xPlayer, message)
  local str = string.sub(message, 1, 2)
  Discord:Logs("Chat", source, xPlayer.name, json.encode(xPlayer.identifiers), message)
end, true)

Event:Register("dwb:chat:sendCommand", function(source, xPlayer, message)
  Discord:Logs("Command", source, xPlayer.name, json.encode(xPlayer.identifiers), message)
end, true)

Event:Register("dwb:player:joining", function(source, oldsource)
  Discord:Logs("Joining", source, GetPlayerName(source), oldsource)
end)

Event:Register("dwb:player:dropped", function(source, xPlayer, reason)
  Discord:Logs("Left", xPlayer.source, xPlayer.name, json.encode(xPlayer.identifiers), reason)
end)

Event:Register("dwb:logs:translate:error", function(source, xPlayer, error, name, ...)
  Log:Error("Translation error", error, name, ...)
end, true)
