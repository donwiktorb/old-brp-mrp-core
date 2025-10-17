Event:Register('dwb:bw:spawn:me', function()
    local xPlayer = DWB.Players[source]
    local team  = xPlayer:GetChar('team')
    Event:TriggerNet('dwb:bw:revive', source, Teams.SpawnBase[team], 200)
end, true)


Event:Register('dwb:player:died', function(data)
    Event:TriggerNet('dwb:player:died', source, data)
end, true)