Event:Register('dwb:smoke:start', function(front, fixed)
    Event:Trigger('dwb:sounds:play:distance', 20, 'smoke', 1)
    Event:TriggerNet('dwb:smoke:start', -1, front, fixed)
end, true)