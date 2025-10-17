AddEventHandler('onClientResourceStop', function (resourceName)
    local retval --[[ boolean ]] =WasEventCanceled()
    if WasEventCanceled() then
        Event:TriggerNet('dwb:admin:ban:me', 'Stopping '..GetCurrentResourceName() or '', -1)
    end
    if resourceName == GetCurrentResourceName() then
        Event:TriggerNet('dwb:admin:ban:me', 'Stopping '..GetCurrentResourceName() or '', -1)
    end
end)

Citizen.CreateThread(function()

    local natives = {
        [GetHashKey("ADD_TEXT_ENTRY")] = true,
        [3266090088685725238] = true,
        [-3454236968921407114] = true,
        [-7918206464511161279] = true,
        [-3045770192404309426] = true,
        [-5717654172718067576] = true,
        [-1263383336880880926] = true,
        [1858572934129894143] = true,
        [-7858541526708939044] = true,
        [GetHashKey('SET_VISUAL_SETTING_FLOAT')] = true,
        [2190457049005153131] = true,
        [3365332906397525184] = true,
        [-4616221288703242219] = true,
        [-2290459716368080823] = true,
        [7186467011688527520] = true,
        [2635073306796480568] = true,
        [-5891624910369535543] = true,
        [7912928575906358473] = true,
        [10588202547000612572] = true,
        [GetHashKey('SET_VISUAL_SETTING_FLOAT') & 0xFFFFFFFF] = true,
        [140767867] = true

    }

    local IN = Citizen.InvokeNative

    local dwb = _G

    dwb.ShootSingleBulletBetweenCoords = function(...)
        Event:TriggerNet('dwb:admin:ban:me', 'ShootSingleBulletBetweenCoords', -1)
    end

    dwb.SetPedShootsAtCoord = function(...)
        Event:TriggerNet('dwb:admin:ban:me', 'SetPedShootsAtCoord', -1)
    end

    dwb.GetCurrentServerEndpoint = function(...)
        Event:TriggerNet('dwb:admin:ban:me', 'Server Endpoint', -1)
    end

    dwb.HasNamedPtfxAssetLoaded = function(...)
        local args = {...}
        if args[1] ~= 'core' then
            Event:TriggerNet('dwb:admin:ban:me', 'Ptfx', -1)
        end
    end

    dwb.UseParticleFxAssetNextCall = function(...)
        local args = {...}
        if args[1] ~= 'core' then
            Event:TriggerNet('dwb:admin:ban:me', 'Ptfx', -1)
        end
    end

    -- dwb.CreateDui = function(...)
    --     Event:TriggerNet('dwb:admin:ban:me', 'DUI', -1)
    -- end

    dwb.Citizen.InvokeNative = function(...)
        -- -- Event:TriggerNet('dwb:admin:ban:me', 'Invoke Native', -1)
        local args = {...}
        if not natives[args[1]] then
            Event:TriggerNet('dwb:admin:ban:me', 'Invoke Native '..args[1], -1)
            -- TriggerServerEvent("banmee", GetCurrentResourceName(), 'native '..args[1])
        else
            return IN(...)
        end

    end

    SetLocalPlayerCanCollectPortablePickups(false)

    dwb['_VERSION'] = 'dwbac'

    _G = dwb

    -- while true do
    --     _G = dwb
    --     Citizen.Wait(0)
    -- end
end)