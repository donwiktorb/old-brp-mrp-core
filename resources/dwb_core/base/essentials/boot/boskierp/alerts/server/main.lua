-- Event:Register('dwb:outlaw:shooting', function(source, xPlayer,coords, sName, cName)
--     local msg = TR("shooting", sName)
--     if cName then
--         msg = TR("shooting2", sName, cName)
--     end
--     addReport('police', TR("shooting_owner"), msg, {
--         coords = GetEntityCoords(GetPlayerPed(source)),
--         type = 'gps'
--     })
--     for k,v in pairs(DWB.Players) do
--         if v:HasJob('police') and v.char.duty and v.char.duty['police'] then
--             Event:TriggerNet('dwb:outlaw:shooting', k, coords, sName, cName)
--         end
--     end
-- end, true)

Event:Register('dwb:outlaw:notify', function(source, xPlayer,name, coord, ...)
    if not coord then
        coord = GetEntityCoords(GetPlayerPed(source))
    end
    local aler = Config.Alerts[name]
    for k,v in pairs(DWB.Players) do
        if v:HasJob(aler.requiredJobs) then
            Event:TriggerNet('dwb:outlaw:notify', k, name, coord, ...)
        end
    end
end, true)

Event:Register('dwb:outlaw:notify', function(source, xPlayer,name, coord, ...)
    local aler = Config.Alerts[name]
    for k,v in pairs(DWB.Players) do
        if v:HasJob(aler.requiredJobs) then
            Event:TriggerNet('dwb:outlaw:notify', k, name, coord, ...)
        end
    end
end)

Outlaw = class()

function Outlaw:NotifyEx(src, name, coord, data, ...)
    if not coord then
        coord = GetEntityCoords(GetPlayerPed(src))
    end
    local aler = Config.Alerts[name]
    for k,v in pairs(DWB.Players) do
        -- if (aler.requiredJobs and v:HasJob(aler.requiredJobs)) or (aler.requiredJobsType and v:HasJobType(aler.requiredJobsType)) then
        if aler.checkRequiredJobs and v:HasJob(data.jobs) then
            Event:TriggerNet('dwb:outlaw:notify', k, name, coord, ...)
        end
    end
end

function Outlaw:Notify(src, name, coord, ...)
    if not coord then
        coord = GetEntityCoords(GetPlayerPed(src))
    end
    local aler = Config.Alerts[name]
    for k,v in pairs(DWB.Players) do
        if (aler.requiredJobs and v:HasJob(aler.requiredJobs)) or (aler.requiredJobsType and v:HasJobType(aler.requiredJobsType)) then
            Event:TriggerNet('dwb:outlaw:notify', k, name, coord, ...)
        end
    end
end