


-- -- local currPed = 0.242
-- -- Thread:Create(function()
-- --     local modelHash = `a_m_m_mexlabor_01` 
-- --     RequestModel(modelHash) 
-- --     while not HasModelLoaded(modelHash) do  
-- --         Wait(0) 
-- --     end 
    
    

    
-- --     while true do
-- --         Wait(500*2)
-- --         local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), math.random(3, 5)+0.0, math.random(3, 5)+0.0, math.random(1.0, 3.0)+0.0)
-- --         local ped = CreatePed(0, modelHash, coords, 200.0, false, true)

-- --         while not DoesEntityExist(ped) do
-- --             Wait(0)
-- --         end

-- --         currPed = ped
-- --         SetEntityOnlyDamagedByPlayer(ped, true)
-- --         SetEntityAlpha(ped, 0, false)
-- --         SetEntityCollision(ped, false, true)
-- --         FreezeEntityPosition(ped, true)

-- --         Wait(1000)

-- --         DeleteEntity(ped)
-- --     end
-- -- end)

-- -- AddEventHandler('entityDamaged', function(vict, cp, weap, bD)
-- --     if vict == currPed then
-- --         print('ban')        
-- --     end
-- -- end)

Thread:Create(function()
    local models = {
        [`mp_f_freemode_01`] = true,
        [`mp_m_freemode_01`] = true
    }
    while not DWB.PlayerLoaded and not DWB.PlayerData.char do
        Wait(0)
    end
    RemoveAllPedWeapons(PlayerPedId(), true)
    local leave = {
        [966099553]= true
    }
    local flag = 0
    while true do
        StopSound(-1)

        ReleaseAmbientAudioBank()
        StopAudioScenes()
        ResetTrevorRage()
        RestartScriptedConversation()
        StopAllAlarms(true)

        StopStream()
        StopCutsceneAudio()
        ReleaseMissionAudioBank()
        ReleaseScriptAudioBank()
        ReleaseWeaponAudio()

        -- -- -- -- Event:TriggerNet('dwb:ac:sync')


        Wait(5000)
        local weap, hash = GetCurrentPedWeapon(PlayerPedId())

        
        
        if weap and not leave[hash] then
            local found = false
            for k,v in pairs(DWB.PlayerData.char.inventory) do
                if v.type == 'weapon' then
                    local hash2 = GetHashKey(v.name)
                    if hash == hash2 then
                        found = true
                    end
                end
            end

            if not found then
                Event:TriggerNet('dwb:ac:weapon', hash, -1)
            end

            if GetWeaponDamageModifier(hash) > 1.0 then
                -- Event:TriggerNet('dwb:ac:weapon:damage', hash, GetWeaponDamageModifier(hash))
                Event:TriggerNet('dwb:admin:ban:me', 'Anticheat (Weapon Damage Modifier) '..hash..(GetWeaponDamageModifier(hash) or ''), -1)
            end

            local heading = GetEntityHeightAboveGround(PlayerPedId())
            local frozen = IsEntityPositionFrozen(PlayerPedId())

            if heading >= 10.0 and frozen and not DWB.PlayerData.group then
                Event:TriggerNet('dwb:admin:ban:me', 'Anticheat (Noclip)', -1)
            end

            if NetworkIsInSpectatorMode() and not DWB.PlayerData.group then
                Event:TriggerNet('dwb:admin:ban:me', 'Anticheat (spect)', -1)
            end

            if DWB.PlayerData.group and not tonumber(DWB.PlayerData.group) then
                Event:TriggerNet('dwb:admin:ban:me', 'Anticheat (group)', -1)
            end

            if not IsEntityVisible(DWB.PlayerData.Ped) and not DWB.PlayerData.data.group then
                SetEntityVisible(DWB.PlayerData.Ped, true)
            end

            local Is = GetPlayerInvincible(PlayerId())

            if Is then
                SetEntityInvincible(DWB.PlayerData.Ped, false)
            end

            local model = GetEntityModel(DWB.PlayerData.Ped)

            if IsModelInCdimage(model) and IsModelValid(model) then
                if not models[model] and not DWB.PlayerData.data.group then
                    Event:TriggerNet('dwb:admin:ban:me', 'Anticheat (skinchanger)', -1, 'Anticheat')
                end
            end

            -- -- -- -- Event:TriggerNet('dwb:ac:jump')
        end
    end
end)
-- -- local ped

-- -- Thread:Create(function()
-- --     local modelHash = `a_m_m_mexlabor_01` RequestModel(modelHash) while not HasModelLoaded(modelHash) do  Wait(0) end ped = CreatePed(0, modelHash, GetEntityCoords(PlayerPedId()), 200.0, true, true)
-- --     for i=0, 457 do
-- --         SetPedResetFlag(ped, i, true)
-- --     end
-- --     FreezeEntityPosition(ped, true)
-- -- end)

-- -- RegisterCommand('setflag', function(s,a)
-- --     SetPedConfigFlag(ped, tonumber(a[1]), true)
-- -- end)


-- -- RegisterCommand('revped', function(s,a)
-- --     SetEntityHealth(ped, 200)
-- --     ClearPedTasksImmediately(ped)
-- --     ResurrectPed(ped)
-- -- end)

-- -- RegisterCommand('resetflag', function(s,a)
-- --     SetPedResetFlag(ped, tonumber(a[1]), true)
-- -- end)

-- -- RegisterCommand('setflag2', function(s,a)
-- --     SetPedConfigFlag(ped, tonumber(a[1]), false)
-- -- end)