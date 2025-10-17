

Event:Register('dwb:doorlock:add', function(source, xPlayer,doorId, model, heading, job)
    if not doors then doors = {} end

    doors[doorId] = {
        model = model,
        heading = heading,
        distance = 5.0,
        jobs = {job}
    }
end, true)

RegisterCommand('saveit', function(s,a)
    local doorData = json.encode(doors, {Ident = 4})
    SaveResourceFile('dwb', 'xd.json', doorData, -1)
end)

Event:Register('dwb:doorlock:gate:state', function(source, xPlayer,doorId)
    local door = Config.Doorlock.Gates[doorId]
    door.closed = not door.closed
    Event:TriggerNet('dwb:doorlock:update:gates', -1, {doorId}, {door.closed})
end, true)

Event:Register('dwb:doorlock:state', function(source, xPlayer,doorId)
    local door = Config.Doorlock.Doors[doorId]
    door.closed = not door.closed
    if door.pair then
        local door2 = Config.Doorlock.Doors[door.pair]
        door2.closed = not door2.closed
        Event:TriggerNet('dwb:doorlock:update', -1, {doorId, door.pair}, {door.closed, door2.closed})
    else
        Event:TriggerNet('dwb:doorlock:update', -1, {doorId}, {door.closed})
    end
end, true)

-- Event:Register('dwb:doorlock:state:gate', function(source, xPlayer,doorId)
--     local door = Doorlock.Gates[doorId]
--     door.closed = not door.closed
--     Event:TriggerNet('dwb:doorlock:gate:update', -1, {doorId}, {door.closed})
-- end, true)