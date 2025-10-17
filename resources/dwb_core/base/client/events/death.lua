function PlayerKilledByPlayer(killerServerId, killerClientId, killerWeapon)
  local victimCoords = GetEntityCoords(PlayerPedId())
  local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
  local distance = GetDistanceBetweenCoords(victimCoords, killerCoords, true)

  local dCause = GetPedCauseOfDeath(PlayerPedId())

  local data = {
    victimCoords = {
      x = Math:Round(victimCoords.x, 1),
      y = Math:Round(victimCoords.y, 1),
      z = Math:Round(victimCoords.z, 1),
    },
    killerCoords = {
      x = Math:Round(killerCoords.x, 1),
      y = Math:Round(killerCoords.y, 1),
      z = Math:Round(killerCoords.z, 1),
    },

    killedByPlayer = true,
    deathCause = dCause,
    killerWeapon = killerWeapon,
    distance = Math:Round(distance, 1),

    killerServerId = killerServerId,
    killerClientId = killerClientId,
  }

  Event:TriggerNet("dwb:player:died", data)
end

function PlayerKilled()
  local playerPed = PlayerPedId()
  local victimCoords = GetEntityCoords(PlayerPedId())

  local data = {
    victimCoords = {
      x = Math:Round(victimCoords.x, 1),
      y = Math:Round(victimCoords.y, 1),
      z = Math:Round(victimCoords.z, 1),
    },

    killedByPlayer = false,
    deathCause = GetPedCauseOfDeath(playerPed),
  }

  Event:TriggerNet("dwb:player:died", data)
end
-- -- Thread:Create(function()
-- --     local isDead = false
-- --     -- local lib = "amb@world_human_bum_slumped@male@laying_on_left_side@base"
-- --     -- local anim = "base"

-- --     local lib = "combat@damage@writhe"
-- --     local anim = "writhe_loop"

-- --     local lib2 = "random@crash_rescue@car_death@low_car"
-- --     local anim2 = "loop"
-- --     DWB.PlayerData.IsDead = false
-- --     DWB.PlayerData.IsDead2 = false
-- -- 	while true do
-- -- 		Citizen.Wait(500)

-- --         local playerPed = PlayerPedId()

-- --         if not isDead and IsPedFatallyInjured(playerPed) then
-- -- 		    local player = PlayerId()
-- --             isDead = true
-- --             DWB.PlayerData.IsDead = true

-- --             local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
-- --             local killerServerId = NetworkGetPlayerIndexFromPed(killer)

-- --             if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
-- --                 PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
-- --             else
-- --                 PlayerKilled()
-- --             end

-- --             local retval --[[ Vehicle ]] = GetVehiclePedIsIn( playerPed --[[ Ped ]], lastVehicle --[[ boolean ]])

-- --             NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)

-- --             SetPlayerInvincible(player, true)

-- --             ClearPedTasksImmediately(playerPed)

-- --             DWB.PlayerData.IsDead2 = true

-- --             if retval ~= 0 then
-- --                 local seat = 0
-- --                 for i=-1,5 do
-- --                     if GetLastPedInVehicleSeat(retval, i) == PlayerPedId() then
-- --                         seat = i
-- --                         break
-- --                     end
-- --                 end

-- --                 SetPedIntoVehicle(playerPed, retval, seat)

-- --                 Stream:RequestAnimDict(lib2, function()
-- --                     TaskPlayAnim(playerPed, lib2, anim2, 8.0, 3.0, -1, 1, 1, false, false, false)
-- --                 end)
-- --             else

-- --                 while IsPedRagdoll(playerPed) do
-- --                     Wait(0)
-- --                 end
-- --                 Stream:RequestAnimDict(lib, function()
-- --                     TaskPlayAnim(playerPed, lib, anim, 8.0, 3.0, -1, 1, 1, false, false, false)
-- --                 end)
-- --                 Thread:Create(function()
-- --                     while DWB.PlayerData.IsDead2 do
-- --                         Wait(50)
-- --                         Stream:RequestAnimDict(lib, function()
-- --                             TaskPlayAnim(playerPed, lib, anim, 8.0, 3.0, -1, 1, 1, false, false, false)
-- --                         end)
-- --                     end
-- --                 end)
-- --             end

-- --             -- SetPedToRagdoll(playerPed, -1, -1, 0, 0, 0, 0)

-- --         elseif isDead and not IsPedFatallyInjured(playerPed) then
-- -- 		    local player = PlayerId()
-- --             DWB.PlayerData.IsDead = false
-- --             isDead = false
-- --             SetPlayerInvincible(player, false)
-- --         end
-- -- 	end
-- -- end)

--AddEventHandler("CEventDataResponsePlayerDeath", function(ents, ent, data)
--  Log:Info(json.encode(ents), ent, json.encode(data))
--end)
--
--AddEventHandler("CEventDeath", function(ents, ent, data)
--  Log:Info(json.encode(ents), ent, json.encode(data))
--end)
--
--AddEventHandler("CEventPlayerDeath", function(ents, ent, data)
--  Log:Info(json.encode(ents), ent, json.encode(data))
--end)

-- -- AddEventHandler('CEventAcquaintancePedDead', function(ents, ent, data)
-- --     Log:Info(json.encode(ents), ent, json.encode(data))
-- -- end)

-- AddEventHandler('gameEventTriggered', function(name, data)
--     Log:Info(name, json.encode(data))
--     -- -- SetEntityHealth(PlayerPedId(), 200)
--     -- -- CancelEvent()
-- end)

-- -- AddEventHandler('CEventNetworkEntityDamage', function(entityDamage, entityDamager, )
-- --     -- Log:Info(name, json.encode(data))
-- --     -- -- SetEntityHealth(PlayerPedId(), 200)
-- --     -- -- CancelEvent()
-- -- end)

-- -- AddEventHandler('entityDamaged', function(ped, cp, weap, dmg)
-- --     Log:Info("entityDmg",ped, cp, weap, dmg, GetEntityHealth(ped), PlayerPedId())
-- --     if ped == PlayerPedId() then
-- --         SetEntityHealth(PlayerPedId(), 200)
-- --         CancelEvent()
-- --     end
-- -- end)
--
Thread:Create(function()
  local isDead = false

  while true do
    Citizen.Wait(0)

    local player = PlayerId()
    if DWB.PlayerData.Loaded then -- NetworkIsPlayerActive
      local playerPed = PlayerPedId()

      if IsPedFatallyInjured(playerPed) and not isDead then
        isDead = true

        local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
        local killerServerId = NetworkGetPlayerIndexFromPed(killer)

        if
          killer ~= playerPed
          and killerServerId ~= nil
          and NetworkIsPlayerActive(killerServerId)
        then
          PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
        else
          PlayerKilled()
        end
      elseif isDead and not IsPedFatallyInjured(playerPed) then
        isDead = false
      end
    end
  end
end)

-- Thread:Create(function()
--     local isDead = false

-- 	while true do
-- 		Citizen.Wait(0)

-- 		local player = PlayerId()
-- 		if NetworkIsPlayerActive(player) then
-- 			local playerPed = PlayerPedId()

-- 			if IsPedFatallyInjured(playerPed) and not isDead then
-- 				isDead = true

-- 				local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
-- 				local killerServerId = NetworkGetPlayerIndexFromPed(killer)

-- 				if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
-- 					PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
-- 				else
-- 					PlayerKilled()
-- 				end

-- 			elseif isDead and not IsPedFatallyInjured(playerPed) then
-- 				isDead = false
-- 			end
-- 		end
-- 	end
-- end)

--Thread:Create(function()
--    while not DWB.PlayerData.char or not DWB.PlayerData.char.data do
--        Wait(0)
--    end
--	while true do
--		Citizen.Wait(0)
--
--        -- local playerPed = PlayerPedId()
--        -- local player = PlayerId()
--
--        local playerPed = DWB.PlayerData.Ped
--        local player = DWB.PlayerData.Player
--        -- if NetworkIsPlayerActive(player) and  not DWB.PlayerData.char.data.IsDead and IsPedFatallyInjured(playerPed) then
--        if not DWB.PlayerData.char.data.IsDead and IsPedFatallyInjured(playerPed) then
--            DWB.PlayerData.WasDead = true
--            DWB.PlayerData.char.data.IsDead = true
--            local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
--            local killerServerId = NetworkGetPlayerIndexFromPed(killer)
--
--            if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
--                PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
--            else
--                PlayerKilled()
--            end
--
--            -- -- local retval --[[ Vehicle ]] = GetVehiclePedIsIn( playerPed --[[ Ped ]], lastVehicle --[[ boolean ]])
--
--
--            -- -- NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)
--
--            -- -- SetPlayerInvincible(player, true)
--
--            -- -- ClearPedTasksImmediately(playerPed)
--
--
--            -- -- if retval ~= 0 then
--            -- --     local seat = 0
--            -- --     for i=-1,5 do
--            -- --         if GetLastPedInVehicleSeat(retval, i) == PlayerPedId() then
--            -- --             seat = i
--            -- --             break
--            -- --         end
--            -- --     end
--
--            -- --     SetPedIntoVehicle(playerPed, retval, seat)
--
--            -- --     Stream:RequestAnimDict(lib2, function()
--            -- --         TaskPlayAnim(playerPed, lib2, anim2, 8.0, 3.0, -1, 1, 1, false, false, false)
--            -- --     end)
--            -- -- else
--            -- --     while IsPedRagdoll(playerPed) do
--            -- --         Wait(0)
--            -- --     end
--            -- --     Stream:RequestAnimDict(lib, function()
--            -- --         TaskPlayAnim(playerPed, lib, anim, 8.0, 3.0, -1, 1, 1, false, false, false)
--            -- --     end)
--            -- --     Thread:Create(function()
--            -- --         while DWB.PlayerData.IsDead2 do
--            -- --             Wait(50)
--            -- --             Stream:RequestAnimDict(lib, function()
--            -- --                 TaskPlayAnim(playerPed, lib, anim, 8.0, 3.0, -1, 1, 1, false, false, false)
--            -- --             end)
--            -- --         end
--            -- --     end)
--            -- -- end
--        end
--	end
--end)
