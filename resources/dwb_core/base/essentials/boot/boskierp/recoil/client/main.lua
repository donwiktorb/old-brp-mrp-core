
local recoils = Config.Recoil.Patterns
-- local recoils = {
--     default = {
--         pattern = {
--             {0.0, 0.0},
--             {0.2, 0.3},
--             {-0.4, 0.6},
--             {-0.5, 1.1},
--             {-0.9, 2.0},
--             {-0.2, 2.5},
--             -- {-0.7, 5.5},
--             -- {0.5, 0.4},
--             -- {0.4, 0.4},
--             {0.4, -0.8},
--             {0.4, -0.8},
--             {-0.4, -0.7}, -- -0.8 zeby w miejscu
--             {-0.4, 10.7},
            
            
            
            
--             -- {-0.7, 0.0}
--         }
--     }
-- }

local function randomize(vals)
    local numb = math.random(-5, 5)/100
    -- local numb2 = math.random(-5, 5)/10
    vals[1] = vals[1]+numb
    -- vals[2] = vals[2]+numb2
    return vals
end

local heatVal = 1
local lastHeat = heatVal

Thread:Create(function()
    while true do
        Wait(0)
        if DWB.PlayerData.HasWeapon and DWB.PlayerData.IsShooting then
		    -- HideHudComponentThisFrame(14)
            if DWB.PlayerData.InVehicle then
                local speed = (GetEntitySpeed(DWB.PlayerData.Vehicle)*3.5)/1000
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE' --[[ string ]], speed --[[ number ]])
            end

            local weap = DWB.PlayerData.Weapon
            local recoilObj = recoils[weap] or recoils.default

            local rec = recoilObj.pattern[heatVal] or recoilObj.pattern[#recoilObj.pattern]

            rec = randomize(rec)
            lastHeat = heatVal            
            if heatVal < #recoilObj.pattern then
                heatVal = heatVal+1
            end 

            local rot =GetGameplayCamRot (0)      
            
            local pitch = rot.x-- rec2 y
            local roll = rot.y-rec[1]-- rec1 x
            local yaw = rot.z -- lepszy y

            if rot.z >= 0 then
                pitch = pitch + rec[2]                
            else
                pitch = pitch + rec[2]
            end

            if not DWB.PlayerData.InVehicle then
                SetGameplayCamRelativeRotation(
                    roll, --x roll
                    pitch, --y pitch
                    yaw -- up yaw
                )
            end
            if not DWB.PlayerData.InVehicle then
                if rot.z < 0 then
                    SetGameplayCamRelativePitch(pitch, 1.0)           
                end
            end
            -- SetGameplayCamRelativeRotation(
            --     roll, --x roll
            --     pitch, --y pitch
            --     yaw -- up yaw
            -- )
        -- elseif not DWB.PlayerData.IsShooting and heatVal > 1 and heatVal ~= lastHeat then
        --     print('x d')
        --     heatVal = heatVal-1
        end
    end
end)

Thread:Create(function()
    while true do
        local sleep = 500
        if not DWB.PlayerData.IsShooting and heatVal > 1 then
            Wait(0)
            if not DWB.PlayerData.IsShooting then
                heatVal = heatVal-1
            end
        end
        Wait(sleep)
    end
end)