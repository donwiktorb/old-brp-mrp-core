UI:newFocus('Teams', true)

Event:Register('dwb:player:loaded', function(xPlayer)
    local team = xPlayer.char.team
    if team then
        if not exports['dwb_api'].isLoaded() then
            SpawnPlayer(Teams.SpawnBase[team])
            exports['dwb_api'].loaded()
        -- else
        --     SpawnPlayer(GetEntityCoords(PlayerPedId()))
        end
    end
end, true)

Event:Register('dwb:team:spawn', function(team)
    if not IsEntityDead(PlayerPedId()) and team then
        SetEntityCoords(PlayerPedId(),Teams.SpawnBase[team])
    end
end, true)

Event:Register('dwb:team:choose', function(data)
    UI:Open('Teams', {
        name = 'teams',
        data = data
    }, function(data,menu)
        local team = data.current
        Event:TriggerNet('dwb:team:chosen', team)
        menu.close()
    end) 
end, true)

Event:Register('dwb:team:chosen', function(team, whitelist)
    if not exports['dwb_api'].isLoaded() then
        SpawnPlayer(Teams.SpawnBase[team])
    end
    if not whitelist then
        local ped = PlayerPedId()
        SetEntityCoords(ped, Teams.SpawnBase[team])
        Marker:Add('teams', {
            messages = {},
            marker = {
                type = 28,
                color = {
                    r = 20,
                    g = 222,
                    b = 222,
                    a = 222
                },
                animate = true
            },
            settings = {
                drawDist = 60,
                radius = 60,
                overrideCoords = true,
                drawMarker = true
            },
            coords = {
                {
                    pos = Teams.SpawnBase[team]
                }     
            },
            functions = {
                onExitCb = function(zone, pos)
                    local ped = PlayerPedId()
                    SetEntityCoords(ped, pos.pos)
                end
            }

        })
    else
        local player = PlayerId()
        local newt = team == 'USA' and 1 or team == 'RU' and 2 or 3
        SetPlayerTeam(player, newt)
        -- local playerPed = PlayerPedId()
        -- SetCanAttackFriendly(playerPed, true, false)
        -- NetworkSetFriendlyFireOption(true)
    end
end, true)

Event:Register('dwb:team:whitelisted', function()
    -- local playerPed = PlayerPedId()
    -- SetCanAttackFriendly(playerPed, true, false)
    -- NetworkSetFriendlyFireOption(true)
    Marker:Remove('teams')
end, true)