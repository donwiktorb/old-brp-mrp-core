Event:Register('dwb:sounds:play:client', function(file, volume, loop)
    if DWB.PlayerLoaded then
        SendNUIMessage({
            action     = 'playSound',
            file     = file,
            volume   = volume,
            loop = loop
        })
    end
end, true)

Event:Register('dwb:sounds:play:distance', function(coords, distance, file, volume, loop)
    if DWB.PlayerLoaded then
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dist  = #(pedCoords - coords)
        if(dist <= distance) then
            SendNUIMessage({
                action     = 'playSound',
                file     = file,
                volume   = volume,
                loop = loop
            })
        end
    end
end, true)

Event:Register('dwb:sounds:stop', function()
    SendNUIMessage({
        action     = 'stopSound'
    })
end, true)