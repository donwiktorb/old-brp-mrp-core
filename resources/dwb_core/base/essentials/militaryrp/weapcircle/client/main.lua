Citizen.CreateThread(function()
    -- HudWeaponWheelIgnoreControlInput(false)
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local inCar = IsPedInAnyVehicle(ped)
        if not inCar then
            -- ShowHudComponentThisFrame(14)
            -- HideHudAndRadarThisFrame()
            -- ShowHudComponentThisFrame(14)
            HudWeaponWheelIgnoreSelection()
            -- ShowHudComponentThisFrame(14)
            DisableControlAction(0, 37, true)
        end
        DisplayRadar(inCar)
    end
end)