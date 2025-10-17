
Command:Register('revive', {'revive'}, function(xPlayer, args)
    Event:TriggerNet('dwb:bw:revive', args[1])
end, {'superadmin', 'admin'})