


function addReport(action ,name, msg, msgdata)
    Tablet:AddReport(action, {
        content = msg,
        data = msgdata,
        name = name
    })
end



Event:Register('dwb:tablet:report', function(source, xPlayer, name, data, job)
    if data.notify then
        Outlaw:Notify(source, data.notify, false)
    end
    Tablet:AddReport(job, {
        content = name,
        data = data, name = xPlayer.source .. ' '..xPlayer:GetCharName()
    })
end, true)
Event:Register('dwb:phone:action', function(source, xPlayer,xPlayer, number, msg, msgdata, action)
    Tablet:AddReport(action, {
        content = msg,
        data = msgdata,
        name = xPlayer.source
    })
end)

Event:Register('dwb:tablet:fine', function(source, xPlayer,id, fine, reason, type)
    local zPlayer = DWB.Players[tonumber(id)]
    Tablet:Fine(xPlayer, zPlayer, fine, reason)
end, true)

Event:Register('dwb:tablet:jail', function(source, xPlayer,id, fine, reason, time)
    local zPlayer = DWB.Players[tonumber(id)]
    Tablet:Jail(xPlayer, zPlayer, fine, reason ,time)
end, true)

Event:RegisterCb('dwb:tablet:get:reports',function(source, cb)
    local xPlayer = DWB.Players[source]
    local job = xPlayer:GetJobByType('fraction')
    cb(Tablet:GetReports(job.name))
end)

Event:RegisterCb('dwb:tablet:get:user:info',function(source, cb)
    local xPlayer = DWB.Players[source]
    local job = xPlayer:GetJobByType('fraction')
    local info = {}
    table.insert(info, xPlayer.char.data.firstname.. ' '..xPlayer.char.data.lastname)
    table.insert(info, job.grade_label)
    local h, m = convertMinutesToHours(xPlayer.char.data.timeOnDuty or 1)
    table.insert(info, string.format("%sh %sm", h,m))
    cb(info)
end)

Event:RegisterCb('dwb:tablet:get:duty',function(source, cb)
    local xPlayer = DWB.Players[source]
    local job = xPlayer:GetJobByType('fraction')
    cb(Tablet:GetAllDuty(job.name))
end)

Event:RegisterCb('dwb:tablet:db:search',function(source, cb,name, id)
    if not name and id then
        local ppl = Tablet:GetPlayerByChar(DWB.Players[id].charId)
        cb(ppl)
        return
    end
    local ppl = Tablet:GetPlayerByChar(name)
    cb(ppl)
end)

Event:RegisterCb('dwb:tablet:db:search:vehicle',function(source, cb,plate)
    local ppl = Tablet:GetVehicleByPlate(plate) 
    cb(ppl)
end)

Event:Register('dwb:tablet:report:accept', function(source, xPlayer,data)
    local rep = data.report
    local fraction = xPlayer:GetJobByType('fraction')
    Tablet:AcceptReport(fraction.name, rep.id)    
end, true)

Event:RegisterCb('dwb:tablet:get:file:data',function(source, cb,id)
    local xPlayer = DWB.Players[source]
    
    local data = {
        user = {},
        notes = {},
        licenses = {},
        history = {},
        allTags = {},
        tags = {},
        cop=xPlayer.char.data
    }


    local job = xPlayer:GetJobByType('fraction')

    data.allTags = Config.Tablet.Tags[job.name]
    data.licenses = Config.Tablet.Licenses[job.name]

    local userData, online, source = Tablet:GetPlayerByCharId(id)    

    if online then
        data.user = userData.char.data              
        data.user.online = true
        data.user.source = source
    else
        data.user = json.decode(userData.data)
        if not data.user.avatar then
            data.user.avatar = 'https://boskierp.pl/img/ss/dwb_a8fT.png'
        end
    end

    data.user.vehicles = Tablet:GetUserVehicles(id)
    data.user.charId = id
    if not data.user.licenses then
        data.user.licenses = Tablet:GetLicenses(id)
    end
    data.tags = Tablet:GetUserTags(id, job)
    data.notes, data.history = Tablet:GetUserNotes(id, job)
    
    cb(data)


end)

Event:Register('dwb:tablet:manage:user', function(source, xPlayer,data)
    local zPlayer = DWB.Players[data.id]

    local job = xPlayer:GetJobByType('fraction')

    if data.fired and job then
        zPlayer:RemoveJob(job.name)
    else
        zPlayer:SetBadge(job.name, data.badge)
    end
end, true)

Event:Register('dwb:tablet:user', function(source, xPlayer,data)
    local job = xPlayer:GetJobByType('fraction')

    local user = data.value
    if user.online then
        local zPlayer = DWB.Players[user.source]
        zPlayer:SetCharData('licenses', user.licenses)
    end

end, true)

Event:Register('dwb:tablet:tags', function(source, xPlayer,data)
    Tablet:UpdateTags(xPlayer, data)
end, true)

Event:Register('dwb:tablet:notes:remove', function(source, xPlayer,data)
    local note = data.value
    Tablet:RemoveNote(note)
end, true)

Event:Register('dwb:tablet:notes:add', function(source, xPlayer,data)
    local note = data.value
    Tablet:AddNote(xPlayer, note)
end, true)

Event:RegisterCb('dwb:tablet:manage',function(source, cb, data)
    local xPlayer = DWB.Players[source]
    local job = xPlayer:GetJobByType('fraction')

    if not job.isBoss then
        cb(false)
        return
    end

    if data.type == 'get' then
        local jobs = {}
        for k,v in pairs(DWB.Jobs[job.name].grades) do
            table.insert(jobs, v)
        end

        local users = Tablet:GetAllWorkers(xPlayer)

        cb({jobs=jobs,users=users})

    elseif data.type == 'update_user' then
        if data.value.online then
            local zPlayer = DWB.Players[data.value.id]

            if data.value.fre then
                zPlayer:RemoveJob(job.name)
            else
                zPlayer:SetJob(job.name, data.value.job)                
            end

            if data.value.badge then
                zPlayer:SetBadge(job.name, data.value.badge)
            end
            
        else
            if data.value.fre then
                local jobs=  data.value.jobs
                for k,v in pairs(jobs) do
                    if v.job == job.name then
                        table.remove(jobs, k)
                    end
                end
                local sql = "UPDATE characters SET jobs = ? WHERE id = ?"
                Mysql.Sync:Execute(sql, {
                    data.value.id, json.encode(jobs)
                })
            else
                local jobs=  data.value.jobs
                for k,v in pairs(jobs) do
                    if v.job == job.name then
                        v.grade = data.value.job
                    end
                end
                local sql = "UPDATE characters SET jobs = ? WHERE id = ?"
                Mysql.Sync:Execute(sql, {
                    data.value.id, json.encode(jobs)
                })
            end
        end
        cb{}
    elseif data.type == 'add_user' then
        local zPlayer = Tablet:GetUserByCharId(tonumber(data.value))
        if zPlayer then
            zPlayer:SetJob(job.name, 1)
        end
        cb{}
    else
        local newGrades = {}

        for k,v2 in pairs(data.value) do
            v2.clothes = v2.clothes or {}
            table.insert(newGrades, v2)
        end
        DWB.Jobs[job.name].grades = newGrades

        Job:SaveJobAll(job.name)


        for k,v in pairs(DWB.Players) do
            if v.char then
                v:RefreshJ()
            end
        end

        cb{}
    end
end)

