local firstSpawn, isPaused, isPlayerSpawned, isDead = true, false, false, false

-- -- Thread:Create(function()
-- --     while not DWB.PlayerLoaded do
-- --         Wait(0)
-- --         -- Log:Info("[Inventory Sync]", "Waiting for player load")
-- --     end

-- -- 	while true do
-- -- 		Citizen.Wait(5000)
-- --         local ped = DWB.PlayerData.Ped

-- --         local changed = false

-- --         for k,v in pairs(DWB.PlayerData.inventory) do
-- --             if v.type == 'weapon' then
-- --                 local hash = GetHashKey(v.name)
-- --                 local ammo = GetAmmoInPedWeapon(ped, hash)
-- --                 if ammo ~= v.ammo then
-- --                     v.ammo = ammo
-- --                     changed = true
-- --                 end
-- --             end

-- --         end

-- --         if changed then
-- --             Event:TriggerNet('dwb:player:update', {inventory = inventory})
-- --         end
-- -- 	end
-- -- end)
Event:Register("dwb:player:state:spawned", function()
	while not DWB.PlayerLoaded do
		-- Log:Info("[State Spawned]", "Waiting for load" )
		Citizen.Wait(0)
	end

	local playerPed = PlayerPedId()

	isPlayerSpawned, isDead = true, false

	if firstSpawn then
		firstSpawn = false
		Event:Trigger("dwb:player:state:firstSpawn")

		if Config.Motd then
			Event:Trigger("dwb:chat:addMessage", {
				template = Config.Motd,
			})
		end
	end
end)

