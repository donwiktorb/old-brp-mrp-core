
Event:Register('dwb:tick:minute', function()
    local count = 0
    for k,v in pairs(DWB.Players) do
        count = count + 1
    end
    Event:TriggerNet('dwb:dstat:update', -1, count)
end)