function User:PlayAnim(lib, anim, data)
    Event:TriggerNet('dwb:animations:play', self.source, lib, anim, data or {})
end
function User:PlayTask(lib, anim, data)
    Event:TriggerNet('dwb:animations:play:task', self.source, lib, anim, data or {})
end

function User:ClearTask(lib, anim, data)
    ClearPedTasks(GetPlayerPed(self.source))
end




local animId = 0

function getAnimId()
    if animId > 99 then
        animId = 0
    else
        animId = animId + 4
    end
    return animId
end

local AnimCbs = {}

function User:IsPlayingAnim(lib,anim, cb)
    local id = getAnimId()
    AnimCbs[id] = cb
    Event:TriggerNet('dwb:animations:is:playing', self.source, lib, anim, id)
end

Event:Register('dwb:animations:is:playing', function(id, d)
    AnimCbs[id](d)
    AnimCbs[id] = nil
end, true)