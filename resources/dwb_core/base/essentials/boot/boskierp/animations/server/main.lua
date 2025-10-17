
Event:Register('dwb:animations:ask', function(source, xPlayer,servId, coords, heading, offset, data, data2)
    local asker = source.." "..xPlayer.charId.." "..xPlayer.char.firstname.." "..xPlayer.char.lastname
    Event:TriggerNet('dwb:animations:ask', servId, source, coords, heading, asker, offset, data, data2)
end, true)

Event:Register('dwb:animations:accept', function(source, xPlayer,src, heading,coords, offset, data,data2)
    local heading2 = 360.0-(180.0-heading)
    local source = source
    Event:TriggerNet('dwb:animations:accept', source, src, heading2, false, offset, data)
    Event:TriggerNet('dwb:animations:accept', src, source, heading, coords, offset, data2 and data2 or data)
end, true)