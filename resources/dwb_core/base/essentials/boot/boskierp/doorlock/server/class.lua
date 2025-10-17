Doorlock = class()

function Doorlock:GetDoorsById(id)
    return Config.Doorlock.Doors[id]
end

function Doorlock:SyncDoors(doorId, doorPair, closed, pairClosed)
    Event:TriggerNet('dwb:doorlock:update', -1, {doorId, doorPair}, {closed, pairClosed})
end

function Doorlock:OpenDoorsBy(key, value)
    for k,v in pairs(Config.Doorlock.Doors) do
        if v[key] == value then
            v.closed = false
            if v.pair then
                Config.Doorlock.Doors[v.pair].closed = false
                self:SyncDoors(k, v.pair, false, false)
            else
                self:SyncDoors(k, nil, false)
            end
        end
    end
end

function Doorlock:CloseDoorsBy(key, value)
    for k,v in pairs(Config.Doorlock.Doors) do
        if v[key] == value then
            v.closed = true
            if v.pair then
                Config.Doorlock.Doors[v.pair].closed = true
                self:SyncDoors(k, v.pair, true, true)
            else
                self:SyncDoors(k, nil, true)
            end
        end
    end
end