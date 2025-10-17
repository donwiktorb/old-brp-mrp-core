


Event:Register('dwb:ambulance:revive', function(found, zoneData, posData, uiData)
    if found then
        BW:Stop(found.coords, found.heading)
    else
        BW:Stop()
        BW:Start(false, uiData)
    end
end, true)

Event:Register('dwb:ambulance:heal', function(d)
    BW:Heal(d)
end, true)

Event:Register('dwb:ambulance:use', function()
    local player, dist = User:GetClosest()
    if player then
        Event:TriggerNet('dwb:ambulance:revive:player', GetPlayerServerId(player))
    end
end, true)

Event:Register('dwb:ambulance:local', function(spawn, zoneData, posData)
    local ui = {
        msg = TR("wait_25"),
        time = posData.data.time or 30,
        title = TR("wait_252"),
        desc = msg,
        buttons = {},
        afterTimer = false
    }

    -- passiveMode(true)
    -- FreezeEntityPosition(PlayerPedId(), true)

    if not spawn then
        spawn = {}
    end

    BW:Start({
        lib = "combat@damage@writhe",
        anim = "writhe_loop",
        coords = spawn.coords, heading = spawn.heading ,
    }, ui, function()
        BW:Stop()
        -- passiveMode(false)


        -- FreezeEntityPosition(PlayerPedId(), false)
    end)
end, true)