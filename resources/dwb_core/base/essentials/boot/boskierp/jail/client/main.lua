if true then
  return
end
local carrying = false
Event:Register("dwb:jail:box:pick", function(entId)
  carrying = true
  local ped = PlayerPedId()
  local bone = GetPedBoneIndex(ped, 28422)
  local entity = NetworkGetEntityFromNetworkId(entId)
  N_0xb2d0bde54f0e8e5a(entity, true)
  AttachEntityToEntity(
    entity,
    PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(), 28422),
    0.0,
    0.1,
    -0.25,
    0.0,
    90.0,
    90.0,
    0,
    0,
    0,
    0,
    2,
    1
  )

  while carrying do
    Wait(1000)
    -- ForcePedMotionState(ped, -530524, 0,0,0)
    if not IsEntityPlayingAnim(ped, "anim@heists@load_box", "idle", 3) then
      Animation:Play(
        ped,
        "anim@heists@load_box",
        "idle",
        8.0,
        3.0,
        -1,
        57,
        1.0,
        false,
        false,
        false
      )
    end
  end
  ClearPedTasks(PlayerPedId())
end, true)

Event:Register("dwb:jail:box:give", function()
  carrying = false
end, true)

local time = 0

Event:Register("dwb:jail:update", function(time2)
  time = time2
end, true)

Event:Register("dwb:jail:start", function(time2)
  --SetEntityCoords(PlayerPedId(), Config.Default.Jail.coords)
  local sex = Skinchanger:GetSkin()
  if sex.sex == 1 then
    Skinchanger:Apply({}, Config.Clothes.Special.Jail.female)
  else
    Skinchanger:Apply({}, Config.Clothes.Special.Jail.male)
  end
  Sound:Play("cell", 0.5)
  Marker:Add("jail", {
    messages = {},
    marker = {},
    settings = {
      drawDist = 200.0,
      radius = 500.0,
      overrideCoords = true,
      drawMarker = false,
    },
    messages = {},
    coords = {
      pos = vec3(1689.44, 2597.47, 45.55),
    },
    functions = {
      onExitCb = function(zoneData, posData, ActionData)
        --SetEntityCoords(PlayerPedId(), Config.Default.Jail.coords)
      end,
    },
  })
  time = time2
  startTimer()
end, true)

function convertMinutesToHours(minutes)
  local hours = math.floor(minutes / 60)
  local minutes = minutes - (hours * 60)
  return hours, minutes
end

Event:Register("dwb:jail:stop", function()
  Marker:Remove("jail")
  --SetEntityCoords(PlayerPedId(), Config.Default.Outside.coords)
end, true)

function startTimer2()
  Thread:Create(function()
    while time > 0 do
      Wait(1000 * 60)
      time = time - 1
      Event:TriggerNet("dwb:jail:update", time)
    end
    Event:TriggerNet("dwb:jail:update", time)
  end)
end

function startTimer()
  startTimer2()
  while time > 0 do
    Wait(0)
    local playHour, playMinute = convertMinutesToHours(time)
    local value = string.format("~b~%02dh %02dm", playHour, playMinute)
    Text:Draw(value, {
      x = 0.09,
      y = 0.75,
    })
  end
  Event:TriggerNet("dwb:jail:stop")
end
