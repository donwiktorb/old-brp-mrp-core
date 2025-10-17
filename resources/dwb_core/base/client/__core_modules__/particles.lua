Particles = class()

function Particles:StartLoopCoord(dict, name, coords, cb, stop, dist)
    Stream:RequestPtfx(dict, function()
        local ptfx = StartParticleFxLoopedAtCoord(name, coords, 0.0, 0.0, 0.0, dist or 4.0, false, false, false, false) 
        if stop then
            SetTimeout(stop*1000, function()
                StopParticleFxLooped(ptfx)
            end)
        end
        if cb then cb() end
    end)
end

function Particles:StartLoopEntity(dict, name, entity, offset, rot, scale, cb, stop)

    Stream:RequestPtfx(dict, function()
        local ptfx = StartParticleFxLoopedOnEntity(name, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale, false, false, false) 
        if stop then
            SetTimeout(stop*1000, function()
                StopParticleFxLooped(ptfx)
            end)
        end
        if cb then cb() end
    end)
end