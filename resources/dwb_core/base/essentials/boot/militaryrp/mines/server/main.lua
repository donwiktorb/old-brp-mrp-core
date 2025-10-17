local prop = "ar_prop_ar_tube_2x_crn"

Item:RegisterUsable("mine", function(source)
  local xPlayer = DWB.Players[source]
  xPlayer:RemoveInventoryItem("mine", 1)
  Event:TriggerNet("dwb:mine:use", source)
end)

Event:Register("dwb:mine:spawn", function(forward)
  local xPlayer = DWB.Players[source]
  local coords = xPlayer:GetPedCoords()
  local coords = coords - vector3(5, 5, 2.5)
  local coords = (coords + forward * 1.0 + 1)
  Object:Create(prop, coords, function(obj)
    Event:TriggerNet("dwb:mine:spawn", -1, obj, id, coords)
  end)
end, true)

Event:Register("dwb:mine:remove", function(obj)
  DeleteEntity(obj)
  Event:TriggerNet("dwb:mine:remove", -1, obj)
end, true)
