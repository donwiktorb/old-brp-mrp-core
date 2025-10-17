function updatePlayers()
    local players = {} 
    
	for k,v in pairs(DWB.Players) do
        local player = v:GetJobByType('fraction')
        table.insert(players, {
            id = k,
            name = v.name,
            jobs = v.char and v.char.jobs or {},
            job = player and player.name or false,
            ping = GetPlayerPing(k)            
        })
    end
    
    return players
end

Event:RegisterCb('dwb:scoreboard:getPlayers', function(source, cb)
    cb(updatePlayers())
end)

Event:Register('dwb:scoreboard:updatePlayers', function(source, xPlayer)
    local players = updatePlayers()
    Player(source).state.scoreboard = true Event:TriggerNet('dwb:scoreboard:updatePlayers', source, players)
end, true)

Event:Register('dwb:scoreboard:close', function(source, xPlayer)
    Player(source).state.scoreboard = false
end, true)