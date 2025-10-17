
function countTeams()
    local teams = {}
    for k,v in pairs(DWB.Players) do
        local team = v:GetChar('team')
        if team then
            if not teams[team] then teams[team] = 0
            else teams[team] = teams[team] + 1
            end
        end
    end
    return teams
end

Event:Register('dwb:player:loaded', function(source, xPlayer)
    local team = xPlayer:GetChar('team')
    local whitelist = xPlayer:GetChar('whitelist')
    if not team then
        local teams = {}
        local count = countTeams()
        for k,v in pairs(count) do
            table.insert(teams, {
                team = k,
                players = v
            })
        end
        Event:TriggerNet('dwb:team:choose', source, teams)
    elseif not xPlayer:GetChar('whitelist') then
        if not xPlayer:HasJob(string.lower(team)) then
            xPlayer:AddJob(string.lower(team), 1)
        end
        Event:TriggerNet('dwb:team:chosen', source, team)
    elseif team and whitelist then 
        if not xPlayer:HasJob(string.lower(team)) then
            xPlayer:AddJob(string.lower(team), 1)
        end
        Event:TriggerNet('dwb:team:chosen', source, team, true)
    end
end)

Event:Register('dwb:team:chosen', function(team)
    local xPlayer = DWB.Players[source]
    xPlayer:SetChar('team', team)
    Event:TriggerNet('dwb:team:chosen', source, team)
end, true)

Command:Register('spawn', {'Teleport na spawn'}, function(xPlayer)
   Event:TriggerNet('dwb:team:spawn', xPlayer.source, xPlayer:GetChar('team')) 
end)