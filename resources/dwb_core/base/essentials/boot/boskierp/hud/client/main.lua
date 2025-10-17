
Event:Register('dwb:player:loaded', function()
    if DWB.UISettings['hud-on'] then
        UI:Action('Hud', 'hud', 'open', {})
    end
end, true)

Event:Register('dwb:settings:changed', function(set)
    if set['hud-on'] then
        UI:Action('Hud', 'hud', 'open', {})
    else
        UI:Action('Hud', 'hud', 'close', {})
    end
end)
Thread:Create(function()

    while not DWB.PlayerData.char or not DWB.PlayerData.char.data or not DWB.PlayerData.Spawned do
        Wait(0)
    end

    while true do
        Wait(DWB.UISettings['hud-update'] or 1000)
        if DWB.UISettings['hud-on'] then
            -- -- local ped = PlayerPedId()
            local color =  DWB.UISettings['hud-color-icon']
            local bgColor =  DWB.UISettings['hud-color-bg']
            color = color and string.format("rgb(%s, %s, %s)", color.r, color.g, color.b)
            bgColor = bgColor and string.format("rgb(%s, %s, %s)", bgColor.r, bgColor.g, bgColor.b)
            local playerState = LocalPlayer.state
            local voice = 30
            if playerState and playerState.voice then
                if playerState.voice == 0 then
                    voice = voice * 2
                elseif playerState.voice == 1 then
                    voice = voice * 3
                end
            end
            UI:Action('Hud', 'hud', 'update', {
                show = true,
                heading = GetEntityHeading(DWB.PlayerData.Ped),
                compass = DWB.UISettings['hud-compass'],
                time = DWB.UISettings['hud-time'],
                clock = string.format("%02d:%02d", GlobalState.hour, GlobalState.min),
                hp = GetEntityHealth(DWB.PlayerData.Ped)-100,
                armor = GetPedArmour(DWB.PlayerData.Ped),
                water = playerState.water,
                food = playerState.hunger,
                stamina = GetPlayerStamina(DWB.PlayerData.Player),
                voice = voice or 30,
                opacity = DWB.UISettings['hud-opacity'] or 90,
                color = color or 'green',
                bgColor = bgColor or 'black',
                class = DWB.UISettings['hud-main'] or 0
            })
        end
    end
end)
