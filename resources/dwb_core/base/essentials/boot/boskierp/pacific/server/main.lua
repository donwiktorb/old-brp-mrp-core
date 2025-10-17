Item:RegisterUsable('drill', function(source)
    local xPlayer = DWB.Players[source]
    if xPlayer.zoneData then
        local zoneData = xPlayer.zoneData
        local posData = xPlayer.posData
        if posData.action == 'open-gate-vault' then
            
        end
    end
end)