
for k,v in pairs(Config.Relations) do
    SetRelationshipBetweenGroups(v.relation or 1, GetHashKey(v.groupHash), GetHashKey(v.groupHash2 or 'PLAYER'))
end

local ragdoll = false
local mp_pointing = false
local keyPressed = false
local nativeka = false

local function startPointing()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(ped)
end
User:OnLoadedChar(function()
    passiveMode(true)
    Thread:Create(function()
        Wait(1000*60*7.5)
        passiveMode(false)
    end)
end)

Key:onJustPressed('M', 'Ragdoll', function()
    if not DWB.PlayerData.InVehicle then

    ragdoll = not ragdoll 
end
    -- if ragdoll then
    --     SetPedToRagdoll(PlayerPedId(), 99999999, 999999, 0, true, true, true)
    -- else
    --     ResetPedRagdollTimer(PlayerPedId())
    -- end
end)

Key:onJustPressed('B', 'Pokazywanie palcem (B)' ,function()
    local ped = PlayerPedId()
    if not mp_pointing and IsPedOnFoot(ped) then
        Wait(200)
        if not IsControlPressed(0, 29) then
            keyPressed = true
            startPointing()
            mp_pointing = true
        else
            keyPressed = true
            while IsControlPressed(0, 29) do
                Wait(50)
            end
        end
    elseif mp_pointing or (not IsPedOnFoot(ped) and mp_pointing) then
        keyPressed = true
        mp_pointing = false
        stopPointing()
    end
end )

Key:onJustReleased('B', 'Pokazywanie palcem wylacz (B)' ,function()
    keyPressed = false
end )

Thread:Create(function()
    local entries = Config.Entries
    for k,v in pairs(entries) do
        AddTextEntry(k, v)
    end

    SetCreateRandomCops(false) -- disable random cops walking/driving around
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning
    local weapons = {
        0xDF711959,
        0xF9AFB48F,
        0xA9355DCD,
        0x20796A82,
        0xE4BD2FC6,
        0x77F3F2DD,
        0x116FC4E6
    }

    for k,v in pairs(weapons) do
        ToggleUsePickupsForPlayer(PlayerId(), v, false)
    end

    DisablePlayerVehicleRewards(PlayerId())
    SetPedCanRagdollFromPlayerImpact(PlayerPedId(), true)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

    SetWeaponsNoAutoreload(true)

    while true do
        Wait(0)
        if IsTaskMoveNetworkActive(PlayerPedId()) then
            local ped = PlayerPedId()
            if not mp_pointing then
                stopPointing()
            end

            if not IsPedOnFoot(ped) then
                stopPointing()
            else
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = math.cos(camHeading)
                local sinCamHeading = math.sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
        SetVehicleDensityMultiplierThisFrame(0.0005)
        SetRandomVehicleDensityMultiplierThisFrame(0.0005)
        SetParkedVehicleDensityMultiplierThisFrame(0.0005)
        if IsPedArmed(DWB.PlayerData.Ped, 6) then
            -- -- DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
        -- -- SetVehicleDensityMultiplierThisFrame(0)
        -- -- SetRandomVehicleDensityMultiplierThisFrame(0)
        -- -- SetParkedVehicleDensityMultiplierThisFrame(0)
        SetScenarioPedDensityMultiplierThisFrame(0.05, 0.05)

        if ragdoll then
            SetPedToRagdoll(DWB.PlayerData.Ped, 500, 500, 0, true, true, true)
        end
    end
end)

Key:onJustPressed('K', 'Ubrania', function()
    UI:Open('Menu', {
        name = 'clothes',
        elements = Config.Clothes.Menu,
        align = 'right',
        title = 'Ubranie'
    }, function(data,menu)
        if data.current.value == 'clothes-on' then
            local lastSkin = Skinchanger:GetLast()
            local found = false
            for k,v in pairs(lastSkin) do
                found = true
            end
            if found then
                Animation:Play(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 3.0, 3.0, 1000, 23, 1.0)
                Skinchanger:RestoreSkin()
            end
        elseif data.current.value == 'clothes-off' then
            local lastSkin = Skinchanger:GetLast()
            local found = false
            for k,v in pairs(lastSkin) do
                found = true
            end
            if not found then
                local skin = Skinchanger:GetSkin()
                local clothes = {}
                if skin.sex == 0 then
                    clothes = Config.Clothes.Default.male
                else
                    clothes = Config.Clothes.Default.female
                end
                Animation:Play(PlayerPedId(), 'clothingtrousers', 'try_trousers_neutral_c', 3.0, 3.0, 1000, 23, 1.0)
                Skinchanger:SaveSkin()
                Skinchanger:LoadSkin(clothes)
            end
        else
            UI:Open('Menu', {
                name = 'clothes-2',
                elements = Config.Clothes.Elements,
                title = 'Zdejmij/Załóż',
                align = 'right'
            }, function(data,menu)
                local skin = Skinchanger:GetSkin()
                Animation:Play(PlayerPedId(), data.current.anim.lib, data.current.anim.anim, 3.0, 3.0, 1000, 23, 1.0)
                local clothes = {}
                if skin.sex == 0 then
                    clothes = data.current.clothes.male
                else
                    clothes = data.current.clothes.female
                end
                Skinchanger:Change(clothes)
            end)
        end
    end)
end)

-- -- Thread:Create(function()
-- --     local lastcam = 0    
-- --     local first = false        
-- --     while true do
-- --         Wait(0)
-- --         -- if DWB.PlayerData.HasWeapon and DWB.PlayerData.Weapon ~= -1569615261 then
-- --         if IsPedArmed(DWB.PlayerData.Ped, 4 | 2) then
-- --             local cam = GetFollowPedCamViewMode()
-- --             local freeAim = IsPlayerFreeAiming(DWB.PlayerData.Player)
-- --             if (DWB.PlayerData.IsShooting or freeAim) and (not first or cam ~= 4) then
-- --                 lastcam = cam
-- --                 first = true  
-- --                 SetFollowPedCamViewMode(4)
-- --             elseif (not DWB.PlayerData.IsShooting and not freeAim) and (first or cam == 4) then
-- --                 first = false 
-- --                 SetFollowPedCamViewMode(lastcam)
-- --             end
-- --         end
-- --     end
-- -- end)

local crouchAnim = "move_ped_crouched"
local lib = "move_crawl"
local anim = "onfront_fwd"
local current = 0

Key:onJustPressed('LCONTROL', 'Kucanie (LEWY CTRL)' ,function()
    DisableControlAction(0, 36, true)
    local ped = PlayerPedId()
    
    if not IsEntityDead(ped) and not IsPedInAnyVehicle(ped) then
        if current == 0 then
        --     current = current + 1
        --     --47
        --     --33, 35, 41
        --     Animation:Play(ped, lib, anim, 8.0, 3.0, -1, 35, 1, false, false, false)
        -- elseif current == 0 then
            current = current + 1
            Animation:ClearTasks(ped)
            Animation:PlayClipset(ped, 'move_ped_crouched', 0.25)
        elseif current == 1 then
            current = 0
            Animation:ClearTasks(ped)
            Animation:ResetMovement(ped)
            -- ResetPedWeaponMovementClipset(ped)
        end
    end
end)

Event:Register('dwb:player:loaded', function()
    ResetFlyThroughWindscreenParams()
    SetPedConfigFlag(PlayerPedId(), 184, true)
end, true)

RegisterCommand('seat', function(s, a, r)
    local number = a[1]
    if number then
        number = number-1
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh ~= 0 and IsVehicleSeatFree(veh, number) and UI.CanOpen then
            SetPedIntoVehicle(PlayerPedId(), veh, number)
        end
    end
end)
