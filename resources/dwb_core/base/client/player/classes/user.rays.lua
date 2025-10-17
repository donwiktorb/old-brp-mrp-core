function User:GetInArea(coords, area)
  local players = GetActivePlayers()
  local playersInArea = {}

  for i = 1, #players, 1 do
    local target = GetPlayerPed(players[i])
    local targetCoords = GetEntityCoords(target)
    local distance = #(targetCoords - coords)

    if distance <= area then
      table.insert(playersInArea, players[i])
    end
  end

  return playersInArea
end

function User:GetPedInDirection(flag, coll)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)

  local rayHandle =
    StartShapeTestLosProbe(playerCoords, inDirection, flag or 4294967295, PlayerPedId(), coll or 4)

  local ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)

  while ret < 2 and ret ~= 0 do
    ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)
    Wait(0)
  end

  if ret and IsEntityAPed(entHit) then
    return ret, rayCat, endCoords, sNormal, entHit
  end
end

function User:GetInDirection(flag, coll)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)

  local rayHandle =
    StartShapeTestLosProbe(playerCoords, inDirection, flag or 4294967295, PlayerPedId(), coll or 4)

  local ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)

  while ret < 2 and ret ~= 0 do
    ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)
    Wait(0)
  end

  if ret and IsPedAPlayer(entHit) then
    return ret, rayCat, endCoords, sNormal, entHit, NetworkGetPlayerIndexFromPed(entHit)
  end
end

function User:GetClosest(coords)
  local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
  local coords, usePlayerPed = coords, false
  local playerPed, playerId = PlayerPedId(), PlayerId()

  if coords then
    coords = vector3(coords.x, coords.y, coords.z)
  else
    usePlayerPed = true
    coords = GetEntityCoords(playerPed)
  end

  for i = 1, #players, 1 do
    local target = GetPlayerPed(players[i])
    if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
      local targetCoords = GetEntityCoords(target)
      local distance = #(coords - targetCoords)

      if closestDistance == -1 or closestDistance > distance then
        closestPlayer = players[i]
        closestDistance = distance
      end
    end
  end

  return closestPlayer, closestDistance
end
