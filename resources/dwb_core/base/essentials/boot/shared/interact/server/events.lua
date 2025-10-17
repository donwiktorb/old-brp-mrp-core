Thread:Create(function()
  if true then
    return
  end
  while true do
    Wait(1000)
    time = (time or 0) + 5
    Interact.Markers:Edit("boskierp", { { "name", "liveText" }, { "flags", true }, { "coords" } }, {
      toChild = { { "text" } },
      childValue = {
        {
          { font = 7, label = time, size = 4, offset = 0.3, color = { r = 255, g = 255, b = 255 } },
        },
      },
    })
  end
end)

Event:Register("dwb:cursor:submit", function(source, xPlayer, action, entityId, data, entData)
  xPlayer:CustomEvent(action.name or data.name or "cursor", entityId, action, data, entData)
end, true)
Event:Register("dwb:marker:submit", function(source, xPlayer, zoneData, posData)
  xPlayer:CustomEvent(zoneData.type or posData.type or "marker", zoneData, posData)
end, true)

Event:Register("dwb:marker:submit:second", function(source, xPlayer, zoneData, posData)
  xPlayer:CustomEvent((zoneData.type or posData.type or "marker") .. "-g", zoneData, posData)
end, true)

Event:Register("dwb:marker:enter", function(source, xPlayer, zoneData, posData)
  xPlayer.zoneData = zoneData
  xPlayer.posData = posData
end, true)

Event:Register("dwb:marker:exit", function(source, xPlayer, zoneData, posData)
  xPlayer.zoneData = nil
  xPlayer.posData = nil
end, true)
