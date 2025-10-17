Vehicle = class()

function Vehicle:IsAnyPedIn(veh)
  local exist = false

  for i = 1, 6, 1 do
    if GetPedInVehicleSeat(veh, i) ~= 0 then
      exist = true
    end
  end

  return exist
end

function Vehicle:GetAll()
  return EnumerateVehicles()
end

function Vehicle:GetAllInArea(coords, radius)
  local vehicles = {}
  local enum = Vehicle:GetAll()
  for vehicle in enum do
    if #(coords - GetEntityCoords(vehicle)) <= radius then
      table.insert(vehicles, vehicle)
    end
  end
  return vehicles
end

function Vehicle:IsSpawnPointClear(coords, radius)
  local vehicles = Vehicle:GetAllInArea(coords, radius)

  return #vehicles == 0
end

function Vehicle:SetProperties2(vehicle, props)
  SetVehicleModKit(vehicle, 0)

  if props.bodyHealth then
    SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
  end

  if props.engineHealth then
    SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
  end

  if props.fuelLevel then
    SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
  end

  if props.dirtLevel then
    SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
  end

  if props.plate then
    SetVehicleNumberPlateText(vehicle, props.plate)
  end

  if props.plateIndex then
    SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
  end

  if props.bodyHealth then
    SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
  end

  if props.engineHealth then
    SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
  end

  if props.fuelLevel then
    SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
  end

  if props.dirtLevel then
    SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
  end

  SetVehicleColours(vehicle, props.color1, props.color2)

  if props.extras then
    for i = 1, #props.extras do
      local enabled = props.extras[i]
      SetVehicleExtra(vehicle, i, enabled and 0 or 1)
    end
  end

  if props.mods then
    for i = 0, #props.mods do
      local value = props.mods[i + 1]
      SetVehicleMod(vehicle, i, value, false)
    end
  end

  SetVehicleLivery(vehicle, props.livery)
  SetVehicleRoofLivery(vehicle, props.liveryRoof)

  SetVehicleWheelType(vehicle, props.wheelType)
  SetVehicleWindowTint(vehicle, props.windowTint)

  if props.neons then
    for i = 0, #props.neons do
      SetVehicleNeonLightEnabled(vehicle, i, props.neons[i + 1])
    end
  end

  SetVehicleExtraColours(vehicle, props.pearlescentColor, props.wheelColorExtra)

  SetVehicleInteriorColor(vehicle, props.interiorColor)

  SetVehicleTyresCanBurst(vehicle, props.tyresCanBurst)

  ToggleVehicleMod(vehicle, 20, props.tyreSmoke)

  if props.tyreSmokeColor then
    SetVehicleTyreSmokeColor(
      vehicle,
      props.tyreSmokeColor.r,
      props.tyreSmokeColor.g,
      props.tyreSmokeColor.b
    )
  end

  SetVehicleDashboardColor(vehicle, props.dashboardColor)

  ToggleVehicleMod(vehicle --[[ Vehicle ]], 22 --[[ integer ]], props.hasXenon --[[ boolean ]])

  if props.xenonColor then
    SetVehicleXenonLightsCustomColor(
      vehicle,
      props.xenonColor.r,
      props.xenonColor.g,
      props.xenonColor.b
    )
  end

  SetVehicleXenonLightsColor(vehicle, props.xenonColorMod)

  if props.neonColor then
    SetVehicleNeonLightsColour(vehicle, props.neonColor.r, props.neonColor.g, props.neonColor.b)
  end

  SetVehicleModColor_1(vehicle, props.modPaintType, props.modColor, props.modPearlescentColor)

  SetVehicleModColor_2(vehicle, props.modPaintType2, props.modColor2)

  if props.customPrimaryColor then
    SetVehicleCustomPrimaryColour(
      vehicle,
      props.customPrimaryColor.r,
      props.customPrimaryColor.g,
      props.customPrimaryColor.b
    )
  end

  if props.secondaryCustomColor then
    SetVehicleCustomSecondaryColour(
      vehicle,
      props.secondaryCustomColor.r,
      props.secondaryCustomColor.g,
      props.secondaryCustomColor.b
    )
  end

  SetDriftTyresEnabled(vehicle, props.driftTyres)

  ToggleVehicleMod(vehicle, 17, props.nitro)
  ToggleVehicleMod(vehicle, 18, props.turbo)
  ToggleVehicleMod(vehicle, 19, props.subwoofer)
  ToggleVehicleMod(vehicle, 21, props.hydra)
end

function Vehicle:GetProperties2(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local extras = {}

  for id = 0, 40 do
    if DoesExtraExist(vehicle, id) then
      local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
      table.insert(extras, state)
    end
  end

  local mods = {}

  for i = 0, 150 do
    table.insert(mods, GetVehicleMod(vehicle, i))
  end

  local livery = GetVehicleLivery(vehicle)
  local liveryRoof = GetVehicleRoofLivery(vehicle)
  local modKit = GetVehicleModKit(vehicle)
  local wheelType = GetVehicleWheelType(vehicle)
  local plateIndex = GetVehicleNumberPlateTextIndex(vehicle)
  local windowTint = GetVehicleWindowTint(vehicle)
  local neons = {}

  for i = 0, 4 do
    table.insert(neons, IsVehicleNeonLightEnabled(vehicle, i))
  end

  local pearlescentColorExtra, --[[ integer ]]
    wheelColorExtra --[[ integer ]] =
    GetVehicleExtraColours(vehicle --[[ Vehicle ]])

  local interiorColor --[[ integer ]] = GetVehicleInteriorColor(vehicle --[[ Vehicle ]])

  local tyresCanBurst --[[ boolean ]] = GetVehicleTyresCanBurst(vehicle --[[ Vehicle ]])

  local r, --[[ integer ]]
    g, --[[ integer ]]
    b --[[ integer ]] =
    GetVehicleTyreSmokeColor(vehicle --[[ Vehicle ]])

  local tyreSmokeColor = {
    r = r,
    g = g,
    b = b,
  }

  local dashboardColor --[[ integer ]] = GetVehicleDashboardColor(vehicle --[[ Vehicle ]])

  local xenonColorMod = GetVehicleXenonLightsColor(vehicle)

  local r, --[[ integer ]]
    g, --[[ integer ]]
    b --[[ integer ]] =
    GetVehicleNeonLightsColour(vehicle --[[ Vehicle ]])

  local neonColor = {
    r = r,
    g = g,
    b = b,
  }

  local hasXenon, --[[ boolean ]]
    red, --[[ integer ]]
    green, --[[ integer ]]
    blue --[[ integer ]] =
    GetVehicleXenonLightsCustomColor(vehicle --[[ Vehicle ]])

  local xenonColor = {
    r = red,
    g = green,
    b = blue,
  }

  local modPaintType, --[[ integer ]]
    modColor, --[[ integer ]]
    modPearlescentColor --[[ integer ]] =
    GetVehicleModColor_1(vehicle --[[ Vehicle ]])

  local paintType2, --[[ integer ]]
    modColor2 --[[ integer ]] =
    GetVehicleModColor_2(vehicle --[[ Vehicle ]])

  local r, g, b = GetVehicleCustomPrimaryColour(vehicle)

  local primaryColor = {
    r = r,
    g = g,
    b = b,
  }

  local r, g, b = GetVehicleCustomSecondaryColour(vehicle)

  local secondaryColor = {
    r = r,
    g = g,
    b = b,
  }

  local driftTyres --[[ boolean ]] = GetDriftTyresEnabled(vehicle --[[ Vehicle ]])

  local tyreSmoke = IsToggleModOn(vehicle, 20) == 1

  local nitro = IsToggleModOn(vehicle, 17)
  local turbo = IsToggleModOn(vehicle, 18)
  local subwoofer = IsToggleModOn(vehicle, 19)
  local hydraulica = IsToggleModOn(vehicle, 21)

  return {
    model = GetEntityModel(vehicle),
    bodyHealth = Math:Round(GetVehicleBodyHealth(vehicle), 1),
    engineHealth = Math:Round(GetVehicleEngineHealth(vehicle), 1),
    fuelLevel = Math:Round(GetVehicleFuelLevel(vehicle), 1),
    dirtLevel = Math:Round(GetVehicleDirtLevel(vehicle), 1),
    class = GetVehicleClass(vehicle),
    plate = Math:Trim(GetVehicleNumberPlateText(vehicle)),
    color1 = color1,
    color2 = color2,
    extras = extras,
    mods = mods,
    livery = livery,
    liveryRoof = liveryRoof,
    modKit = modKit,
    wheelType = wheelType,
    plateIndex = plateIndex,
    windowTint = windowTint,
    neons = neons,
    pearlescentColorExtra = pearlescentColorExtra,
    wheelColorExtra = wheelColorExtra,
    interiorColor = interiorColor,
    tyresCanBurst = tyresCanBurst,
    tyreSmoke = tyreSmoke,
    tyreSmokeColor = tyreSmokeColor,
    dashboardColor = dashboardColor,
    xenonColorMod = xenonColorMod,
    neonColor = neonColor,
    hasXenon = hasXenon,
    xenonColor = xenonColor,
    modPaintType = modPaintType,
    modColor = modColor,
    modPearlescentColor = modPearlescentColor,
    modPaintType2 = paintType2,
    modColor2 = modColor2,
    customPrimaryColor = primaryColor,
    secondaryCustomColor = secondaryColor,
    drifTyres = driftTyres,
    nitro = nitro,
    turbo = turbo,
    subwoofer = subwoofer,
    hydraulica = hydraulica,

    bodyHealth = Math:Round(GetVehicleBodyHealth(vehicle), 1),
    engineHealth = Math:Round(GetVehicleEngineHealth(vehicle), 1),

    fuelLevel = Math:Round(GetVehicleFuelLevel(vehicle), 1),
    dirtLevel = Math:Round(GetVehicleDirtLevel(vehicle), 1),
  }
end

function Vehicle:GetClosest(coords)
  local closestVeh = -1
  local closestDist = -1
  local coords = coords or GetEntityCoords(PlayerPedId())
  local vehicles = Vehicle:GetAll()
  for vehicle in vehicles do
    local vehcoords = GetEntityCoords(vehicle)
    local distance = #(coords - vehcoords)
    if closestDist == -1 or distance < closestDist then
      closestVeh = vehicle
      closestDist = distance
    end
  end

  return closestVeh, closestDist
end

function Vehicle:GetClosest2(coords)
  local closestVeh = -1
  local closestDist = -1
  local coords = coords or GetEntityCoords(PlayerPedId())
  local vehicles = Vehicle:GetAll()
  local retval --[[ Vehicle ]] =
    GetVehiclePedIsIn(PlayerPedId() --[[ Ped ]], lastVehicle --[[ boolean ]])

  for vehicle in vehicles do
    if retval ~= vehicle then
      local vehcoords = GetEntityCoords(vehicle)
      local distance = #(coords - vehcoords)
      if closestDist == -1 or distance < closestDist then
        closestVeh = vehicle
        closestDist = distance
      end
    end
  end

  return closestVeh, closestDist
end

function Vehicle:GetClosestBy(coords, cb)
  local closestVeh = -1
  local closestDist = -1
  local coords = coords or GetEntityCoords(PlayerPedId())
  local vehicles = Vehicle:GetAll()
  local retval --[[ Vehicle ]] =
    GetVehiclePedIsIn(PlayerPedId() --[[ Ped ]], lastVehicle --[[ boolean ]])

  for vehicle in vehicles do
    if cb(vehicle) then
      local vehcoords = GetEntityCoords(vehicle)
      local distance = #(coords - vehcoords)
      if closestDist == -1 or distance < closestDist then
        closestVeh = vehicle
        closestDist = distance
      end
    end
  end

  return closestVeh, closestDist
end

function Vehicle:Spawn(modelName, coords, heading, cb)
  local model = (type(modelName) == "number" and modelName or GetHashKey(modelName))

  Thread:Create(function()
    Stream:RequestModel(model)

    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
    local id = NetworkGetNetworkIdFromEntity(vehicle)

    SetNetworkIdCanMigrate(id, true)
    SetEntityAsMissionEntity(vehicle, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(model)

    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    while not HasCollisionLoadedAroundEntity(vehicle) do
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      Citizen.Wait(0)
    end

    SetVehRadioStation(vehicle, "OFF")

    if cb then
      cb(vehicle)
    end
  end)
end

function Vehicle:Delete(vehicle)
  SetEntityAsMissionEntity(vehicle, false, true)
  DeleteVehicle(vehicle)
  if DoesEntityExist(vehicle) then
    NetworkRequestControlOfEntity(vehicle)
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
      Wait(100)
      timeout = timeout - 100
    end
    DeleteEntity(vehicle)
  end
end

function Vehicle:GetInDirection()
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
  local rayHandle = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
  local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

  while numRayHandle < 2 and numRayHandle ~= 0 do
    numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    Wait(0)
  end

  if hit == 1 and GetEntityType(entityHit) == 2 then
    return entityHit
  end

  return nil
end

function Vehicle:SpawnLocal(modelName, coords, heading, cb)
  local model = (type(modelName) == "number" and modelName or GetHashKey(modelName))

  Thread:Create(function()
    Stream:RequestModel(model)

    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false)

    SetEntityAsMissionEntity(vehicle, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(model)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    while not HasCollisionLoadedAroundEntity(vehicle) do
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      Citizen.Wait(0)
    end

    SetVehRadioStation(vehicle, "OFF")

    if cb then
      cb(vehicle)
    end
  end)
end
