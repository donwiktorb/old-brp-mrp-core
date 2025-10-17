local vehicleClasses = {
  [0] = "compacts", --compacts
  [1] = "sedans", --sedans
  [2] = "suvs", --SUV's
  [3] = "coupse", --coupes
  [4] = "muscle", --muscle
  [5] = "sport-classic", --sport GetVehicleClassic
  [6] = "sport", --sport
  [7] = "super", --super
  [8] = "motor", --motorcycle
  [9] = "offroad", --offroad
  [10] = "industrial", --industrial
  [11] = "utility", --utility
  [12] = "vans", --vans
  [13] = "bike", --bicycles
  [14] = "boat", --boats
  [15] = "heli", --helicopter
  [16] = "plane", --plane
  [17] = "service", --service
  [18] = "fraction", --emergency
  [19] = "miitary", --military
  [20] = "commercial",
}

Event:Register("dwb:skinchanger:load:default", function()
  DWB.PlayerData.Ped = PlayerPedId()
end)

Thread:Create(function()
  local startedShooting = false
  local setPed = false
  local setPlayer = false
  local loaded = false
  local setId = false

  DWB.PlayerData.Coords = vec3(0, 0, 0)
  DWB.PlayerData.IsVehicleType = function(...)
    local types = { ... }
    for k, v in pairs(types) do
      if v == vehicleClasses[DWB.PlayerData.VehicleType] then
        return v
      end
    end
  end

  while not DWB.PlayerLoaded or not DWB.PlayerData.Spawned do
    -- Log:Info("[PLAYER THREAD]", "Waiting for PlayerLoaded and Spawned")
    Wait(0)
  end

  if not setPed then
    DWB.PlayerData.Ped = PlayerPedId()
    setPed = true
  end

  if not setPlayer then
    DWB.PlayerData.Player = PlayerId()
    setPlayer = true
  end

  if not setId then
    DWB.PlayerData.PlayerId = GetPlayerServerId(DWB.PlayerData.Player)
    setId = true
  end

  local getEntityCoords = GetEntityCoords
  local isShooting = IsPedShooting
  local getCurrentWeapon = GetCurrentPedWeapon
  local getAmmo = GetAmmoInPedWeapon
  local getVehicleTryingEnter = GetVehiclePedIsTryingToEnter
  local isInVehicle = IsPedInAnyVehicle
  local getVehiclePedIsIn = GetVehiclePedIsIn
  local getVehicleType = GetVehicleClass
  local wasInVehicle = false
  local tried = false

  Log:Info("[PLAYER THREAD]", ped)

  Event:Trigger("dwb:player:thread:start")

  while true do
    Wait(0)
    DWB.PlayerData.TryingToEnterVehicle = getVehicleTryingEnter(DWB.PlayerData.Ped)

    if DWB.PlayerData.TryingToEnterVehicle ~= 0 and not tried then
      tried = true
      DWB.PlayerData.VehicleSeat = GetSeatPedIsTryingToEnter(DWB.PlayerData.Ped)
      Event:Trigger(
        "dwb:player:vehicle:entering",
        DWB.PlayerData.TryingToEnterVehicle,
        DWB.PlayerData.VehicleSeat
      )
    elseif DWB.PlayerData.TryingToEnterVehicle == 0 and tried then
      tried = false
    end

    DWB.PlayerData.InVehicle = isInVehicle(DWB.PlayerData.Ped)

    if DWB.PlayerData.InVehicle and not wasInVehicle then
      DWB.PlayerData.Vehicle = getVehiclePedIsIn(DWB.PlayerData.Ped)
      DWB.PlayerData.VehicleType = getVehicleType(DWB.PlayerData.Vehicle)
      Event:Trigger("dwb:player:vehicle:enter", DWB.PlayerData.Vehicle, DWB.PlayerData.VehicleSeat)
      wasInVehicle = true
    elseif wasInVehicle and not DWB.PlayerData.InVehicle then
      Event:Trigger("dwb:player:vehicle:exit", DWB.PlayerData.Vehicle)
      wasInVehicle = false
    end

    if DWB.PlayerData.InVehicle then
      DWB.PlayerData.IsDriver = GetPedInVehicleSeat(DWB.PlayerData.Vehicle, -1)
        == DWB.PlayerData.Ped
    end

    local ret, hash = getCurrentWeapon(DWB.PlayerData.Ped, true)

    DWB.PlayerData.HasWeapon = ret

    if ret then
      DWB.PlayerData.Weapon = hash
      DWB.PlayerData.Ammo = getAmmo(DWB.PlayerData.Ped, DWB.PlayerData.Weapon)
      DWB.PlayerData.IsShooting = isShooting(DWB.PlayerData.Ped)
    end

    DWB.PlayerData.Coords = getEntityCoords(DWB.PlayerData.Ped)
  end
end)

Thread:Create(function()
  while true do
    DWB.PlayerData.ClosestPlayers = {}

    local players = GetActivePlayers()

    local coords = DWB.PlayerData.Coords
    for i = 1, #players do
      local v = players[i]
      local ped = GetPlayerPed(v)
      local pCoords = GetEntityCoords(ped)
      local dist = #(coords - pCoords)
      if dist <= 15.0 then
        table.insert(DWB.PlayerData.ClosestPlayers, {
          player = v,
          serverId = GetPlayerServerId(v),
          ped = ped,
          dist = dist,
          state = Entity(ped).state,
        })
      end
    end

    Wait(1000)
  end
end)

Thread:Create(function()
  while true do
    DWB.PlayerData.ClosestVehicles = {}

    local vehicles = GetGamePool("CVehicle")
    local coords = DWB.PlayerData.Coords

    for i = 1, #vehicles do
      local v = vehicles[i]
      local pCoords = GetEntityCoords(v)
      local dist = #(coords - pCoords)
      if dist <= 15.0 then
        table.insert(DWB.PlayerData.ClosestVehicles, {
          vehicle = v,
          state = Entity(v).state,
          dist = dist,
        })
      end
    end

    Wait(1000)
  end
end)

Thread:Create(function()
  while true do
    DWB.PlayerData.ClosestObjects = {}

    local vehicles = GetGamePool("CObject")
    local coords = DWB.PlayerData.Coords

    for i = 1, #vehicles do
      local v = vehicles[i]
      local pCoords = GetEntityCoords(v)
      local dist = #(coords - pCoords)
      if dist <= 15.0 then
        table.insert(DWB.PlayerData.ClosestObjects, {
          obj = v,
          state = Entity(v).state,
          dist = dist,
          coords = pCoords,
        })
      end
    end

    Wait(1000)
  end
end)

Thread:Create(function()
  while true do
    DWB.PlayerData.ClosestPeds = {}

    local peds = GetGamePool("CPed")
    local coords = DWB.PlayerData.Coords

    for i = 1, #peds do
      local v = peds[i]
      if not IsPedAPlayer(v) then
        local pCoords = GetEntityCoords(v)
        local dist = #(coords - pCoords)
        if dist <= 15.0 then
          table.insert(DWB.PlayerData.ClosestPeds, {
            ped = v,
            state = Entity(v).state,
            dist = dist,
            coords = pCoords,
          })
        end
      end
    end

    Wait(1000)
  end
end)

