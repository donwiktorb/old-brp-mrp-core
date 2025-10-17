local crouchAnim = "move_ped_crouched"
local lib = "move_crawl"
local anim = "onfront_fwd"
local current = 0

Key:onJustPressed('LCONTROL', 'Kucanie (LEWY CTRL)' ,function()
    DisableControlAction(0, 36, true)
    local ped = PlayerPedId()
    
    if not IsEntityDead(ped) and not IsPedInAnyVehicle(ped) then
        if current == 0 then
            current = current + 1
            Stream:RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 3.0, -1, 47, 1, false, false, false)
            end)
        elseif current == 1 then
            current = current + 1
            ClearPedTasks(ped)
            Stream:RequestAnimSet('move_ped_crouched', function()
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
            end)
        elseif current == 2 then
            current = 0
            ClearPedTasks(ped)
            ResetPedMovementClipset(ped, 0)
        end
    end
end)