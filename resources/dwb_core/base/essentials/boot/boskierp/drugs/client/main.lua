Event:Register('dwb:drugs:weed:collect', function()
    Animation:Play(PlayerPedId(), 'amb@world_human_gardener_plant@male@idle_a','idle_b', 3.0, 3.0, -1, 45, 1.0, false, false, false)
    UI:Open('Skills', {
        name = 'weed-leaf',
        docType = 'leafCollect',
        show = true
    }, function(data,menu)
        menu.close()
        ClearPedTasks(PlayerPedId())
    end)
end, true)



Event:Register('dwb:drugs:weed:plant', function()
    Animation:Play(PlayerPedId(), 'amb@world_human_gardener_plant@male@idle_a','idle_b', 3.0, 3.0, -1, 45, 1.0, false, false, false)
    Event:TriggerNet('dwb:drugs:weed:plant', GetEntityForwardVector(PlayerPedId()))
end, true)





Event:Register('dwb:drugs:sell', function(done)
    Animation:Play(PlayerPedId(), 'amb@prop_human_bum_bin@idle_b','idle_d', 3.0, 3.0, 5000, 45, 1.0, false, false, false)
    Wait(50)
    while IsEntityPlayingAnim(PlayerPedId(), 'amb@prop_human_bum_bin@idle_b', 'idle_d' , 45) do
        Wait(0)
    end
    ClearPedTasks()
end, true)


Event:Register('dwb:drugs:coke:collect', function()
    Animation:Play(PlayerPedId(), 'amb@world_human_gardener_plant@male@idle_a','idle_b', 3.0, 3.0, -1, 45, 1.0, false, false, false)
    UI:Open('Skills', {
        name = 'cocaine-leaf',
        docType = 'leafCollect',
        show = true
    }, function(data,menu)
        menu.close()
        ClearPedTasks(PlayerPedId())
    end)
end, true)

Event:Register('dwb:drugs:coke:extract', function()
    Animation:Play(PlayerPedId(), 'anim@amb@business@meth@meth_smash_weight_check@','break_weigh_char02', 3.0, 3.0, -1, 45, 1.0, false, false, false)
    UI:Open('Skills', {
        name = 'cocaine-extract',
        docType = 'leafClear',
        show = true
    }, function(data,menu)
        menu.close()
        ClearPedTasks(PlayerPedId())
    end)
end, true)

Event:Register('dwb:drugs:coke:pack', function()
    Animation:Play(PlayerPedId(), 'anim@amb@business@meth@meth_smash_weight_check@','break_weigh_char02', 3.0, 3.0, -1, 45, 1.0, false, false, false)
    UI:Open('Skills', {
        name = 'cocaine-pack',
        docType = 'leafZip',
        show = true
    }, function(data,menu)
        menu.close()
        ClearPedTasks(PlayerPedId())
    end)
end, true)

Event:Register('dwb:drugs:weed:dry', function()
    local coords = GetEntityCoords(PlayerPedId())
    local modelHash = -1281587804
    local obj = GetClosestObjectOfType(coords, 3.0, modelHash, false, false, false)
    if obj ~= 0 then
        local fixedCoords = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.1, 0.1)
        local heading = GetEntityHeading(obj)
        SetEntityHeading(PlayerPedId(), -heading)
        SetEntityCoordsNoOffset(PlayerPedId(), fixedCoords)
        Animation:Play(PlayerPedId(), 'anim@amb@business@weed@weed_sorting_seated@','sorter_right_left_interact_sorter02', 3.0, 3.0, 20000, 45, 1.0, false, false, false)
        Wait(50)
        while IsEntityPlayingAnim(PlayerPedId(), 'anim@amb@business@weed@weed_sorting_seated@', 'sorter_right_left_interact_sorter02' , 45) do
            Wait(0)
        end

        ClearPedTasks(PlayerPedId())
    end
end, true)