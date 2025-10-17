local function FreezePlayer(id, freeze)
	local player = id
	-- SetPlayerControl(player, not freeze, false)

	local ped = PlayerPedId()

	if not freeze then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		if IsEntityVisible(ped) then
			SetEntityVisible(ped, false)
		end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

-- local function FreezePlayer(id, freeze)
--     local player = id
--     SetPlayerControl(player, not freeze, false)

--     local ped = GetPlayerPed(player)

--     if not freeze then
--         if not IsEntityVisible(ped) then
--             SetEntityVisible(ped, true)
--         end

--         if not IsPedInAnyVehicle(ped) then
--             SetEntityCollision(ped, true)
--         end

--         FreezeEntityPosition(ped, false)
--         SetPlayerInvincible(player, false)
--     else
--         if IsEntityVisible(ped) then
--             SetEntityVisible(ped, false)
--         end

--         SetEntityCollision(ped, false)
--         FreezeEntityPosition(ped, true)
--         SetPlayerInvincible(player, true)

--         if not IsPedFatallyInjured(ped) then
--             ClearPedTasksImmediately(ped)
--         end
--     end
-- end

function SpawnPlayer(coords, cb)
	Log:Info("[SPAWN]", "Starting spawn at coords", coords)
	local coords = {
		x = coords.x,
		y = coords.y,
		z = coords.z,
	}
	local ped = PlayerPedId()
	local player = PlayerId()

	-- DoScreenFadeOut(500)

	-- while IsScreenFadingOut() do
	--     Citizen.Wait(0)
	-- end

	-- FreezePlayer(player, true)

	SetEntityCollision(ped, false, true)

	FreezeEntityPosition(ped, true)

	RequestCollisionAtCoord(coords.x, coords.y, coords.z)

	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)

	local ret, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)

	if ret then
		coords.z = groundZ
	end

	while not HasCollisionLoadedAroundEntity(ped) do
		Log:Info("[SPAWN]", "Waiting for collisions")
		Wait(0)
	end

	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)

	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 200, true, true, false)

	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)
	ClearPlayerWantedLevel(player)

	-- ShutdownLoadingScreen()

	-- DoScreenFadeIn(500)

	-- while IsScreenFadingIn() do
	--     Citizen.Wait(0)
	-- end

	-- Citizen.Wait(4000)

	FreezeEntityPosition(ped, false)
	SetEntityCollision(ped, true, true)

	Log:Info("[SPAWN]", "Spawned")

	-- -- Event:Trigger('dwb:player:state:spawned')

	Log:Info("[SPAWN]", "Spawned")

	if cb then
		cb()
	end
end

-- function SpawnPlayer(coords, cb)
--     local ped = PlayerPedId()
--     local player = PlayerId()

--     DoScreenFadeOut(500)

--     while IsScreenFadingOut() do
--         Citizen.Wait(0)
--     end

--     FreezePlayer(player, true)

--     RequestCollisionAtCoord(coords.x, coords.y, coords.z)

--     SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)

--     NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 200, true, true, false)

--     ClearPedTasksImmediately(ped)
--     RemoveAllPedWeapons(ped)
--     ClearPlayerWantedLevel(player)

--     while not HasCollisionLoadedAroundEntity(ped) do
--         Citizen.Wait(0)
--     end

--     ShutdownLoadingScreen()

--     DoScreenFadeIn(500)

--     while IsScreenFadingIn() do
--         Citizen.Wait(0)
--     end

--     Citizen.Wait(4000)

--     FreezePlayer(player, false)

--     Event:Trigger('dwb:player:state:spawned')

--     if cb then
--         cb()
--     end
-- end

