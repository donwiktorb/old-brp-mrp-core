Sound = class()

function Sound:Play(name, volume, loop)
    while not DWB.PlayerLoaded or not DWB.LoadedUI do
        Wait(0)
    end
    SendNUIMessage({
        action     = 'playSound',
        file     = name,
        volume   = DWB.UISettings['volume'] or volume,
        loop = loop
    })
end

function Sound:Stop(name)
    while not DWB.PlayerLoaded or not DWB.LoadedUI do
        Wait(0)
    end
    SendNUIMessage({
        action     = 'stopSound'
    })
end