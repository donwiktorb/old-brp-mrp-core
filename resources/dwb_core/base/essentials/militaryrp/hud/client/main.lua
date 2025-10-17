local spawned = false

Event:Register('dwb:player:loaded', function()
    UI:Action('MilitaryHud', 'militaryhud', 'open', {})
    spawned = true
end, true)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if spawned then
            local ped = PlayerPedId()
            local ret, current = GetCurrentPedWeapon(ped, true)

            if current == 0 then
                ret, current = GetCurrentPedVehicleWeapon(ped)
            end

            local ammo = 0
            local maxammo = 0

            if current then
                maxammo = GetAmmoInPedWeapon(ped, current)
                local ret, amm = GetAmmoInClip(ped, current)
                if not ret then
                    ret = true
                    amm = GetVehicleWeaponCapacity(GetVehiclePedIsIn(ped), 0)
                end

                ammo = ret and amm or 0
            end

            UI:Action('MilitaryHud', 'militaryhud', 'update', {
                hp = GetEntityHealth(PlayerPedId()),
                ammo = ammo,
                maxammo = maxammo
            })
        end
    end
end)