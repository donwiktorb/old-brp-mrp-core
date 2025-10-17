Interact.Markers = {}
local functionOverrides = {
  canClickCb = function(zoneData, posData)
    if (zoneData.preventVehicle or posData.preventVehicle) and DWB.PlayerData.InVehicle then
      return false
    end
    if not posData.check then
      return true
    end

    for k, v in pairs(posData.check) do
      local cb = Config.Markers.Checks[v.name]
      if not cb() then
        local msg = v[false]
        Notification:ShowCustom(msg.type, msg.title, msg.message)
        return false
      end
    end

    return true
  end,
  onExitCb = function(zoneData, posData)
    if not zoneData.keepUI and not posData.keepUI then
      UI:CloseAll()
    end
  end,
  onClickCb = function(zoneData, posData)
    Event:TriggerNet("dwb:marker:submit", zoneData, posData)
  end,
  onCloseDist = function(zoneData, posData)
    local color = {
      r = 255,
      g = 255,
      b = 255,
      a = 255,
    }

    local text = posData.text or zoneData.text or {}

    if zoneData.liveText then
      text = Interact.Markers.markers[zoneData.index].text
    end

    if posData.liveText then
      text = Interact.Markers.markers[zoneData.index].coords[posData.index].text
    end

    for i = 1, #text do
      local v = text[i]
      color = v.color or color
      local pos = vec3(posData.pos.x, posData.pos.y, posData.pos.z + 2 - (i / 2))
      if v.offset then
        pos = vec3(posData.pos.x, posData.pos.y, (posData.pos.z + 2 - (i / 2)) - v.offset)
      end
      Text:Draw3D(
        pos,
        v.label,
        { font = v.font or 7, size = v.size or 4, r = color.r, g = color.g, b = color.b }
      )
    end
  end,
}

local trackEnterFunctions = {
  onEnterCb = function(zoneData, posData)
    Event:TriggerNet("dwb:marker:enter", zoneData, posData)
  end,
  onExitCb = function(zoneData, posData)
    Event:TriggerNet("dwb:marker:exit", zoneData, posData)
  end,
}

local trackEnterFunctionsClient = {
  onEnterCb = function(zoneData, posData)
    local cb = zoneData.onEnterCb
    if cb then
      Config.Markers.onEnterCbs[cb.name](cb.data, zoneData, posData)
    end
  end,
  onExitCb = function(zoneData, posData)
    local cb = zoneData.onExitCb
    if cb then
      Config.Markers.onExitCbs[cb.name](cb.data, zoneData, posData)
    end
  end,
}

function Interact.Markers:AddFunctions(v, fncs)
  if not v.functions then
    v.functions = {}
  end

  for k, v2 in pairs(fncs or functionOverrides) do
    if not v.functions[k] then
      v.functions[k] = v2
    end
  end

  if v.settings.trackEnter then
    v.functions.onEnterCb = trackEnterFunctions.onEnterCb
  end

  if v.settings.trackEnterClient then
    v.functions.onEnterCb = trackEnterFunctionsClient.onEnterCb
  end

  if v.settings.trackLeave then
    v.functions.onExitCb = trackEnterFunctions.onExitCb
  end

  if v.settings.trackLeaveClient then
    v.functions.onExitCb = trackEnterFunctionsClient.onExitCb
  end

  if v.secondClick then
    v.functions.onSecondClickCb = function(zoneData, posData)
      Event:TriggerNet("dwb:marker:submit:second", zoneData, posData)
    end
  end
end

function Interact.Markers:RunBlips(v)
  local cb = v.onCreatedCb
  if cb then
    Config.Markers.onCreateCbs[cb.name](cb.data, v)
  end

  if Config.Markers.Debug.AllBlips or v.noBlip then
    print(v.name)
    return
  end

  if v.coords then
    for k4, v4 in pairs(v.coords) do
      self:CreateBlip(v4, v)
    end
  else
    print(v.name)
  end
end
function Interact.Markers:RefreshBlip(target, t)
  self:RemoveBlip(target)
  if not target.noBlip and not t.noBlip then
    self:CreateBlip(target, t)
  end
end
function Interact.Markers:RunRemoveBlips(v)
  local cb = v.onRemoveCb
  if cb then
    Config.Markers.onRemoveCbs[cb.name](cb.data, v)
  end

  if Config.Markers.Debug.AllBlips or v.noBlip then
    return
  end

  if v.coords then
    for k, v4 in pairs(v.coords) do
      self:RemoveBlip(v4, v)
    end
  else
    print(v.name)
  end
end
function Interact.Markers:RemoveBlip(target, targetP)
  print(target.blipId)
  RemoveBlip(target.blipId)
  target.blipId = nil
end
function Interact.Markers:CreateBlip(mainBlipData, otherBlipData)
  if not Config.Markers.Debug.AllBlips and (mainBlipData.noBlip or otherBlipData.noBlip) then
    return
  end

  local blip = otherBlipData.blip or {}
  local otherBlip = mainBlipData.blip or {}
  local label = otherBlip.label or blip.label or "None"
  local category = otherBlip.category or blip.category or 4
  local color = otherBlip.color or blip.color or 5
  local alpha = otherBlip.alpha or blip.alpha or 255
  local rotation = otherBlip.rotation or blip.rotation
  local scale = otherBlip.scale or blip.scale or 0.9
  local sprite = otherBlip.sprite or blip.sprite or 54
  local shortRange = otherBlip.shortRange or blip.shortRange
  local display = otherBlip.display or blip.display or 20
  local flash = otherBlip.flash or blip.flash
  local blipType = otherBlip.blipType or blip.blipType or "coords"
  local autoLabel = otherBlip.autoLabel or blip.autoLabel
  --label = otherBlip.label or blip.label or "None"
  if Config.Markers.Debug.Names then
    label = mainBlipData.data and mainBlipData.data.label or label
  end

  if autoLabel then
    label = mainBlipData.data and mainBlipData.data.label or label
  end

  if label then
    local name = mainBlipData.name or otherBlipData.name
    AddTextEntry(name, label)
  end

  local blipId = otherBlip.blipId or blip.blipId
  if not blipId then
    if blipType == "coords" then
      blipId = AddBlipForCoord(mainBlipData.pos)
    elseif blipType == "radius" then
      blipId = AddBlipForRadius(mainBlipData.pos, otherBlip.radius or blip.radius)
    elseif blipType == "area" then
      blipId = AddBlipForArea(
        mainBlipData.pos.x,
        mainBlipData.pos.y,
        mainBlipData.pos.z,
        otherBlip.width or blip.width,
        otherBlip.height or blip.height
      )
    end
  end
  if sprite then
    SetBlipSprite(blipId, sprite)
  end

  if display then
    SetBlipDisplay(blipId, display)
  end

  local name = mainBlipData.name or otherBlipData.name

  if category then
    SetBlipCategory(blipId, category)
  end

  if scale then
    SetBlipScale(blipId, scale)
  end

  if rotation then
    SetBlipRotation(blipId, math.ceil(rotation))
  end

  if alpha then
    SetBlipAlpha(blipId, alpha)
  end

  SetBlipAsShortRange(blipId, shortRange)
  SetBlipColour(blipId, color)
  SetBlipFlashes(blipId, flash)

  if label then
    BeginTextCommandSetBlipName(name)
    --AddTextComponentString(label)
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blipId)
  end
  mainBlipData.blipId = blipId
end

function Interact.Markers:LoadCustom(markers, fncs)
  while not self.loaded do
    Wait(0)
  end
  for k, v in pairs(markers or {}) do
    local canMake = true
    local cb = v.onCreateCb
    if cb then
      canMake = Config.Markers.CreateCbs[cb.name](cb.data, v)
    end
    if canMake then
      self:AddFunctions(v, fncs)
      self:RunBlips(v)
      Marker:Add(v.name or k, v)
      table.insert(self.markers, v)
    end
  end
end

function Interact.Markers:Load(markers)
  self.markers = markers
  for k, v in pairs(markers or {}) do
    local canMake = true
    local cb = v.onCreateCb
    if cb then
      canMake = Config.Markers.CreateCbs[cb.name](cb.data, v)
    end
    if canMake then
      self:AddFunctions(v)
      self:RunBlips(v)
      Marker:Add(v.name or k, v)
    end
  end
  self.loaded = true
end
function Interact.Markers:Unload()
  for k, v in pairs(self.markers or {}) do
    self:RunRemoveBlips(v)
    Marker:Remove(v.name or k)
  end
  self.loaded = false
end
function Interact.Markers:Refresh()
  while not self.loaded do
    Wait(0)
  end
  for k, v in pairs(self.markers) do
    Wait(0)
    local canMake = true
    local cb = v.onCreateCb
    if cb then
      canMake = Config.Markers.CreateCbs[cb.name](cb.data)
    end

    if canMake and not DWB.Zones[v.name] then
      self:AddFunctions(v)
      self:RunBlips(v)
      Marker:Add(v.name or k, v)
    elseif not canMake and DWB.Zones[v.name] then
      self:RunRemoveBlips(v)
      Marker:Remove(v.name or k)
    end
  end
end
function Interact.Markers:Edit(target, dataOrCb)
  while not self.loaded do
    Wait(0)
  end
  local found, targetMarker, targetMarkerParent = self:GetBy(target)
  if type(dataOrCb) == "function" then
    dataOrCb(targetMarker, targetMarkerParent)
  else
    if dataOrCb.fromParent then
      for i = 1, #dataOrCb.fromParent do
        local targetPData = targetMarkerParent
        for n = 1, #dataOrCb.fromParent[i] do
          targetPData = targetPData[dataOrCb.fromParent[i][n]]
        end
        if dataOrCb.toChild then
          local targetMData = targetMarker
          for n = 1, #dataOrCb.toChild[i] - 1 do
            targetMData = targetMData[dataOrCb.toChild[i][n]]
          end
          targetMData[dataOrCb.toChild[i][#dataOrCb.toChild[i]]] = targetPData
        end
      end
    end

    if dataOrCb.childValue then
      for i = 1, #dataOrCb.toChild do
        if dataOrCb.toChild then
          local targetMData = targetMarker
          for n = 1, #dataOrCb.toChild[i] - 1 do
            targetMData = targetMData[dataOrCb.toChild[i][n]]
          end
          targetMData[dataOrCb.toChild[i][#dataOrCb.toChild[i]]] = dataOrCb.childValue[i]
        end
      end
    end
    if dataOrCb.refreshBlip then
      --self:RunRemoveBlips()
      self:RefreshBlip(targetMarker, targetMarkerParent)
    end
  end
end
function Interact.Markers:Add(data)
  local canMake = true
  local cb = data.onCreateCb
  if cb then
    canMake = Config.Markers.CreateCbs[cb.name](cb.data, v)
  end
  if canMake then
    self:AddFunctions(data)
    Marker:Add(data.name, data)
    table.insert(self.markers, data)
  end
end
function Interact.Markers:GetBy(target, dataOrCb)
  local keys, values, deep = target[1], target[2], target[3] or {}
  local targetMarker = self.markers
  local targetMarkerParent
  local found = false
  local targetMarkerId, targetMarkerParentId
  for i = 1, #keys do
    Wait(0)
    for k, v in pairs(targetMarker) do
      Wait(0)
      if type(keys[i]) == "table" then
        local currentKey = keys[i][1]

        local currentTarget = v or targetMarker
        for n = 1, #keys[i] do
          Wait(0)
          if currentTarget then
            currentTarget = currentTarget[keys[i][n]]
          end
        end
        if currentTarget == values[i] then
          --targetMarkerParent = targetMarker
          targetMarker = v
          break
        end
      else
        if v[keys[i]] == values[i] then
          local currentDeep = deep[i]
          targetMarkerParent = targetMarker
          targetMarkerParentId = targetMarkerId
          targetMarkerId = k
          targetMarker = v
          if currentDeep then
            targetMarkerParent = targetMarker
            targetMarker = v[currentDeep]
          end
          found = true
          if not keys[i + 1] then
            break
          end
        end
      end
    end
  end

  return found, targetMarker, targetMarkerParent, targetMarkerId, targetMarkerParentId
end
function Interact.Markers:AddTo(target, dataOrCb)
  local found, targetMarker, targetMarkerParent = self:GetBy(target)
  if found then
    if type(dataOrCb) == "function" then
      dataOrCb(targetMarker, targetMarkerParent)
    else
      table.insert(targetMarker, dataOrCb)
    end
  end
end

function Interact.Markers:Remove(target)
  local found, targetMarker, targetMarkerParent, targetMarkerId, targetMarkerParentId =
    self:GetBy(target)
  if found then
    if targetMarkerParentId then
      self:RemoveBlip(targetMarker, targetMarkerParent)
      table.remove(self.markers[targetMarkerId].coords, targetMarkerParentId)
    else
      self:RunRemoveBlips(targetMarker)
      table.remove(self.markers, targetMarkerId)
      Marker:Remove(targetMarker.name)
    end
  end
end

MarkerM = class()

function MarkerM:EditBlip(key, value, key2, value2, blipData, blipKey) end

function MarkerM:EditText(key, value, key2, value2, textId, textData) end

function MarkerM:EditBlipSingle(key, value, key2, value2, blipData, blipKey) end

function MarkerM:UpdateBlipSingle(key, value, key2, value2, blipData) end

function MarkerM:EditCoordsByData(key, value, key2, value2, dataKey, dataValue) end

function MarkerM:EditBlipByData(key, value, key2, value2, blipData, blipKey) end

function MarkerM:EditData(key, value, key2, value2, dataKey, dataValue) end
