function restoreLoadout()
  local ped = PlayerPedId()
  local ammoTypes = {}

  RemoveAllPedWeapons(ped, true)

  for k, v in pairs(DWB.PlayerData.loadout) do
    local name = v.name
    local hash = GetHashKey(name)
    local ammo = v.ammo

    GiveWeaponToPed(ped, hash, 0, false, false)

    for _, n in pairs(v.components) do
      local component = Weapon:GetComponent(name, n)
      if component then
        local componentHash = component.hash

        GiveWeaponComponentToPed(ped, hash, componentHash)
      end
    end

    local ammoType = GetPedAmmoTypeFromWeapon(ped, hash)

    if not ammoTypes[ammoType] then
      AddAmmoToPed(ped, hash, ammo)
      ammoTypes[ammoType] = true
    end
  end
end
function passiveMode(state)
  local playerPed = PlayerPedId()

  -- Citizen.Wait(Config.Default.passiveModeTime * 60000)
  SetCanAttackFriendly(playerPed, not state, false)
  NetworkSetFriendlyFireOption(not state)
end

