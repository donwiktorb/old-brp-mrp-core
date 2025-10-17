if true then
  return
end
player_type = "no_cheat"
msg_type = "train"

Thread:Create(function()
  local lastGame = GetGameTimer()
  local lastRot = vec3(0, 0, 0)
  while true do
    Wait(10)
    local playerPed = PlayerPedId()
    local isAiming = IsPlayerFreeAiming(PlayerId())

    local targetEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())

    local currentRot = GetGameplayCamRot(0) -- Camera rotation as aim direction
    local currentGame = GetGameTimer()
    local d = #(lastRot - currentRot)
    local dGame = lastGame - currentGame
    if isAiming then
      if targetEntity and GetEntitySpeed(targetEntity) > 0 then
        print(d, lastRot, currentRot)
      end
      lastRot = currentRot
      lastGame = currentGame
    end
  end
end)

Thread:Create(function()
  while true do
    Wait(1000)
    local entity = DWB.PlayerData.Ped
    local entitySpeed = GetEntitySpeed(entity)
    local inVehicle = DWB.PlayerData.InVehicle
    local velocity = GetEntityVelocity(entity)

    local heightAboveGround = GetEntityHeightAboveGround(entity)
    local isInAir = IsEntityInAir(entity)
    local isRagdolling = IsPedRagdoll(ped)

    local isEntityFrozen = IsEntityPositionFrozen(entity)

    local isInWater--[[ boolean ]] = IsEntityInWater(entity --[[ Entity ]])
    local entityType = 55
    if DWB.PlayerData.InVehicle then
      entityType --[[ integer ]] = GetVehicleTypeRaw(DWB.PlayerData.Vehicle--[[ Vehicle ]])
    end
    local request_data = {
      player_type = player_type,
      msg_type = msg_type,
      data = {
        heightAboveGround,
        entitySpeed,
        isInWater,
        isRagdolling,
        inVehicle and 4 or 3,
        isEntityFrozen,
        isInAir,
        entityType,
      },
      player_id = 4444,
      type = "noclip",
    }

    Text:Draw(
      ("%s\n%s\n%s\n%s\n%s\n%s"):format(
        entity,
        entitySpeed,
        inVehicle,
        velocity,
        heightAboveGround,
        isinAir
      ),
      {}
    )

    --Event:TriggerNet("dwb:ac:data", request_data)
  end
end)
