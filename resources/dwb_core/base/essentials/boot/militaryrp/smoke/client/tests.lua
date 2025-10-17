
-- RegisterCommand('particle', function(s, a, r)
--     local particleDict = "core"
--     local particleName = "exp_grd_grenade_smoke"
--     local weaponHash = GetHashKey("weapon_flaregun")
--     local ped = PlayerPedId()
--     local veh = GetVehiclePedIsIn(ped)
--     local coords = GetEntityCoords(veh)
--     local forward = GetEntityForwardVector(veh)
--     local front = (coords+forward*2.0)+vector(0,0,2)
--     local fixed = coords+forward*20.0
--     local leftOffset = vector3(2,2,0)
--     local rightOffset = vector3(-2,-2,0)
--     local topOffset = coords+vector3(0,0,20)
    
--     if veh then
--         if not HasNamedPtfxAssetLoaded(particleDict) then
--             RequestNamedPtfxAsset(particleDict)
--             while not HasNamedPtfxAssetLoaded(particleDict) do
--                 Wait(10)
--             end
--         end

--         if not HasWeaponAssetLoaded(weaponHash) then
--             RequestWeaponAsset(weaponHash)
--             while not HasWeaponAssetLoaded(weaponHash) do
--                 Wait(10)
--             end
--         end

--         UseParticleFxAssetNextCall(particleDict) -- Prepare the Particle FX for the next upcomming Particle FX call
--         -- SetParticleFxNonLoopedColour(1.0, 0.0, 0.0) -- Setting the color to Red (R, G, B)

--         -- AddExplosion(fixed, 38, 0.0, true, false, 1.0)
--         -- Event:TriggerNet('dwb:sounds:playDistance', 40, 'smoke', 100.0)

--         Event:TriggerNet('dwb:sounds:playSource', 'smoke', 1)

--         -- ShootSingleBulletBetweenCoords(coords, fixed+vector3(4,4,1), 0.0, true, weaponHash, false, true, false, -2.0)

--         Citizen.CreateThread(function()
--             local ptfx8 = StartParticleFxLoopedAtCoord("ent_brk_sparking_wires", front, 0.0, 0.0, 0.0, 4.0, false, false, false, false) -- Start the animation itself


--             SetTimeout(5000, function()
--                 StopParticleFxLooped(ptfx8)
            
--             end)

--         end)


--         Citizen.CreateThread(function()
--             UseParticleFxAssetNextCall(particleDict) -- Prepare the Particle FX for the next upcomming Particle FX call
--             local ptfx = StartParticleFxLoopedAtCoord(particleName, fixed, 0.0, 0.0, 0.0, 4.0, false, false, false, false) -- Start the animation itself


--             SetTimeout(20000, function()
--                 StopParticleFxLooped(ptfx)
            
--             end)
--         end)
        
--         -- Citizen.CreateThread(function()
--         --     local ptfx2 = StartParticleFxLoopedAtCoord(particleName, fixed-leftOffset, 0.0, 0.0, 0.0, 8.0, false, false, false, false) -- Start the animation itself

--         --     SetTimeout(10000, function()
--         --         StopParticleFxLooped(ptfx2)
--         --     end)
--         -- end)

--         -- Citizen.CreateThread(function()
--         --     local ptfx4 = StartParticleFxLoopedAtCoord(particleName, fixed-rightOffset, 0.0, 0.0, 0.0, 8.0, false, false, false, false) -- Start the animation itself

--         --     -- ShootSingleBulletBetweenCoords(front, fixed+vector3(0,0,20), 0.0, true, weaponHash, false, true, false, -2.0)

--         --     SetTimeout(10000, function()
--         --         StopParticleFxLooped(ptfx4)
--         --     end)
--         -- end)

--         RemoveNamedPtfxAsset(particleDict) -- Clean up

--         print('x d')
--     end

-- end)