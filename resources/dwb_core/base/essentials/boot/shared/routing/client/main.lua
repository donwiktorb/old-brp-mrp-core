


NetworkConcealPlayer(PlayerId(), false)

local concealed = {}

Event:Register('dwb:routing:set', function(buckets, bucket)
    buckets[bucket] = nil
    for k, v in pairs(buckets) do
        for k, v in pairs(v.players) do
            local player = GetPlayerFromServerId(v)



            NetworkConcealPlayer(player, true)
            table.insert(concealed, player)
        end
    end
end    ,    true)

Event:Register('dwb:routing:leave', function()
    for k, v in pairs(concealed) do
        NetworkConcealPlayer(v, false)
    end
    concealed = {}
end    ,    true)


