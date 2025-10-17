local elements = {
    {
        label = "Ghost",
        value = "ghostscuba"
    }
}

local vip = false


Event:Register('dwb:player:update', function(data)
    if data['vip'] ~= nil then
        vip = data['vip']
    end
end, true)

Key:onJustPressed('M', 'Menu donate', function()
    if not IsEntityDead(PlayerPedId()) and vip then
        UI:Open('Menu', {
            name = 'menu_donate',
            title = "Menu donatorow",
            align = 'right',
            elements = Vip.Cat
        }, function(data, menu)
            local cat = data.current.value
            UI:Open('Menu', {
                name = cat,
                title = "Menu donatorow",
                align = 'right',
                elements = Vip.Elements[cat][DWB.PlayerData.char.team] or {}
            }, function(data2, menu2)
                local ped = data2.current.value
                RequestModel(ped)
                while not HasModelLoaded(ped) do 
                    Citizen.Wait(0)
                end	
                SetPlayerModel(PlayerId(), ped)
                SetModelAsNoLongerNeeded(ped)
                SetPedRandomProps(PlayerPedId())
                SetPedRandomComponentVariation(PlayerPedId(), true)
                SetEntityCoords(PlayerPedId())
                SetEntityCoords(PlayerPedId(),Teams.SpawnBase[DWB.PlayerData.char.team])
            end)
        end)
    end
end)