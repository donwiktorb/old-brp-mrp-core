function ChooseChar(userData)
  User:Teleport({
    coords = Config.Default.Spawn.Coords,
    heading = 327.7,
  })
  FreezeEntityPosition(PlayerPedId(), true)
  User:CharSelector(userData.chars, DWB.PlayerData.isDonate and 2 or 4, function(data2)
    local extra = {}
    User:CreateChar(extra, function(newData)
      print(json.encode(newData))
      FreezeEntityPosition(PlayerPedId(), false)
      print(json.encode(data))
      Event:TriggerNet("dwb:lobby:char:new", newData, data)
      User:OpenSkinCreator()
      Skinchanger:LoadDefault(newData["sex"].value)
    end, function()
      ChooseChar(userData)
    end)
  end, function(data4)
    FreezeEntityPosition(PlayerPedId(), false)
    Event:TriggerNet("dwb:lobby:char:choose", data4.current.value)
  end, "militaryrp")
end

Event:Register("dwb:lobby:select:char", function(userData)
  ChooseChar(userData)
end, true)

User:OnLoadedChar(function(data, isNew)
  if isNew then
    return
  end
  if DWB.PlayerData.char and DWB.PlayerData.char.position then
    User:Teleport({ coords = DWB.PlayerData.char.position, heading = 44.4 })
  end
  if DWB.PlayerData.char.skin then
    Skinchanger:Apply(DWB.PlayerData.char.skin)
  end
end)

User:OnUnloadedChar(function()
  User:Teleport({ coords = Config.Default.Spawn.Coords, heading = 327.7 })
end)
