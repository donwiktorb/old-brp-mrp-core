Thread:Create(function()
    DisplayRadar(false)
    while true do
        Wait(0)
        local inCar = DWB.PlayerData.InVehicle
        if not inCar then
            HudWeaponWheelIgnoreSelection()
            DisableControlAction(0, 37, true)
        end
    end
end)

-- Event:Register('dwb:player:vehicle:enter', function()
--     DisplayRadar(true)
-- end)

-- Event:Register('dwb:player:vehicle:exit', function()
--     DisplayRadar(false)
-- end)