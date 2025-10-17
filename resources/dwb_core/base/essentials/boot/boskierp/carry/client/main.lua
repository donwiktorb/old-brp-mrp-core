local carryingBackInProgress = false

local Data = {
    lib = 'missfinale_c2mcs_1',
    anim = 'fin_c2_mcs_1_camman',
    lib2 = 'nm',
    anim2 = 'firemans_carry',
    distans = 0.15,
    distans2 = 0.27,
    height = 0.63,
    spin = 0.0,
    length = 100000,
    controlFlagMe = 49,
    controlFlagTarget = 33,
    animFlagTarget = 1
}

RegisterCommand("podnies",function(source, args)
    local ped = PlayerPedId()
	if not carryingBackInProgress then
		carryingBackInProgress = true
		
		local closestPlayer, closestPlayerDist = User:GetClosest()
		if closestPlayer ~= nil and closestPlayerDist <= 2 then
			TriggerServerEvent('dwb_carry:sync', GetPlayerServerId(closestPlayer))
			FreezeEntityPosition(closestPlayer, false)
            SetPedCanSwitchWeapon(GetPlayerPed(closestPlayer), true)
		end
	else
		carryingBackInProgress = false
		ClearPedSecondaryTask(ped)
		DetachEntity(ped, true, false)
        local closestPlayer, closestPlayerDist = User:GetClosest()
        
		if closestPlayer ~= nil and closestPlayerDist <= 2 then
            SetPedCanSwitchWeapon(GetPlayerPed(closestPlayer), false)
			TriggerServerEvent("dwb_carry:stop", GetPlayerServerId(closestPlayer))
		end
	end
end,false)

RegisterNetEvent('dwb_carry:syncTarget')
AddEventHandler('dwb_carry:syncTarget', function(target)
	local ped = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(Data.lib2)

	while not HasAnimDictLoaded(Data.lib2) do
		Citizen.Wait(10)
	end
    
	if Data.spin == nil then Data.spin = 180.0 end

	AttachEntityToEntity(ped, targetPed, 0, Data.distans2, Data.distans2, Data.height, 0.5, 0.5, Data.spin, false, false, false, false, 2, false)

	if Data.controlFlagTarget == nil then Data.controlFlagTarget = 0 end

	TaskPlayAnim(ped, Data.lib2, Data.anim2, 8.0, -8.0, Data.length, Data.controlFlagTarget, 0, false, false, false)
end)

RegisterNetEvent('dwb_carry:syncMe')
AddEventHandler('dwb_carry:syncMe', function()
	local playerPed = PlayerPedId()
	RequestAnimDict(Data.lib)

	while not HasAnimDictLoaded(Data.lib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if Data.controlFlagMe == nil then Data.controlFlagMe = 0 end
	TaskPlayAnim(playerPed, Data.lib, Data.anim, 8.0, -8.0, Data.length, Data.controlFlagMe, 0, false, false, false)

	Citizen.Wait(Data.length)
end)

RegisterNetEvent('dwb_carry:cl_stop')
AddEventHandler('dwb_carry:cl_stop', function()
    local ped = PlayerPedId()
	carryingBackInProgress = false
	ClearPedSecondaryTask(ped)
	DetachEntity(ped, true, false)
end)
