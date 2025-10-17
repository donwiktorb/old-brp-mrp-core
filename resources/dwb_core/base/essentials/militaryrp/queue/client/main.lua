Event:Register('dwb:player:loaded', function(xPlayer)
    Event:TriggerNet('dwb:queue:joined')
end, true)