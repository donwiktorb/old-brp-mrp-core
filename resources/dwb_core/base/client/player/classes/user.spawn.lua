function User:Respawn(coords, heading, cb)
  local ped = PlayerPedId()
  coords = coords or GetEntityCoords(ped)
  heading = heading or GetEntityHeading(ped)
  StopScreenEffect("DeathFailOut")
  NetworkResurrectLocalPlayer(coords, heading, true, false)
  SetPlayerInvincible(ped, false)
  SetEntityCoordsNoOffset(ped, coords, false, false, false, true)
  ClearPedBloodDamage(ped)
  if cb then
    cb()
  end
end
