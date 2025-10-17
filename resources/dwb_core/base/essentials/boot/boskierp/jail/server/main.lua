User:OnLoadedChar(function(self)
  if self.char.data.jailTime and self.char.data.jailTime > 0 then
    self:JailPlayer(self.char.data.jailTime)
  end
end)

function User:JailPlayer(time)
  self:SetCharData("jailTime", time)
  Event:TriggerNet("dwb:jail:start", self.source, time)
end

function User:UnJailPlayer()
  self:SetCharData("jailTime", nil)
  Event:TriggerNet("dwb:jail:stop", self.source)
end

function User:RemoveJailTime(value)
  local newValue = self.char.data.jailTime - value
  if newValue > 0 then
    self:SetCharData("jailTime", newValue)
    Event:TriggerNet("dwb:jail:update", self.source, newValue)
  else
    self:SetCharData("jailTime", 0)
    Event:TriggerNet("dwb:jail:stop", self.source, newValue)
  end
end

Event:Register("dwb:jail:update", function(source, xPlayer, time)
  xPlayer:SetCharData("jailTime", time)
  if time <= 0 then
    Event:TriggerNet("dwb:jail:stop", source)
  end
end, true)

Event:Register("dwb:jail:stop", function(source, xPlayer, time)
  local box = Player(source).state.jailBox
  if box then
    box = NetworkGetEntityFromNetworkId(box)
    DeleteEntity(box)
    Player(source).state.jailBox = nil
    ClearPedTasks(ped)
  end
end, true)

-- -- RegisterCommand('xd2', function(s)
-- --     local xPlayer = DWB.Players[s]
-- --     xPlayer:JailPlayer(200)

-- -- end, restricted)

Event:Register("dwb:cursor:submit", function(source, xPlayer, action, entityId, data, entData)
  local ped = GetPlayerPed(source)
  local pedCoords = GetEntityCoords(ped)
  if action.name == "jail-box" then
    local box = Player(source).state.jailBox
    if data.current.value == "pick" then
      if not box then
        local source = source
        Object:CreateAsync("hei_prop_heist_box", pedCoords, function(obj, objId)
          Player(source).state.jailBox = objId
          Event:TriggerNet("dwb:jail:box:pick", source, objId)
        end)
      end
    elseif data.current.value == "give" then
      if box then
        box = NetworkGetEntityFromNetworkId(box)
        DeleteEntity(box)
        Player(source).state.jailBox = nil
        Event:TriggerNet("dwb:jail:box:give", source)
        ClearPedTasks(ped)
        xPlayerRemoveJailTime(entData.removeTime or 5)
        xPlayer.inventory:AddItem({
          name = "cash",
          amount = 200,
        })
      end
    end
  end
end, true)

User:OnCustomEvent("prison_work", function(xPlayer, zoneData, posData)
  local ped = GetPlayerPed(xPlayer.source)
  local pedCoords = GetEntityCoords(ped)
  local box = Player(xPlayer.source).state.jailBox
  if posData.type == "pick" then
    if not box then
      local source = xPlayer.source
      Object:CreateAsync("hei_prop_heist_box", pedCoords, function(obj, objId)
        Player(source).state.jailBox = objId
        Event:TriggerNet("dwb:jail:box:pick", source, objId)
      end)
    end
  elseif posData.type == "give" then
    if box then
      box = NetworkGetEntityFromNetworkId(box)
      DeleteEntity(box)
      Player(xPlayer.source).state.jailBox = nil
      Event:TriggerNet("dwb:jail:box:give", xPlayer.source)
      ClearPedTasks(ped)
      xPlayer:RemoveJailTime(posData.time)
      xPlayer.inventory:AddItem({
        name = "cash",
        count = posData.price,
      })
    end
  end
end)

