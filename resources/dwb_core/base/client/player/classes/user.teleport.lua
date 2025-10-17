function User:Teleport(data)
  while not DWB.PlayerData.Spawned do
    Wait(0)
  end
  while IsPlayerTeleportActive() do
    Wait(0)
  end

  while IsScreenFadedOut() do
    Wait(0)
  end

  DoScreenFadeOut(1000)

  while not IsScreenFadedOut() do
    Wait(0)
  end

  StartPlayerTeleport(PlayerId(), data.coords, data.heading, true, true, true)

  while IsPlayerTeleportActive() do
    Wait(0)
  end

  DoScreenFadeIn(500)
end
