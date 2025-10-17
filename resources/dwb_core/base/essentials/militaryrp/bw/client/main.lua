local lib = 'random@peyote@generic'
local anim = 'wakeup'
local IsDead2 = false

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- function KillPed(ped, coords, heading)
-- 	NetworkResurrectLocalPlayer(coords, heading, true, false)
-- 	SetPlayerInvincible(ped, true)
-- end

function RespawnPed(ped, coords, heading)
	StopScreenEffect('DeathFailOut')
	NetworkResurrectLocalPlayer(coords, heading, true, false)
	SetPlayerInvincible(ped, false)
	SetEntityCoordsNoOffset(ped, coords, false, false, false, true)
    Event:Trigger('dwb:player:respawn', coords, heading)
	ClearPedBloodDamage(ped)
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end
-- RegisterCommand('kill', function(s,a,r)
--     SetEntityHealth(PlayerPedId(), 0)
-- end)
function StartDeathTimer()

	local earlySpawnTimer = Math:Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = Math:Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		while earlySpawnTimer > 0 and IsDead2 do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		while earlySpawnTimer > 0 and IsDead2 do
			Citizen.Wait(0)
			text = string.format('Odrodzenie w koszarach możliwe za ~b~%s minut/y %s sekund/y~s~', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while IsDead2 do
			Citizen.Wait(0)
            text = 'Przytrzymaj [~b~E~s~] aby odrodzić się w koszarach' 
            if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
                Event:TriggerNet('dwb:bw:spawn:me')
                break
            end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead2 then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['Y'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['N'], true)
			EnableControlAction(0, Keys['~'], true)
            EnableControlAction(0, 172, true)
			EnableControlAction(0, 166, true)
            EnableControlAction(0, 174, true)
            EnableControlAction(0, 175, true)
            EnableControlAction(0, 176, true)
            EnableControlAction(0, 177, true)
			EnableControlAction(0, 173, true)
            EnableControlAction(0, 27, true)
			EnableControlAction(0, 344, true)
			EnableControlAction(0, 20, true)
			EnableControlAction(0, 166, true)
		else
			Citizen.Wait(500)
		end
	end
end)

function OnPlayerDeath()
	IsDead2 = true

	StartDeathTimer()

	ClearPedTasksImmediately(PlayerPedId())
	StartScreenEffect('DeathFailOut', 0, false)
	while IsDead2 do
		ClearPedTasksImmediately(PlayerPedId())
		Citizen.Wait(60000)
	end
end

Event:Register('dwb:bw:revive2', function(coords, heading)
    local ped = PlayerPedId()
    if not coords then
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        RespawnPed(ped, coords, heading)
    else
        RespawnPed(ped, coords, heading)
    end
    IsDead2 = false
end, true)

Event:Register('dwb:bw:revive', function(coords, heading)
    local ped = PlayerPedId()
    if not coords then
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        RespawnPed(ped, coords, heading)
    else
        RespawnPed(ped, coords, heading)
    end
    Stream:RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 3.0, -1, 0, 1, false, false, false)
    end)
    IsDead2 = false
end, true)

Event:Register('dwb:player:died', function(data)
	OnPlayerDeath()
end, true)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)
--         local ped = PlayerPedId()
--         if isDead then
--             Stream:RequestAnimDict(lib, function()
--                 TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 3.0, -1, 1, 1, false, false, false)
--             end)
--         end
--     end

-- end)