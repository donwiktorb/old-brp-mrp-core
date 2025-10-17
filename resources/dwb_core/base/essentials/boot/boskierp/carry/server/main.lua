local carryingBackInProgress = {}

RegisterServerEvent('dwb_carry:sync')
AddEventHandler('dwb_carry:sync', function(target)
	if not 	carryingBackInProgress[source] then
		carryingBackInProgress[source] = target
		TriggerClientEvent('dwb_carry:syncTarget', target, source)
		TriggerClientEvent('dwb_carry:syncMe', source)
	end
end)

RegisterServerEvent('dwb_carry:stop')
AddEventHandler('dwb_carry:stop', function(targetSrc)

	if targetSrc == nil then
		return
	end
	carryingBackInProgress[source] = nil
    if targetSrc then
		TriggerClientEvent('dwb_carry:cl_stop', targetSrc)
    end
end)

Event:Register('dwb:player:dropped', function(source, xPlayer, reason)
	local _source = source
	if  carryingBackInProgress[source] ~= nil then
		carryingBackInProgress[source] = nil
	end
end)

