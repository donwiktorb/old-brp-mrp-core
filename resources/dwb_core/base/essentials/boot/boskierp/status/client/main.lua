
local water,hunger = 100, 100
User:OnSyncCharData(function(self, k ,v)
    if k == 'data' then
        if v.status and v.status.water and v.status.hunger then
            water = v.status.water
            hunger = v.status.hunger
            LocalPlayer.state.water = water
            LocalPlayer.state.hunger = hunger
        end
    end
end)

Event:Register('dwb:item:used', function(v)
    if v.type == 'water' then
        Animation:Play(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 8.0, 8.0, 2000, 49, 1.0)
    else
        Animation:Play(PlayerPedId(), "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 8.0, 8.0, 2000, 49, 1.0)
    end
end, true)

Thread:Create(function()
    while not DWB.PlayerData.char or not DWB.PlayerData.char.data do
        Wait(0)
    end
    while true do
        Wait(1000*60*10)
        if water > 0 or hunger > 0 then
            if water > 0 then
                water = water - 1
            end
            if hunger > 0 then
                hunger = hunger - 1
            end
            if water <= 25 then
                Notification:ShowCustom('info', 'Woda', 'Jesteś nienapojony')
            elseif hunger <= 25 then
                Notification:ShowCustom('info', 'Jedzenie', 'Jesteś głodny')
            end
            LocalPlayer.state.water = water
            LocalPlayer.state.hunger = hunger
            Event:TriggerNet('dwb:status:sync', water, hunger)
        end
        if water <= 0 or hunger <= 0 then
            local h =GetEntityHealth(PlayerPedId())
            SetEntityHealth(PlayerPedId(), h-1)
        end
    end
end)