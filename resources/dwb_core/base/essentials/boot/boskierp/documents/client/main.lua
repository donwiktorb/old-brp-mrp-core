
local handle

-- User:OnLoadedChar(function()
--     -- if not DWB.PlayerData.char.data.avatar then
--         local ped = PlayerPedId()
--         handle = RegisterPedheadshotTransparent(ped)
--         local timeout = 10

--         while (not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle)) and timeout > 0 do
--             timeout = timeout -1
--             Citizen.Wait(1000)
--             print('wait')
--         end

--         local txd = GetPedheadshotTxdString(handle)

--         if IsPedheadshotValid(handle) then

--             SendNuiMessage(json.encode({
--                 show = true,
--                 txd = txd, log = true,
--                 action = 'getImage'
--             }))
--         end
--     -- end
-- end)

RegisterNUICallback('dwb_ui_image_return', function(data, cb)
    Event:TriggerNet('dwb:ui:image:returned', data)
    UnregisterPedheadshot(handle)
    cb(true)
end)

Event:Register('dwb:documents:show:id', function(data)
    UI:Close('Menu', {
        name = 'dowod'
    })
    UI:Open('Documents', data, function()
    
    end, function(data,menu)
        menu.close()
    end)
    -- -- -- -- Wait(5000)
    -- -- -- -- UI:Close('Documents', data)
end, true)

Key:onJustPressed('F10', 'Dowod', function()
    local elems = {
        {
            label = "Dowód",
            value = 'id'
        },
        {

            label = "Prawo jazdy",
            value = 'driving'
        }
    }
    local job = User:GetJobByType('fraction')

    if job then
        table.insert(elems, {
            label = "Legitymacja",
            value = 'legit'
        })
    end

    UI:Open('Menu', {
        name = 'dowod',
        title = 'Dokumenty',
        elements = elems
    }, function(data, menu)
        if data.current.value == 'id' then
            Event:TriggerNet('dwb:documents:idcard:show')
        elseif data.current.value == 'legit' then
            Event:TriggerNet('dwb:documents:show:legit')
        else 
            Event:TriggerNet('dwb:documents:show:driving')
        end
    end)
end)