local desc = {}

function checkDistance(source, dist, cb)
  local ped = GetPlayerPed(source)
  for k, v in pairs(DWB.Players) do
    local ped2 = GetPlayerPed(k)
    local coords = GetEntityCoords(ped)
    local coords2 = GetEntityCoords(ped2)
    local distance = #(coords - coords2)
    if distance <= dist then
      cb(source, k, v)
    end
  end
end

function checkTeam(source, cb)
  local xPlayer = DWB.Players[source]
  local team = xPlayer:GetChar("team")
  for k, v in pairs(DWB.Players) do
    if v:GetChar("team") == team then
      cb(source, k, v)
    end
  end
end

function checkRank(source, cb)
  local xPlayer = DWB.Players[source]
  for k, v in pairs(DWB.Players) do
    if v:GetData("group") == "superadmin" or v:GetData("group") == "admin" then
      cb(source, k, v)
    end
  end
end

Event:Register("dwb:chat:sendMessage", function(message)
  local zPlayer = DWB.Players[source]
  checkDistance(source, 30, function(s, id, xPlayer)
    if zPlayer:GetData("vip") then
      Event:TriggerNet("dwb:chat:addMessage", id, {
        template = '<i class="fas fa-user"style="font-size:13px;color:lightgray"></i>&ensp;<font color="lightgray">[LOCAL CHAT] <font color="purple">[VIP]</font> {0}:</font>&ensp;<font color="white">{1}</font>',
        args = { GetPlayerName(source), message },
      })
    elseif zPlayer:GetData("svip") then
      Event:TriggerNet("dwb:chat:addMessage", id, {
        template = '<i class="fas fa-user"style="font-size:13px;color:lightgray"></i>&ensp;<font color="lightgray">[LOCAL CHAT] <font color="purple">[VIP]</font> {0}:</font>&ensp;<font color="white">{1}</font>',
        args = { GetPlayerName(source), message },
      })
    else
      Event:TriggerNet("dwb:chat:addMessage", id, {
        template = '<i class="fas fa-user"style="font-size:13px;color:lightgray"></i>&ensp;<font color="lightgray">[LOCAL CHAT] {0}:</font>&ensp;<font color="white">{1}</font>',
        args = { GetPlayerName(source), message },
      })
    end
  end)
end, true)

Command:Register("advert", { "Advert" }, function(xPlayer, args)
  local message = table.concat(args, " ")
  checkTeam(xPlayer.source, function(s, k, v)
    local firstname, lastname = xPlayer:GetChar("firstname"), xPlayer:GetChar("lastname")
    Event:TriggerNet("dwb:chat:addMessage", k, {
      template = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[ADVERT]  <font color="black"> {0}-{1}: {2}</font></font>&ensp;</div>',
      args = { firstname, lastname, message },
    })
  end)
end)

Command:Register("report", { "Report" }, function(xPlayer, args)
  local message = table.concat(args, " ")
  checkRank(xPlayer.source, function(s, k, v)
    if xPlayer:GetData("vip") then
      Event:TriggerNet("dwb:chat:addMessage", k, {
        template = '<div style="color:white;">[REPORT] <font color="purple">[VIP]</font> {0} | {1}: {2}</div>',
        args = { GetPlayerName(xPlayer.source), xPlayer.source, table.concat(args, " ") },
      })
    else
      Event:TriggerNet("dwb:chat:addMessage", k, {
        template = '<div style="color:white;">[REPORT] {0} | {1}: {2}</div>',
        args = { GetPlayerName(xPlayer.source), xPlayer.source, table.concat(args, " ") },
      })
    end
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(4000)
    for k, v in pairs(desc) do
      local ped = GetPlayerPed(k)
      if ped then
        v.coords = GetEntityCoords(ped)
      end
    end

    TriggerClientEvent("dwb_rpchat:descUpdated", -1, desc)
  end
end)

Command:Register("opis", { "opis" }, function(xPlayer, args)
  local source = xPlayer.source
  desc[source] = {
    value = table.concat(args, " "),
    coords = GetEntityCoords(GetPlayerPed(source)),
  }
  TriggerClientEvent("dwb_rpchat:descUpdated", -1, desc)
end)

Command:Register("copis", { "Clear opis" }, function(xPlayer)
  desc[xPlayer.source] = nil
  TriggerClientEvent("dwb_rpchat:descUpdated", -1, desc)
end)

Command:Register("me", { "me" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  checkDistance(xPlayer.source, 30, function(s, id, xPlayer)
    Event:TriggerNet("dwb:rpchat:me", id, s, message)
  end)
end)

Command:Register("do", { "do" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  checkDistance(xPlayer.source, 30, function(s, id, xPlayer)
    Event:TriggerNet("dwb:rpchat:do", id, s, message)
  end)
end)

