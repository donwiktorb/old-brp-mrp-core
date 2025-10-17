local jobs = {}

Event:Register('dwb:jobs:loaded', function(source, xPlayer,jobs2)
    for k,v in pairs(jobs2) do
        if v.whitelisted == 0 then
            table.insert(jobs, v)
        end
    end
end)

Event:Register('dwb:player:loaded', function(source)
    local xPlayer = DWB.Players[source]
    -- -- xPlayer:SetJob('police', 1)
    -- Event:TriggerNet('dwb:jobs:loaded', source, jobs)
end)

Event:Register('dwb:jobs:chosen', function(source, xPlayer,name)
    xPlayer:SetJob(name, 1)
end, true)

Event:Register('dwb:jobs:leave', function(source, xPlayer,name)
    xPlayer:RemoveJob(name, 1)
end, true)

Event:RegisterCb('dwb:jobs:get', function(source, xPlayer,src, cb)
    local xPlayer = DWB.Players[src]
    cb(xPlayer.jobs)
end, true)

User:OnLoadedChar(function(self)

    if not self.char.data.duty then
        self.char.data.duty = {}
    end
end)