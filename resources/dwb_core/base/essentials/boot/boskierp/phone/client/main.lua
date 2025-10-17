local show = false
local battery = 100

-- -- Key:onJustPressed('F1', 'Telefon', function()
-- --     show = not show
-- --     if show then
-- --         UI:Open('Phone', {
-- --             name = 'phone'
-- --         })
-- --         SetNuiFocus(true, true)
-- --         Wait(5000)
-- --         SendNuiMessage(json.encode({
-- --             type = 'Phone',
-- --             action = 'setBattery',
-- --             data = 50
-- --         }))
-- --     else
-- --         UI:Close('Phone', {
-- --             name = 'phone'
-- --         })
-- --         SetNuiFocus(false, false)
-- --     end
-- -- end)

Event:Register('dwb:phone:show', function ()
    Controls:Disable(24, 200, 202, 177, 1, 2, 3, 4, 5, 6, 7)
    Animation:Play(PlayerPedId(), "cellphone@", "cellphone_text_in", 4.0, 1.5, -1, 50, 1.0)
    -- show = not show
    -- if show then
    UI:CloseAll()
    UI:Open('Phone', {
        name = 'phone',
        focus = {
            cursor = true,
            doNotKeepInput = DWB.UISettings['phone'] == 0 and true or false
        }
    }, function (data, menu)
        menu.close()
        Controls:Disable(200, 202, 177)
        ClearPedTasks(PlayerPedId())
    end, function (data, menu)
        menu.close()
        Controls:RemoveDisable(24, 200, 202, 177, 1, 2, 3, 4, 5, 6, 7)
        ClearPedTasks(PlayerPedId())
    end)
    Wait(5000)
    SendNuiMessage(json.encode({
        type = 'Phone',
        action = 'setBattery',
        data = 50
    }))
    -- else
    --     UI:Close('Phone', {
    --         name = 'phone'
    --     })
    -- end
end, true)

RegisterNUICallback('phone_get_settings', function (data, cb)
    local number = Event:TriggerCbSync('dwb:phone:get:number')
    cb({ {
        label = "Numer telefonu",
        value = number
    } })
end)

RegisterNUICallback('phone_get_contacts', function (data, cb)
    local contacts = Event:TriggerCbSync('dwb:phone:get:contacts')
    cb({ contacts or {}, Config.Phone.Contacts or {} })
end)

RegisterNUICallback('phone_get_notifies', function (data, cb)
    local contacts = Event:TriggerCbSync('dwb:phone:get:notifies')
    cb(contacts or {})
end)

RegisterNUICallback('phone_get_calls', function (data, cb)
    local contacts = Event:TriggerCbSync('dwb:phone:get:calls')
    cb(contacts or {})
end)



RegisterNUICallback('phone_get_images', function (data, cb)
    local contacts = Event:TriggerCbSync('dwb:phone:get:images')
    cb(contacts or {})
end)


local camera = false
local frontCam = false

function CellFrontCamActivate(activate)
    -- return CellCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

function startCameraThread()
    camera = true
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    Controls:RemoveDisable(200, 202, 177)
    while camera do
        Citizen.Wait(0)

        if IsControlJustPressed(1, 177) then -- CLOSE PHONE
            camera = false
            CellCamActivate(false, false)
            UI:CloseAll()
        end

        if IsControlJustPressed(1, 27) then -- SELFIE MODE
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        end

        if IsControlJustPressed(1, 176) then
            Sound:Play('camera', 1.0)

            exports['screenshot-basic']:requestScreenshotUpload('https://boskierp.pl/img/upload.php',
                'uploadme', {
                headers = {
                    ['key'] = 'NEW'
                },
                encoding = 'png'
            }, function (data)
                local resp = json.decode(data)
                local url = resp.responseurl
                Event:TriggerNet('dwb:phone:image:save', url)
            end)
        end

        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()

        -- -- ren = GetMobilePhoneRenderId()
        -- -- SetTextRenderId(ren)

        -- -- -- Everything rendered inside here will appear on your phone.
        -- -- SetTextRenderId(1) -- NOTE: 1 is default
    end
    DestroyMobilePhone()
    CellCamActivate(false, false)
end

RegisterNUICallback('phone_app_action', function (data, cb)
    local name = data.action.value
    if name == 'camera' then
        UI:CloseAll()
        startCameraThread()
    end
    cb({})
end)

RegisterNUICallback('phone_message_action', function (data, cb)
    -- if data.message.data.type == 'gps' then
    --     local coords = data.message.data.coords
    --     SetNewWaypoint(tonumber(coords.x), tonumber(coords.y))
    -- end

    if data.action == 'GPS' then
        local coords = data.message.data.coords
        SetNewWaypoint(tonumber(coords.x), tonumber(coords.y))
    end
    cb({})
end)

RegisterNUICallback('phone_chat_get_messages', function (data, cb)
    local msgs = Event:TriggerCbSync('dwb:phone:get:chat:messages', data.type)
    UI:Action('Phone', 'phone', 'article', {
        action = 'setChatMessages',
        type = data.type,
        messages = msgs
    })
    cb({})
end)

RegisterNUICallback('phone_get_last_messages', function (data, cb)
    local msgs = Event:TriggerCbSync('dwb:phone:get:last:messages')
    UI:Action('Phone', 'phone', 'article', {
        action = 'setLastMessages',
        messages = msgs or {}
    })
    cb({})
end)


RegisterNUICallback('phone_get_number_messages', function (data, cb)
    local msgs = Event:TriggerCbSync('dwb:phone:get:number:messages', data.number)
    UI:Action('Phone', 'phone', 'article', {
        action = 'setMessages',
        messages = msgs
    })
    cb({})
end)

RegisterNUICallback('phone_manage_contact', function (data, cb)
    local number = data.number
    local name = data.name
    Event:TriggerNet('dwb:phone:manage:contact', name, number)
    cb({})
end)

RegisterNUICallback('phone_get_gps', function (data, cb)
    cb('gps')
end)

RegisterNUICallback('phone_chat_send_message', function (data, cb)
    if data.message ~= '' then
        local msgData
        -- if data.message == 'gps' then
        --     msgData = {}
        --     msgData.type = 'gps'
        --     msgData.coords = GetEntityCoords(PlayerPedId())
        -- end

        if string.find(data.message, '{GPS}') then
            msgData = {}
            msgData.type = 'gps'
            msgData.coords = GetEntityCoords(PlayerPedId())
        end
        Event:TriggerNet('dwb:phone:message:send:chat', data.message, data.type, msgData)
    end
    cb({})
end)

RegisterNUICallback('phone_contact_delete', function (data, cb)
    Event:TriggerNet('dwb:phone:contact:delete', data)
    cb({})
end)

local actions = Config.Phone.Actions

RegisterNUICallback('phone_send_message', function (data, cb)
    if data.message ~= '' then
        local msgData
        if string.find(data.message, '{GPS}') then
            msgData = {}
            msgData.type = 'gps'
            msgData.coords = GetEntityCoords(PlayerPedId())
        end
        -- if actions[data.number] then
        --     Event:TriggerNet('dwb:phone:action', actions[data.number], data, msgData)
        -- else
        Event:TriggerNet('dwb:phone:message:send', data.message, data.number, msgData,
            actions[tonumber(data.number)])
        -- end
    end
    cb({})
end)

RegisterNUICallback('phone_accept_call', function (data, cb)
    Log:Info('accepted call', data.number)
    Event:TriggerNet('dwb:phone:call:accept', data.number, data.sdp)
    Sound:Stop()
    cb({})
end)

Event:Register('dwb:phone:chat:update:messages', function (msgs, type)
    UI:Action('Phone', 'phone', 'article', {
        action = 'setChatMessages',
        type = type,
        messages = msgs
    })


    if type == 'twitter' then
        Event:Trigger('dwb:chat:addMessage', { template = {} })
    end
end, true)


Event:Register('dwb:phone:notify', function (type)
    Sound:Play(type, 1.0)
end, true)

Event:Register('dwb:phone:message:sent', function (data)
    if not UI:IsOpen('phone') then
        Sound:Play('msg', 1.0)
    end

    UI:Action('Phone', 'phone', 'article', {
        action = 'setMessages',
        messages = data
    })
end, true)






RegisterNUICallback('phone_try_call', function (data, cb)
    Log:Info('try call', data.number)
    local msgs = Event:TriggerCbSync('dwb:phone:check:available', data.number)
    if not msgs then
        Notification:ShowCustom('info', 'Telefon', 'Abonent nie dostepny')
    end
    cb(msgs)
end)

RegisterNUICallback('phone_send_offer', function (data, cb)
    Log:Info('send offer (ty)', data.number)
    Event:TriggerNet('dwb:phone:send:offer', data.number, data.offer)
    cb({})
end)

RegisterNUICallback('phone_send_answer', function (data, cb)
    Log:Info('send answer (ja)', data.number)
    Event:TriggerNet('dwb:phone:send:answer', data.number, data.answer)
    cb({})
end)

RegisterNUICallback('phone_new_candidate', function (data, cb)
    Log:Info('nowy kandydat (oba)', data.number)
    Event:TriggerNet('dwb:phone:new:candidate', data.number, data.candidate)
    cb({})
end)

RegisterNUICallback('phone_stop_call', function (data, cb)
    Log:Info('koniec romozwy', data.number)
    UI:Action('Phone', 'phone', 'article', {
        action = 'setAnswer',
        sdp = {}
    })
    UI:Action('Phone', 'phone', 'article', {
        action = 'setOffer',
        sdp = {}
    })
    local number = data.number
    Event:TriggerNet('dwb:phone:call:stop', number)
    cb({})
end)

Event:Register('dwb:phone:call:start', function (number, sdp)
    Log:Info('rozpocznij rozmowe (ty)', number)
    Sound:Play('ring', 1.0)
    UI:Action('Phone', 'phone', 'article', {
        action = 'setOffer',
        number = number,
        offer = sdp
    })
    UI:Action('Phone', 'phone', 'article', {
        action = 'addNotify',
        title = 'Telefon',
        content = 'Połączenie od ' .. number,
        redirect = 'call/' .. number,
        type = 'call',
    })
end, true)

Event:Register('dwb:phone:call:stop', function (number)
    Log:Info('zakoncz rozmowe (ty)', number)
    -- UI:Action('Phone', 'phone', 'article', {
    --     action = 'clearNotifiesByType',
    --     type = 'call',
    -- })
    Sound:Stop()
    UI:Action('Phone', 'phone', 'article', {
        action = 'stopCall'
    })

    UI:Action('Phone', 'phone', 'article', {
        action = 'clearNotifiesByType', type = 'call'
    })
end, true)

Event:Register('dwb:phone:new:candidate', function (number, candidate)
    Log:Info('nowy kandydat (obaj) 2 strona', number)
    -- -- Log:Info('accepted call 2', number, sdp)
    -- UI:Action('Phone', 'phone', 'article', {
    --     action = 'clearNotifiesByType',
    --     type = 'call',
    -- })
    UI:Action('Phone', 'phone', 'article', {
        action = 'addCandidate',
        number = number,
        candidate = candidate
    })
end, true)

Event:Register('dwb:phone:call:accept', function (number, sdp)
    Log:Info('telfon zaakceptowany', number)
    -- -- Log:Info('accepted call 2', number, sdp)
    -- UI:Action('Phone', 'phone', 'article', {
    --     action = 'clearNotifiesByType',
    --     type = 'call',
    -- })
    UI:Action('Phone', 'phone', 'article', {
        action = 'setAnswer',
        number = number,
        answer = sdp
    })
end, true)

RegisterNUICallback('phone_start_call', function (data, cb)
    Log:Info('telefon rozmowa rozponczi (2)', data.number)
    Event:TriggerNet('dwb:phone:call:start', data.number, data.sdp)
    cb({})
end)
