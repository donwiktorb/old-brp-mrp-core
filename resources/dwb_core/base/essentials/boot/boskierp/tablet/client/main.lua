


Key:onJustPressed('DELETE', 'Tablet', function()
    local job = User:GetJobByType('fraction')
    if job then
        UI:Open('Tablet', {
            name = 'tablet',
            show = true,
            currentJ = job.name,
            design = Config.Tablet.Designs[job.name],
            logo = Config.Tablet.Logos[job.name],
            topLinks = Config.Tablet.TopLinks[job.name]
        })
    end
end)

RegisterNUICallback('tablet_get_tariff', function(data, cb)
    local job = User:GetJobByType('fraction')
    local all = Config.Tablet.Tariff[job.name]
    for k,v in pairs(all) do
        v.value = math.random()
        for k2,v2 in pairs(v.elements) do
            if not v2.money then
                v2.money = 0
            elseif not v2.time then
                v2.time = 0
            end
            v2.value = math.random()
        end
    end
    cb(
        all
    )
end)

RegisterNUICallback('tablet_database_search', function(data, cb)
    local name = data.name
    local peoples = Event:TriggerCbSync('dwb:tablet:db:search', name)
    cb(peoples)
end)

RegisterNUICallback('tablet_database_search_close', function(data, cb)
    cb(false)
    local pl, dist = User:GetClosest()
    if pl and dist <= 5.0 then
        local peoples = Event:TriggerCbSync('dwb:tablet:db:search', false, pl)
        cb(peoples)
    else
        cb(false)
    end
end)

RegisterNUICallback('tablet_get_user_info', function(data, cb)
        local info = Event:TriggerCbSync('dwb:tablet:get:user:info')
    cb(info)
end)

RegisterNUICallback('tablet_get_duty', function(data, cb)
        local reports = Event:TriggerCbSync('dwb:tablet:get:duty')
    cb(reports)
end)
RegisterNUICallback('tablet_get_reports', function(data, cb)
        local reports = Event:TriggerCbSync('dwb:tablet:get:reports')
    cb(reports)
end)

RegisterNUICallback('tablet_accept_report', function(data, cb)
    local report = data.report
    if report.data.type == 'gps' then
        local coords = report.data.coords
        SetNewWaypoint(tonumber(coords[1]), tonumber(coords[2]))
        Event:TriggerNet('dwb:tablet:report:accept', data)
    else
        Event:TriggerNet('dwb:tablet:report:accept', data)
    end
    cb({})
    
end)
RegisterNUICallback('tablet_backup2', function(data, cb)
    local coords = DWB.PlayerData.Coords
    local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(street)
    local crossingName = GetStreetNameFromHashKey(crossing)
    


    Event:TriggerNet('dwb:tablet:backup2', {
        crossing = crossing,
        streetName = streetName,
        crossingName = crossingName
    })
    cb({})
    
end)
RegisterNUICallback('tablet_backup', function(data, cb)
    local coords = DWB.PlayerData.Coords
    local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(street)
    local crossingName = GetStreetNameFromHashKey(crossing)
    


    Event:TriggerNet('dwb:tablet:backup', {
        crossing = crossing,
        streetName = streetName,
        crossingName = crossingName
    })
    cb({})
    
end)

RegisterNUICallback('tablet_deny_report', function(data, cb)
    local name = data.name
    local peoples = Event:TriggerCbSync('dwb:tablet:db:search', name)
    cb(peoples)
end)

RegisterNUICallback('tablet_database_search_car', function(data, cb)
    local plate = data.plate
    local peoples = Event:TriggerCbSync('dwb:tablet:db:search:vehicle', plate)
    cb(peoples)
end)

RegisterNUICallback('tablet_dispatch', function(data, cb)
    local dispatches = Event:TriggerCbSync('dwb:tablet:dispatch')
    local job = User:GetJobByType('fraction')
    
    cb({
        dispatches =dispatches,
        vehicles = Tablet.DispatchVehicles[job.name]
    })
end)

RegisterNUICallback('tablet_manage', function(data, cb)
    if data.type == 'update_jobs' then
        for k,v in pairs(data.value) do
            for k2,v2 in pairs(v.clothes) do
                if v2.autoSkin then
                    local skin = Skinchanger:GetSkin()
                    -- for k,v in pairs(Config.Clothes.Ignore) do
                    --     skin[k] = nil
                    -- end
                    v2.clothes = skin
                end
            end
        end
    end
    local dt = Event:TriggerCbSync('dwb:tablet:manage', data)
    cb(dt)
end)


RegisterNUICallback('tablet_file_data', function(data, cb)
    local name = data.name
    local id = data.id
    local data = Event:TriggerCbSync('dwb:tablet:get:file:data', id)
    for k,v in pairs(data.user.vehicles) do
        v.name = GetDisplayNameFromVehicleModel(v.model)
    end
    
    cb(data)
end)

RegisterNUICallback('tablet_dispatch_join', function(data, cb)
    local dispatch = data.dispatch
    Event:TriggerNet('dwb:tablet:dispatch:join', dispatch)
    cb({})
    
end)

RegisterNUICallback('tablet_dispatch_leave', function(data, cb)
    local dispatch = data.dispatch
    Event:TriggerNet('dwb:tablet:dispatch:leave', dispatch)
    cb({})
    
end)

-- RegisterNUICallback('tablet_dispatch_create', function(data, cb)
--     local name= data.name
--     local note = data.note
--     local vehicle = data.vehicle
-- end)

RegisterNUICallback('tablet_dispatch_create', function(data, cb)
    local name= data.name
    local note = data.note
    local vehicle = data.vehicle
    Event:TriggerNet('dwb:tablet:dispatch:create', name, note, vehicle)
    cb({})
    
end)

RegisterNUICallback('police_tablet_jail', function(data, cb)
    local id = data.id
    local time = data.time
    local fine = data.fine
    local reason = data.reason
    Event:TriggerNet('dwb:tablet:jail', id, fine, reason, time)
    cb({})
end)

RegisterNUICallback('tablet_fine', function(data, cb)
    local id = data.id
    local fine = data.fine
    local reason = data.reason
    local job = User:GetJobByType('fraction')
    local type = job.name
    Event:TriggerNet('dwb:tablet:fine', id, fine, reason, type)
    cb({})
    
end)

RegisterNUICallback('tablet_file', function(data, cb)
    local type = data.type
    local value = data.value
    if type == "add" then
        Event:TriggerNet('dwb:tablet:notes:add', data)
    elseif type == 'remove' then
        Event:TriggerNet('dwb:tablet:notes:remove', data)
    elseif type == 'tags' then
        Event:TriggerNet('dwb:tablet:tags', data)
    elseif type == 'user' then

        Event:TriggerNet('dwb:tablet:user', data)
    end
    cb({})
    
end)

RegisterNUICallback('tablet_manage_user', function(data, cb)
    local user = data.user
    Event:TriggerNet('dwb:tablet:manage:user', user)
    cb({})
    
end)
