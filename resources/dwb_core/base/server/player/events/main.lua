Event:Register('dwb:player:joined', function(source, xPlayer)
    local _source = source
    -- InitPlayerLoad(source)
    SetPlayerRoutingBucket(_source, 0)
    RemoveAllPedWeapons(GetPlayerPed(_source), true)
    local identifiers = GetPlayerIdentifiers(source)
    for k,v in pairs(identifiers) do
        if string.find(v, 'ip:') then
            table.remove(identifiers, k)
        end
    end
    DWB.Players[source] = User({
        source = source,
        identifier = GetPlayerIdentifierByType(source, 'steam'),
        identifiers = identifiers,
        name = GetPlayerName(source)
    })

    local xPlayer = DWB.Players[source]

    if not xPlayer then
        DropPlayer(source, 'Error loading player')
        return
    end
   
    xPlayer:Load(false, function()
        xPlayer:Loaded()
        Event:TriggerNet('dwb:player:loaded', _source, xPlayer)
        Event:Trigger('dwb:player:loaded', _source, xPlayer)
    end)
end, true)

-- Event:Register('dwb:player:joining', function(source)
--     -- DWB.Players[source] = User({
--     --     source = source,
--     --     identifier = GetPlayerIdentifierByType(source, 'steam'),
--     --     identifiers = GetPlayerIdentifiers(source),
--     --     name = GetPlayerName(source)
--     -- })
-- end)

Event:Register('dwb:player:dropped', function(source, xPlayer, reason)
    if xPlayer then
        xPlayer:Unload(function()
            DWB.Players[source] = nil
        end)
    end
    -- -- -- -- local _xPlayer = DWB.Players[source]
    -- -- -- -- if _xPlayer then
    -- -- -- --     _xPlayer:Unload(function()
    -- -- -- --         DWB.Players[source] = nil
    -- -- -- --     end)    
    -- -- -- -- end
end)