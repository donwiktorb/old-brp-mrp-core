


Routing = class()
Routing.Buckets = {}

function Routing:Set(src, bucket)
    if bucket <= 0 then
        return self:Leave(src)
    end

    if not self.Buckets[bucket] then
        
      
        self.Buckets[bucket] = {
            host = src,
            players = {}
        }
    end
    table.insert(self.Buckets[bucket].players, src)
    for k,v in pairs(self.Buckets) do
        for key, value in pairs(v.players) do
            Event:TriggerNet('dwb:routing:set', value, self.Buckets, k)
        end
    end
end

function Routing:Leave(src)
    Event:TriggerNet('dwb:routing:leave', src)
end