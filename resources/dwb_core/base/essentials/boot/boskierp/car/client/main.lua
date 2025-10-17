Event:Register("dwb:player:vehicle:enter", function()
  DisplayRadar(true)
end)

Event:Register("dwb:player:vehicle:exit", function()
  DisplayRadar(false)
end)

local wasInVeh = false
local seatbelt = false
local headings = {
  {
    value = 0,
    name = "N",
  },
  {
    value = 45,
    name = "NE",
  },
  {
    value = 90,
    name = "E",
  },
  {
    value = 135,
    name = "SE",
  },
  {
    value = 180,
    name = "S",
  },
  {
    value = 225,
    name = "SW",
  },
  {
    value = 270,
    name = "W",
  },
  {
    value = 315,
    name = "NW",
  },
  {
    value = 360,
    name = "N",
  },
}

function getName(heading)
  for i = 1, #headings do
    if heading >= headings[i].value and heading < headings[i + 1].value then
      return headings[i].name
    end
  end
end

Thread:Create(function()
  local types = {
    [0] = "Speed",
    [1] = "Speed2",
    [4] = "SpeedOG",
  }
  local type
  local _drawRect = DrawRect
  function drawRct(x, y, width, height, r, g, b, a)
    _drawRect(x, y, width, height, r, g, b, a)
  end
  while true do
    Wait(DWB.UISettings["speed-update"] or 0) -- albo 500
    if
      DWB.PlayerData.InVehicle
      and not DWB.PlayerData.IsVehicleType("bike")
      and DWB.UISettings["speedometer-on"]
    then
      if not type then
        type = types[DWB.UISettings["speedometer"] or 4]
      end

      if not wasInVeh and not UI:IsAnyOpenWithFocus() then
        wasInVeh = true
        SendNuiMessage(json.encode({
          action = "open",
          type = type,
        }))
      end
      local entity = DWB.PlayerData.Vehicle
      local speed = GetEntitySpeed(entity) * 3.6
      if type == "SpeedOG" then
        drawRct(0.133, 0.942, 0.046, 0.03, 0, 0, 0, 150)
        Text:Draw("~w~" .. math.ceil(speed) .. "~w~ km/h", {
          x = 0.135,
          y = 0.924,
          width = 1.0,
          height = 1.0,
          r = 255,
          g = 255,
          b = 255,
          a = 255,
        })
      else
        local rpm = GetVehicleCurrentRpm(entity) * 10000
        local gear = GetVehicleCurrentGear(entity)
        local maxFuel = GetVehicleHandlingFloat(entity, "CHandlingData", "fPetrolTankVolume")
        local fuel = Entity(entity).state.fuel or GetVehicleFuelLevel(entity)
        local percent = (fuel / maxFuel) * 100
        local retval, lightsOn, highbeamsOn = GetVehicleLightsState(entity)
        local lights = (highbeamsOn == 1 and "long" or lightsOn == 1 and "short") or "none"
        local ind = GetVehicleIndicatorLights(entity)
        local signal = {
          left = ind == 2 or ind == 3,
          right = ind == 1 or ind == 3,
        }

        if rpm > 11000 then
          rpm = 11000
        end
        local coords = DWB.PlayerData.Coords
        local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local road = {
          name = "hello",
          second = "",
        }

        local streetName = GetStreetNameFromHashKey(street)
        road.name = streetName

        if crossing then
          -- local crossingName = GetStreetNameFromHashKey(crossing)
          road.second = crossingName
        end

        SendNuiMessage(json.encode({
          action = "updateData",
          type = type,
          data = {
            speed = math.floor(speed),
            signal = signal,
            rpm = rpm,
            gear = gear,
            fuel = percent,
            gps = getName(GetEntityHeading(entity)),
            lights = lights,
            road = road,
            seatBelt = seatbelt,
            scale = DWB.UISettings["speed-scale"] or 100,
            time = string.format("%02d:%02d", GlobalState.hour, GlobalState.min),
            engine = GetVehicleEngineHealth(entity) > 100,
            doorLock = GetVehicleDoorLockStatus(entity) == 4,
            main = tonumber(DWB.UISettings["speedometer-main"]) or 0,
          },
        }))
      end
    elseif wasInVeh then
      wasInVeh = false
      SendNuiMessage(json.encode({
        action = "close",
        type = type,
      }))
      type = nil
    else
      Wait(1000)
    end
  end
end)

local lastSpeed
local vel
local started = false

local function startMe2()
  if started then
    return
  end
  started = true
  while not seatbelt and DWB.PlayerData.InVehicle do
    Wait(5000)
    -- PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    Notification:ShowCustom("warn", TR("belt"), TR("belt_put"), 5)
  end
  started = false
end

Thread:Create(function()
  local sleep = 0
  while true do
    if not seatbelt then
      local class = GetVehicleClass(DWB.PlayerData.Vehicle)
      if DWB.PlayerData.InVehicle and not Config.Seatbelt.Seatbelts[class] then
        startMe2()
        sleep = 0
        local veh = DWB.PlayerData.Vehicle
        local currentSpeed = GetEntitySpeed(veh)
        local vehVect = GetEntitySpeedVector(veh, true)
        if lastSpeed then
          local tresh = lastSpeed - currentSpeed
          local maxTresh = currentSpeed * 0.25

          if vehVect.y > 1.0 and currentSpeed > 19.25 and tresh > maxTresh then
            local coords = DWB.PlayerData.Coords
            local vec = GetEntityForwardVector(DWB.PlayerData.Ped)
            SetEntityCoords(DWB.PlayerData.Ped, coords + vec)
            SetPedToRagdoll(DWB.PlayerData.Ped, 1000, 1000, 0, 0, 0, 0)
            SetEntityVelocity(DWB.PlayerData.Ped, vel)
          end
        end
        lastSpeed = currentSpeed
        vel = GetEntityVelocity(veh)
      elseif seatbelt then
        seatbelt = false
      end
    else
      if not DWB.PlayerData.InVehicle then
        seatbelt = false
      end
      sleep = 500
    end
    Wait(sleep)
  end
end)

local function startMe()
  while seatbelt do
    Wait(0)
    DisableControlAction(0, 75, true) -- Disable exit vehicle when stop
    DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
  end
end

Key:onJustPressed("B", "Zapnij pasy", function()
  if DWB.PlayerData.InVehicle then
    local class = GetVehicleClass(DWB.PlayerData.Vehicle)
    if Config.Seatbelt.Seatbelts[class] then
      return
    end
    seatbelt = not seatbelt
    if seatbelt then
      Notification:ShowCustom("info", TR("belt"), TR("belt_on"))
      Event:TriggerNet("dwb:sounds:play:distance", 0.9, "buckle", 0.9)
      lastSpeed = nil
      vel = nil
      startMe()
    else
      Notification:ShowCustom("info", TR("belt"), TR("belt_off"))
      Event:TriggerNet("dwb:sounds:play:distance", 0.9, "unbuckle", 0.9)
      startMe2()
    end
  end
end)

Key:onJustPressed("F7", "Menu aut", function()
  if not DWB.PlayerData.InVehicle then
    return
  end
  local elements = {
    {
      label = "Otwórz/Zamknij",
      sub = {
        {
          label = "Przednie Drzwi",
          clientFn = "vehicle-rdoors",
        },

        {
          label = "Lewe Drzwi",
          clientFn = "vehicle-ldoors",
        },

        {
          label = "maske",
          clientFn = "vehicle-hood",
        },

        {
          label = "bagażnik",
          value = "trunk",
          clientFn = "vehicle-trunk",
        },
      },
    },

    {
      label = "Okna otwórz",
      sub = {
        {
          label = "Otwórz lewy przód",
          index = 0,
          clientFn = "vehicle-window-down",
        },
        {
          label = "Otwórz Prawy przód",
          index = 1,
          clientFn = "vehicle-window-down",
        },
        {
          label = "Otwórz Lewy tył",
          index = 2,
          clientFn = "vehicle-window-down",
        },

        {
          label = "Otwórz Prawy tył",
          index = 3,
          clientFn = "vehicle-window-down",
        },
      },
    },
    {
      label = "Okna Zamknij",
      sub = {
        {
          label = "Zamknij lewy przód",
          index = 0,
          clientFn = "vehicle-window-up",
        },
        {
          label = "Zamknij Prawy przód",
          index = 1,
          clientFn = "vehicle-window-up",
        },
        {
          label = "Zamknij Lewy tył",
          index = 2,
          clientFn = "vehicle-window-up",
        },

        {
          label = "Zamknij Prawy tył",
          index = 3,
          clientFn = "vehicle-window-up",
        },
      },
    },
  }

  local func = {
    ["vehicle-window-up"] = function(vehicle, data)
      RollUpWindow(vehicle --[[ Vehicle ]], data.current.index)
    end,
    ["vehicle-window-down"] = function(vehicle, data)
      RollDownWindow(vehicle --[[ Vehicle ]], data.current.index)
    end,
    ["vehicle-ldoors"] = function(vehicle)
      local isopen = GetVehicleDoorAngleRatio(vehicle, 2) and GetVehicleDoorAngleRatio(vehicle, 3)

      if isopen == 0 then
        SetVehicleDoorOpen(vehicle, 2, 0, 0)
        SetVehicleDoorOpen(vehicle, 3, 0, 0)
      else
        SetVehicleDoorShut(vehicle, 2, 0)
        SetVehicleDoorShut(vehicle, 3, 0)
      end
    end,
    ["vehicle-trunk"] = function(entity)
      local isopen = GetVehicleDoorAngleRatio(entity, 5)

      if isopen == 0 then
        SetVehicleDoorOpen(entity, 5, 0, 0)
      else
        SetVehicleDoorShut(entity, 5, 0)
      end
    end,
    ["vehicle-rdoors"] = function(vehicle)
      local isopen = GetVehicleDoorAngleRatio(vehicle, 0) and GetVehicleDoorAngleRatio(vehicle, 1)

      if isopen == 0 then
        SetVehicleDoorOpen(vehicle, 0, 0, 0)
        SetVehicleDoorOpen(vehicle, 1, 0, 0)
      else
        SetVehicleDoorShut(vehicle, 0, 0)
        SetVehicleDoorShut(vehicle, 1, 0)
      end
    end,
    ["vehicle-hood"] = function(vehicle)
      local isopen = GetVehicleDoorAngleRatio(vehicle, 4)
      if isopen == 0 then
        SetVehicleDoorOpen(vehicle, 4, 0, 0)
      else
        SetVehicleDoorShut(vehicle, 4, 0)
      end
    end,
  }
  UI:Open("Menu", {
    name = "veh",
    title = "Pojazd",
    align = "top-right",
    elements = elements,
  }, function(data, menu)
    if data.current.sub then
      UI:Open("Menu", {
        name = "veh2",
        title = "Pojazd",
        align = "top-right",
        elements = data.current.sub,
      }, function(data2, menu2)
        func[data2.current.clientFn](DWB.PlayerData.Vehicle, data2)
      end)
    end
  end)
end)
