local holstered = true

local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_STUNGUN",	
	"WEAPON_NIGHTSTICK",
	"WEAPON_FLASHLIGHT",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_FLARE",
	"WEAPON_SNSPISTOl",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_FLARE",
	"WEAPON_FLARE",
	"WEAPON_FLARE",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_MACHINEPISTOL",	
			
}

local dict = "reaction@intimidation@1h"
local anim = "intro"
local anim2 = "outro"

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local ped = PlayerPedId()
-- 		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not   IsPedInAnyVehicle(ped, true) then
-- 			if CheckWeapon(ped) then
--                 Stream:RequestAnimDict(dict, function()
--                     if holstered then
--                         TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
--                         DisablePlayerFiring(ped, true)
--                         Citizen.Wait(2500)
--                         DisablePlayerFiring(ped, false)
--                         ClearPedTasks(ped)
--                         Citizen.Wait(100)					
--                         holstered = false
--                     end
--                 end)
-- 			elseif not CheckWeapon(ped) then
--                 Stream:RequestAnimDict(dict, function()
--                     if not holstered then
--                         TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
--                         DisablePlayerFiring(ped, true)
--                         Citizen.Wait(2500)
--                         DisablePlayerFiring(ped, false)
--                         ClearPedTasks(ped)
--                         Citizen.Wait(100)					
--                         holstered = true
--                     end
--                 end)
-- 			end
-- 		end
-- 	end
-- end)


function CheckWeapon(ped)
    local weap = GetSelectedPedWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == weap then
			return true
		end
	end
	return false
end