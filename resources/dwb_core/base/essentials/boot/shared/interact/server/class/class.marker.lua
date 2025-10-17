Interact.Markers = {
  markers = {},
}
function Interact.Markers:Load(markers)
  self.markers = markers
  for k, v in pairs(self.markers) do
    for n, m in pairs(v) do
      m.index = n
    end
  end
end
function Interact.Markers:Unload()
  self.markers = {}
end

function Interact.Markers:Edit(mode, target, dataOrCb)
  local found, targetMarker, targetMarkerParent = self:GetBy(mode, target)
  if type(dataOrCb) == "function" then
    dataOrCb(targetMarker, targetMarkerParent)
  else
    Mode:TriggerEvent(mode, "dwb:markers:edit", target, dataOrCb)
    if dataOrCb.fromParent then
      for i = 1, #dataOrCb.fromParent do
        local targetPData = targetMarkerParent
        for n = 1, #dataOrCb.fromParent[i] do
          targetPData = targetPData[dataOrCb.fromParent[i][n]]
        end
        local targetMData = targetMarker
        for n = 1, #dataOrCb.toChild[i] - 1 do
          targetMData = targetMData[dataOrCb.toChild[i][n]]
        end
        targetMData[dataOrCb.toChild[i][#dataOrCb.toChild[i]]] = targetPData
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
  end
end
function Interact.Markers:Add(type, data)
  table.insert(self.markers[type], data)
  Mode:TriggerEvent(type, "dwb:markers:add", data)
end
function Interact.Markers:GetBy(gameType, target, dataOrCb)
  local keys, values, deep = target[1], target[2], target[3] or {}
  local targetMarker = self.markers[gameType]
  local targetMarkerParent
  local found = false
  local targetMarkerId, targetMarkerParentId
  for i = 1, #keys do
    for k, v in pairs(targetMarker) do
      if type(keys[i]) == "table" then
        local currentKey = keys[i][1]
        local currentTarget = v or targetMarker
        for n = 1, #keys[i] do
          if currentTarget then
            currentTarget = currentTarget[keys[i][n]]
          end
        end
        if currentTarget == values[i] then
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
function Interact.Markers:AddTo(gameType, target, dataOrCb)
  local found, targetMarker, targetMarkerParent = self:GetBy(gameType, target)
  if found then
    if type(dataOrCb) == "function" then
      dataOrCb(targetMarker, targetMarkerParent)
    else
      Mode:TriggerEvent(gameType, "dwb:markers:add:to", target, dataOrCb)
      table.insert(targetMarker, dataOrCb)
    end
  end
end

function Interact.Markers:Remove(type, target)
  local found, targetMarker, targetMarkerParent, targetMarkerId, targetMarkerParentId =
    self:GetBy(type, target)
  if found then
    if targetMarkerParentId then
      table.remove(self.markers[targetMarkerId].coords, targetMarkerParentId)
    else
      table.remove(self.markers, targetMarkerId)
    end
  end
  Mode:TriggerEvent(type, "dwb:markers:remove", target)
end

MarkerM = class()

function MarkerM:EditBlip(key, value, key2, value2, blipData, blipKey) end

function MarkerM:EditText(key, value, key2, value2, textId, textData) end

function MarkerM:EditBlipSingle(key, value, key2, value2, blipData, blipKey) end

function MarkerM:UpdateBlipSingle(key, value, key2, value2, blipData) end

function MarkerM:EditCoordsByData(key, value, key2, value2, dataKey, dataValue) end

function MarkerM:EditBlipByData(key, value, key2, value2, blipData, blipKey) end

function MarkerM:EditData(key, value, key2, value2, dataKey, dataValue) end
