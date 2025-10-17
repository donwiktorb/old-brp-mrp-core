
AddEventHandler('playerConnecting', function(name, kick, def, hand, update)
    Event:Trigger('dwb:player:connecting', source, name, kick, def, hand, update)
end)

AddEventHandler('playerJoining', function(oldsource)
    Event:Trigger('dwb:player:joining', source, oldsource)
end)

AddEventHandler('playerDropped', function(reason)
	local xPlayer = DWB.Players[source]


    print(source, xPlayer, reason)
	Event:Trigger('dwb:player:dropped', source, xPlayer, reason)
end)
-- -- RegisterCommand('quit2', function(source)
-- -- 	local xPlayer = DWB.Players[source]
-- -- 	Event:Trigger('dwb:player:dropped', source, xPlayer, reason)
-- -- end)