local allProperties = {}
local gateways = {}
local allGateways = {}
function convertToCoords(coords)
  if not coords then
    return
  end
  return vec3(coords.x, coords.y, coords.z + 1)
end
local single = {}

User:OnLoadedChar(function(self)
  self.property = Property(self)
  self.property:Load(single)
  if self.char.data.InProperty then
    Event:TriggerNet("dwb:property:exit", self.source, self.char.data.InProperty)
    self.char.data.InProperty = nil
  end
end)

User:OnUnloadedChar(function(self)
  self.property:Unload()
end)

Mysql:onReady(function()
  allProperties = Mysql.Sync:fetchAll("SELECT * FROM properties ORDER BY `is_gateway` DESC")
  local sameGateways = {}
  for k, v in pairs(allProperties) do
    v.ipls = json.decode(v.ipls)
    v.entering = json.decode(v.entering)
    v.exit = json.decode(v.exit)
    v.inside = json.decode(v.inside)
    v.outside = json.decode(v.outside)
    v.room_menu = json.decode(v.room_menu)

    v.entering = convertToCoords(v.entering)
    v.exit = convertToCoords(v.exit)
    v.inside = convertToCoords(v.inside)
    v.outside = convertToCoords(v.outside)
    v.room_menu = convertToCoords(v.room_menu)

    v.is_room = v.is_room == 1 and true or false
    v.is_gateway = v.is_gateway == 1 and true or false
    v.one_owner = v.one_owner == 1 and true or false
    v.owner = v.owner and tonumber(v.owner)

    if v.one_owner then
      single[v.name] = v
    end

    -- if v.entering then
    --     v.entering = v.entering+1
    -- end

    -- if v.exit then
    --     v.exit = v.exit+1
    -- end

    -- if v.room_menu then
    --     v.room_menu = v.room_menu + 1
    -- end

    local name = v.name
    local label = v.label
    local entering = v.entering
    local exit = v.exit
    local inside = v.inside
    local outside = v.oustide
    local ipls = v.ipls
    local gateway = v.gateway -- bramka do wejscia np te same apartamenty w takim samym menu
    local is_single = v.is_single
    local is_room = v.is_room
    local is_gateway = v.is_gateway
    local room_menu = v.room_menu
    local price = v.price

    local is_opposite_gateway = is_room and is_gateway

    if is_gateway then
      v.is_opposite_gateway = is_opposite_gateway
      allGateways[v.name] = v
    end

    if gateway then
      if not gateways[gateway] then
        gateways[gateway] = {}
      end

      local gate = allGateways[v.gateway]

      -- if gate and gate.is_opposite_gateway then
      --     v.inside = gate.inside
      --     v.room_menu = gate.room_menu
      -- end

      if not v.oustide and gate then
        v.outside = v.entering
      end

      if not v.inside and gate then
        v.inside = gate.inside
      end

      table.insert(gateways[gateway], v)
    end

    if entering then
      Interact.Markers:AddTo("boskierp", { { "name" }, { "property-enter" }, { "coords" } }, {
        pos = v.entering,
        data = v,
        noBlip = v.one_owner and v.owner,
      })
    end

    if exit then
      Interact.Markers:AddTo("boskierp", { { "name" }, { "property-exit" }, { "coords" } }, {

        pos = v.exit,
        data = v,
      })
    end

    if v.room_menu then
      Interact.Markers:AddTo("boskierp", { { "name" }, { "property-room" }, { "coords" } }, {
        pos = v.room_menu,
        data = v,
      })
    end

    if v.one_owner then
      if not v.owner then
        Interact.Markers:Edit(
          "boskierp",
          { { "name", { "data", "name" } }, { "property-enter", v.name }, { "coords" } },
          {
            fromParent = { { "singleBlip" } },
            toChild = { { "blip" } },
          }
        )
      end
    end
  end
end)

function SetPropertyOwned(xPlayer, name)
  Mysql.Async:Execute("UPDATE properties SET owner = ? WHERE name = ?", {
    xPlayer.charId,
    name,
  }, function(rowsChanged)
    MarkerM:EditData("name", "property-enter", "name", name, "owner", xPlayer.carId)
    MarkerM:EditCoordsByData("name", "property-enter", "name", name, "noBlip", true)
    Event:TriggerNet("dwb:property:owned", -1, name, xPlayer.charId)
  end)
end

local properties = {}

User:OnCustomEvent("property-enter", function(self, zoneData, posData)
  local data = posData.data
  if data.is_gateway then
    local houses = gateways[data.name]
    local newHouses = {}
    for k, v in pairs(houses) do
      local prop = self.property:Get(v.name, "name")
      table.insert(newHouses, {
        label = v.label,
        price = v.price,
        value = v.name,
        name = v.name,
        owned = prop and true or false,
        data = v,
        one_owner = v.one_owner,
        owner = v.owner,
      })
    end
    Event:TriggerNet(
      "dwb:property:menu",
      self.source,
      posData.data,
      newHouses or false,
      false,
      #self.property:GetAllSingle(),
      Config.Properties.SingleLimit
    )
  else
    local prop = self.property:Get(data.name, "name")
    Event:TriggerNet(
      "dwb:property:menu",
      self.source,
      posData.data,
      false,
      prop or false,
      #self.property:GetAllSingle(),
      Config.Properties.SingleLimit
    )
  end
end)

User:OnCustomEvent("property-exit", function(self, zoneData, posData)
  self.char.data.InProperty = false
  if properties[self.source] then
    local obj = properties[self.source]
    local data = obj.data
    local oldData = obj.data
    if data.gateway then
      -- data = gateways[data.name]
      data = allGateways[data.gateway]
    end
    if not data.outside then
      data = oldData
    end
    for k, v in pairs(properties[self.source].players) do
      Routing:Set(v, 0)
      Event:TriggerNet("dwb:property:exit", v, data)
    end
    properties[self.source] = nil
    Routing:Set(self.source, 0)
    Event:TriggerNet("dwb:property:exit", self.source, data)
  else
    for k, v in pairs(properties) do
      local data = v.data
      if data.gateway then
        -- data = gateways[data.name]
        data = allGateways[data.gateway]
      end
      if not data.outside then
        data = v.data
      end
      for k2, v2 in pairs(v.players) do
        if v2 == self.source then
          table.remove(v.players, k2)
          Routing:Set(self.source, 0)
          Event:TriggerNet("dwb:property:exit", self.source, data)
        end
      end
    end
  end
end)

function getPropertyBySource(src)
  if properties[src] then
    return properties[src], src, nil, true
  else
    for k, v in pairs(properties) do
      for k2, v2 in pairs(v.players) do
        if v2 == src then
          return v, k, k2
        end
      end
    end
  end
end

User:OnUnloaded(function(self)
  local prop, propId, playerId, owner = getPropertyBySource(self.source)
  if prop then
    if owner then
      for k, v in pairs(prop.players) do
        Routing:Set(v, 0)
        Event:TriggerNet("dwb:property:exit", v, prop.data)
      end
      properties[propId] = nil
    else
      table.remove(prop.players, playerId)
    end
  end
end)

User:OnCustomEvent("property-room", function(self, zoneData, posData)
  local prop = getPropertyBySource(source).prop
  Event:TriggerNet("dwb:property:room", self.source, posData, prop)
end)

Event:Register("dwb:property:save:skin", function(source, xPlayer, name, skin)
  local prop = getPropertyBySource(source).prop
  table.insert(prop.clothes, {
    label = name,
    skin = skin,
  })
end, true)

Event:Register("dwb:property:remove:skin", function(source, xPlayer, id)
  local prop = getPropertyBySource(source).prop
  table.remove(prop.clothes, id)
end, true)

Event:Register("dwb:property:inventory", function(source, xPlayer, id)
  local prop = getPropertyBySource(source).prop
  -- if not prop.occupied then
  --     prop.occupied = true
  xPlayer.inventory:OpenEasy({
    name = "property",
    label = "Mieszkanie",
    items = prop.items,
  }, {
    canChangeSlot = true,
    canChangeItem = true,
    doNotRemoveItem = false,
  }, function(data)
    return true
  end, function(data)
    return true
  end, function(data, inv)
    return true
  end)
  -- end
end, true)

Event:Register("dwb:property:enter", function(source, xPlayer, data, data2)
  globalThis = {}
  local prop = xPlayer.property:Get(data2 and data2.name or data.name, "name")
  properties[source] = {
    players = {},
    data = data2 and data2 or data,
    prop = prop,
  }
  -- Routing:Set(source, source)
  Routing:Set(source, source)
  xPlayer.char.data.InProperty = data2 and data2 or data
  Event:TriggerNet("dwb:property:enter", source, data2 and data2 or data)
end, true)

Event:Register("dwb:property:exit", function(source, xPlayer, data)
  xPlayer.char.data.InProperty = false
  if properties[source] then
    local obj = properties[source]
    for k, v in pairs(properties[source].players) do
      -- Routing:Set(v, 0)
      Routing:Set(v, 0)
      Event:TriggerNet("dwb:property:exit", v, obj.data)
    end
  else
    for k, v in pairs(properties) do
      local data = v.data
      for k2, v2 in pairs(v.players) do
        if v2 == source then
          table.remove(v.players, k2)
          Routing:Set(v, 0)
          Event:TriggerNet("dwb:property:exit", source, data)
        end
      end
    end
  end
end, true)

Event:RegisterCb("dwb:property:call", function(source, cb, data)
  local players = {}
  local name = data.value
  for k, v in pairs(properties) do
    if v.data.name == data.name then
      table.insert(players, {
        name = GetPlayerName(k),
        source = k,
      })
    end
  end
  cb(players)
end)

Event:Register("dwb:property:ask", function(source, xPlayer, player)
  Event:TriggerNet("dwb:property:ask", player, source, GetPlayerName(source))
end, true)

Event:Register("dwb:property:ask:accept", function(source, xPlayer, player)
  globalThis = {}
  local prop = properties[source]
  local zPlayer = DWB.Players[player]
  table.insert(properties[source].players, player)
  Routing:Set(player, source)
  zPlayer.char.data.InProperty = prop.data
  Event:TriggerNet("dwb:property:enter", player, prop.data)
end, true)

Event:Register("dwb:property:ask:deny", function(source, xPlayer, player)
  local zPlayer = DWB.Players[player]
  zPlayer:ShowNotify("info", TR("property"), TR("request_deny"))
end, true)

Event:Register("dwb:property:buy", function(source, xPlayer, data)
  local items, count = xPlayer.inventory:GetItems(Config.Items.Money, "name")
  if count >= data.price then
    xPlayer:ShowNotify("info", TR("property"), TR("bought"))
    xPlayer.inventory:RemoveItems(Config.Items.Money, "name", data.price)
    xPlayer.property:Add(data.value, data.data and data.data.one_owner or false)
    xPlayer.property:Refresh()
    if data.data and data.data.one_owner then
      SetPropertyOwned(xPlayer, data.value)
    end
  else
    xPlayer:ShowNotify("info", TR("property"), TR("not_enough_money", data.price - count))
  end
end, true)

-- -- -- -- for k,v in pairs(Config.Properties.Properties) do
-- -- -- --     v.is_gateway = false
-- -- -- --     v.type = 'property-single'
-- -- -- --     v.gateway = 'LowEndApartment'
-- -- -- --     local entering = vec3(v.entering.x, v.entering.y, v.entering.z-1)
-- -- -- --     local outside = vec3(v.exit.x, v.exit.y, v.exit.z-1)
-- -- -- --     v.entering = entering
-- -- -- --     v.exit = nil
-- -- -- --     v.outside = outside
-- -- -- --     Database.Async:Insert('INSERT INTO properties (id, name, label, entering, `exit`, gateway, price, one_owner, type) VALUES (?)',{

-- -- -- --             {0,v.name, v.label, json.encode(v.entering), json.encode(v.exit), v.gateway, v.price, true, v.type}
-- -- -- --     })

-- -- -- -- end
