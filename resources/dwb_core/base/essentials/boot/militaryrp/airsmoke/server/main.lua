Event:Register('dwb:airsmoke:start', function(front, fixed)
    Event:Trigger('dwb:sounds:play:distance', 20, 'smoke', 1)
    Event:TriggerNet('dwb:airsmoke:start', -1, front, fixed)
end, true)