Thread:Create(function()
  Interact.Markers:Load(Config.Zones)

  for k, v in pairs(GetAllPeds()) do
    if Entity(v).state.isOwned then
      DeleteEntity(v)
    end
  end
  Interact.Cursor:Load(Config.Cursor.Entities)
end)

User:OnLoaded(function(u)
  Event:TriggerNet(
    "dwb:interact:load",
    u.source,
    Interact.Markers.markers["shared"],
    Interact.Cursor.entities["shared"],
    {},
    {
      unloadLast = true,
    }
  )
end)

User:OnEvent("mode:joined", function(u)
  Event:TriggerNet(
    "dwb:interact:load",
    u.source,
    Interact.Markers.markers[u.data.mode],
    Interact.Cursor.entities[u.data.mode],
    {},
    {
      unloadLast = true,
    }
  )
end)

User:OnEvent("mode:left", function(u)
  Event:TriggerNet(
    "dwb:interact:load",
    u.source,
    Interact.Markers.markers["shared"],
    Interact.Cursor.entities["shared"],
    {},
    {
      unloadLast = true,
    }
  )
end)
