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

function checkRank(source, cb)
  local xPlayer = DWB.Players[source]
  for k, v in pairs(DWB.Players) do
    if v.data.group and k ~= source then
      cb(source, k, v)
    end
  end
end

Event:Register("dwb:chat:sendMessage", function(source, xPlayer, message)
  local xPlayer = xPlayer
  checkDistance(source, 30, function(s, id, xPlayer2)
    if not xPlayer.prefix then
      Event:TriggerNet("dwb:chat:addMessage", id, {
        template = '<i class="fas fa-user"style="font-size:13px;color:lightgray"></i>&ensp;<font color="lightgray">[LOCAL CHAT] {0}:</font>&ensp;<font color="white">{1}</font>',
        args = { xPlayer.name, message },
      })
    else
      Event:TriggerNet("dwb:chat:addMessage", id, {
        template = '<i class="fas fa-user"style="font-size:13px;color:lightgray"></i>&ensp;<font color="lightgray"><font class="animate-rainbowtxt text-green-500 animate-rainbow">{0}</font> [LOCAL CHAT] {1}:</font>&ensp;<font color="white">{2}</font>',
        args = { xPlayer.prefix, xPlayer.name, message },
      })
    end
  end)
end, true)

Command:Register("clearinv", { "clearinv" }, function(xPlayer, args)
  local zPlayer = DWB.Players[args[1]]
  for k, v in pairs(zPlayer.inventory) do
    zPlayer:RemoveInventoryItem(v.slot, v.count)
  end
end, {})

Command:Register("report", { "Report" }, function(xPlayer, args)
  local xPlayer = xPlayer
  local message = table.concat(args, " ")
  if not xPlayer.group then
    if not xPlayer.prefix then
      Event:TriggerNet("dwb:chat:addMessage", xPlayer.source, {
        template = '<div style="color:white;"><span style="color:pink">[REPORT]</span> {0} | {1}: {2}</div>',
        args = { xPlayer.name, xPlayer.source, table.concat(args, " ") },
      })
    else
      Event:TriggerNet("dwb:chat:addMessage", xPlayer.source, {
        template = '<div style="color:white;"><font class="animate-rainbowtxt text-green-500 animate-rainbow">{0}</font><span style="color:pink"> [REPORT]</span> {1} | {2}: {3}</div>',
        args = { xPlayer.prefix, xPlayer.name, xPlayer.source, table.concat(args, " ") },
      })
    end
  end
  checkRank(xPlayer.source, function(s, k, v)
    if not xPlayer.prefix then
      Event:TriggerNet("dwb:chat:addMessage", k, {
        template = '<div style="color:white;"><span style="color:pink">[REPORT]</span> {0} | {1}: {2}</div>',
        args = { xPlayer.name, xPlayer.source, table.concat(args, " ") },
      })
    else
      Event:TriggerNet("dwb:chat:addMessage", k, {
        template = '<div style="color:white;"><font class="animate-rainbowtxt text-green-500 animate-rainbow">{0}</font><span style="color:pink"> [REPORT]</span> {1} | {2}: {3}</div>',
        args = { xPlayer.prefix, xPlayer.name, xPlayer.source, table.concat(args, " ") },
      })
    end
  end)
end)

-- Thread:Create(function()
--     while true do
--         Citizen.Wait(4000)
--         local count = 0
--         for k,v in pairs(desc) do
--             count = count + 1
--             local ped = GetPlayerPed(k)
--             if ped then
--                 v.coords = GetEntityCoords(ped)
--             end
--         end
--         if count > 0 then
--             Event:TriggerNet('dwb:rpchat:descUpdated', -1, desc)
--         end
--     end
-- end)

Command:Register("opis", { "opis" }, function(xPlayer, args)
  -- desc[source] = {
  --     value = table.concat(args, " "),
  --     coords = GetEntityCoords(GetPlayerPed(source))
  -- }
  -- Player(xPlayer.source).state.description = table.concat(args, " ")
  Entity(GetPlayerPed(xPlayer.source)).state.description = table.concat(args, " ")
  -- Event:TriggerNet('dwb:rpchat:descUpdated', -1, desc)
end)

Command:Register("copis", { "Clear opis" }, function(xPlayer)
  -- desc[xPlayer.source] = nil
  Entity(GetPlayerPed(xPlayer.source)).state.description = nil
  -- Event:TriggerNet('dwb:rpchat:descUpdated', -1, desc)
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

Command:Register("try", { "try" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  local done = math.random(0, 1)
  checkDistance(xPlayer.source, 30, function(s, id, xPlayer)
    Event:TriggerNet("dwb:rpchat:try", id, s, message, done)
  end)
end)

Command:Register("opis2", { "opis2" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  desc[xPlayer.source] = {
    message = message,
    coords = GetEntityCoords(GetPlayerPed(xPlayer.source)),
    time = os.time(),
  }
  Event:TriggerNet("dwb:rpchat:opis2", -1, desc)
end)

Command:Register("copis2", { "copis2" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  desc[xPlayer.source] = nil
  Event:TriggerNet("dwb:rpchat:opis2", -1, desc)
end)
Command:Register("reset", { "cube" }, function(xPlayer, a)
  local time = tonumber(a[1])
  Thread:Create(function()
    local timer = 30000
    local text = "minut"
    local currentTime = time
    while time > 0.02 do
      if time >= 1.0 then
        time = time - 0.5
        currentTime = time
        text = "minuty"
        if time < 1.0 then
          timer = 10000
        end
      elseif time > 0.3 then
        timer = 10000
        time = time - 0.1
        currentTime = time * 100
        text = "sekund"
      elseif time > 0 then
        timer = 1000
        time = time - 0.01
        currentTime = time * 100
        text = "sekund"
      end
      Event:TriggerNet("dwb:chat:addMessage", -1, {
        template = '<div class="font-semibold"> <font color="pink" class="animate-rainbowtxt">[RESTART]:</font>&ensp;<font color="white">Restart za {0} {1}</font></div>',
        args = { currentTime, text },
      })
      Wait(timer)
    end
    Core:SavePlayers()
    Wait(5000)
    ExecuteCommand(string.format('quit "Restart przez %s', xPlayer and xPlayer.name or "Konsola"))
    os.execute("artifacts\\FXServer.exe +exec data/dwb.cfg +set onesync on +svgui")
  end)
  -- -- local name = xPlayer.char.data.firstname..' '..xPlayer.char.data.lastname
end)

Command:Register("event", { "cube" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  local done = math.random(6)
  local name = xPlayer.char.data.firstname .. " " .. xPlayer.char.data.lastname
  Event:TriggerNet("dwb:chat:addMessage", -1, {
    template = '<div class="font-semibold"> <font color="mint">[EVENT]:</font>&ensp;<font color="white">{0}</font></div>',
    args = { message },
  })
end, {})

Command:Register("news", { "cube" }, function(xPlayer, a)
  if xPlayer:HasLicense("news") then
    local message = table.concat(a, " ")
    local done = math.random(6)
    local name = xPlayer.char.data.firstname .. " " .. xPlayer.char.data.lastname
    Event:TriggerNet("dwb:chat:addMessage", -1, {
      template = '<div class="font-semibold"><i class="fas fa-newspaper "style="color:lime"></i> <font color="lime">@{0}:</font>&ensp;<font color="white">{1}</font></div>',
      args = { name, message },
    })
  end
end)

Command:Register("cube", { "cube" }, function(xPlayer, a)
  local message = table.concat(a, " ")
  local done = math.random(6)
  checkDistance(xPlayer.source, 30, function(s, id, xPlayer)
    Event:TriggerNet("dwb:rpchat:cube", id, s, message, done)
  end)
end)

User:OnLoaded(function(self)
  Event:TriggerNet("dwb:rpchat:welcome", -1, self.name)
end)
