Event:Register("dwb:driving:open", function(price, hasDMV)
  UI:Open("Menu", {
    name = "driving",
    title = "Jazda",
    elements = not hasDMV and {
      { label = TR("dmv", Config.Driving.Prices["dmv"]), value = "dmv" },
    } or {
      {
        label = TR("cat_a", Config.Driving.Prices["driving_a"]),
        value = "driving_a",
      },
      {
        label = TR("cat_b", Config.Driving.Prices["driving_b"]),
        value = "driving_b",
      },
      {
        label = TR("cat_c", Config.Driving.Prices["driving_c"]),
        value = "driving_c",
      },
    },
  }, function(data, menu)
    menu.close()
    Event:TriggerNet("dwb:driving:start", data.current.value, hasDMV)
  end)
end, true)

function startDMV(lic, question, errors)
  local questionId = question or 1
  local question = Config.Driving.Questions[lic][questionId]
  local hasNextQuestion = Config.Driving.Questions[lic][questionId + 1]
  local errors = errors or 0
  UI:Open("Menu", {
    show = true,
    name = "property-skin",
    title = question.label,
    align = "center",
    elements = table.shuffle(question.answers),
  }, function(data, menu)
    menu.close()
    if not data.current.correct then
      errors = errors + 1
    end

    if not hasNextQuestion then
      Event:TriggerNet("dwb:driving:done", lic, errors)
    else
      startDMV(lic, question + 1, errors)
    end
  end, function(data, menu)
    menu.close()
  end)
end

Event:Register("dwb:driving:start", function(lic, hasDMV)
  if not hasDMV then
    startDMV("dmv")
  else
    startMe(lic)
  end
end, true)
local currentZone = "residence"
local function setCurrentZoneType(zone)
  currentZone = zone
end

local functions = {

  onEnterCb = function(zoneData, posData)
    --DWB.Zones[zoneData.name].coords[1] = nil
    if posData.action then
      posData.action(DWB.PlayerData.Vehicle, setCurrentZoneType)
    end
    --return true
  end,

  onUpdate = function(zoneData, posData)
    local currentLim = Config.Driving.Limits[currentZone]
    if GetEntitySpeed(DWB.PlayerData.Vehicle) >= currentLim then
      zoneData.errors = zoneData.errors + 1
    end

    if zoneData.errors >= Config.Driving.maxErrors then
      Marker:Remove("drivin")
      Event:TriggerNet("dwb:driving:done", zoneData.cat, zoneData.errors)
    end
  end,

  onFinishRouteCb = function(zoneData, posData)
    Event:TriggerNet("dwb:driving:done", zoneData.cat, zoneData.errors)
  end,
}

function startMe(cat)
  local marker = Config.Driving.Zones["driving_a"]
  local points = Config.Driving.Points["driving_a"]
  marker.functions = functions
  marker.coords = points
  marker.errors = 0
  for k, v in pairs(marker.coords) do
    v.pos = vec3(v.pos.x, v.pos.y, v.pos.z + 1)
  end
  marker.cat = cat
  Marker:Add("drivin", marker)

  --  Thread:Create(function()
  --    while Marker:Get("drivin") do
  --      Wait(0)
  --    end
  --  end)
end
