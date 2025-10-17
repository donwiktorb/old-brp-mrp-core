--- Blips Module
---Provides functionality for managing input controls.
---@module Blips

--- Controls class for managing input states.
---@type Blips
Blips = class()

Blips.blips = {}
Blips.madeBlips = {}

--- Set Data for blip
---@param blip string
---@param data table
function Blips:SetData(blip, data)
  DWB.Blips[blip] = data
end

--- Create Entity blip
---@param name string
---@param entity integer
function Blips:CreateEntity(name, entity)
  local blip = AddBlipForEntity(entity)
  Blips.blips[name] = { blip }
  return Blips.blips[name]
end

---@alias BlipStruct table
---@param label string
---@param sprite integer
---@param display integer
---@param color integer
---@param scale integer
---@param shortRange boolean

---@alias BlipData
---@param blip BlipStruct
---@param coords table

--- Create blip
---@param name string
---@param coords table
---@param data table
function Blips:Create(name, coords, data)
  if not data.blip then
    data.blip = data
  end
  --[[
        data-structure:
        blip: {
            label: string,
            sprite: int,
            display: int,
            color: int,
            scale: int,
            shortRange: boolean,
        },
        coords: {
            {
                pos: vector3,
                blip: {},
            }
        }
    ]]

  local blips = {}
  local newCoords = {}

  if Blips.blips[name] then
    newCoords = Blips.blips[name]
  end

  if not coords.x then
    newCoords = coords
  else
    table.insert(newCoords, coords)
  end

  for k, v in pairs(newCoords) do
    local blip = AddBlipForCoord(v)
    SetBlipSprite(blip, data.blip.sprite)
    SetBlipDisplay(blip, data.blip.display)
    SetBlipScale(blip, data.blip.scale)
    SetBlipColour(blip, data.blip.color)
    SetBlipAsShortRange(blip, data.blip.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.blip.label)
    EndTextCommandSetBlipName(blip)
    -- table.insert(Blips.blips, {blip = blip})
    table.insert(blips, blip)
  end

  Blips.blips[name] = blips

  return blips
end

function Blips:AddDynamic(name, posData, zoneData)
  local zoneBlipData = zoneData.blip
  local posBlipData = zoneBlipData or posData.blip

  local blip = AddBlipForCoord(posData.pos)

  SetBlipSprite(blip, posBlipData.sprite)
  SetBlipDisplay(blip, posBlipData.display)
  SetBlipScale(blip, posBlipData.scale)
  SetBlipColour(blip, posBlipData.color)
  SetBlipAsShortRange(blip, posBlipData.shortRange)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(posBlipData.label)
  EndTextCommandSetBlipName(blip)

  return blip
end

function Blips:Add(name, data)
  local blips = {}
  local mainBlipData = data.blip
  for k, v in pairs(data.coords) do
    local coords = v.pos
    local blipData = mainBlipData or v.blip
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, blipData.sprite)
    SetBlipDisplay(blip, blipData.display)
    SetBlipScale(blip, blipData.scale)
    SetBlipColour(blip, blipData.color)
    SetBlipAsShortRange(blip, blipData.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipData.label)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
  end

  Blips.blips[name] = blips

  return blips, blips[1]
end

--- Remove all blips
function Blips:RemoveAll()
  for _, v in Blips.blips do
    for k, b in v do
      RemoveBlip(v)
    end
  end
end

function Blips:Get(name, id)
  return id and Blips.blips[name][id] or Blips.blips[name]
end

--- Remove specified blip
---@param name string
function Blips:Remove(name, id)
  if Blips.blips[name] then
    if id then
      RemoveBlip(Blips.blips[name][id])
      table.remove(Blips.blips[name], id)
    else
      for _, v in pairs(Blips.blips[name]) do
        RemoveBlip(v)
      end
      Blips.blips[name] = nil
    end
  end
end

function Blips:RemoveDynamic(name, blip)
  RemoveBlip(blip)
end
