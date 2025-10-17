
Event:Register('dwb:zones:gang:start', function(_name, _job)
    local name = _name
    local job = _job
    MarkerM:EditBlipSingle('name', 'gang-zone', 'name', name, false, 'attackBlip')
    Wait(10000)
    MarkerM:UpdateBlipSingle('name', 'gang-zone', 'name', name, {
        color = job.zoneColor
    })
end, true)



Event:Register('dwb:zones:flags:start', function(posData, _job)
    local name = _name
    local job = _job
    -- MarkerM:EditBlipSingle('name', 'gang-zone', 'name', name, false, 'attackBlip')
    -- Wait(10000)
    MarkerM:EditText('name', 'flags', 'index', posData.index, 1, {
        label = job.label,
        color = job.color
    })
end, true)