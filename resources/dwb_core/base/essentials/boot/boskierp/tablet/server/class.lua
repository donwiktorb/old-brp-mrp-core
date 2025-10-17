


Tablet = class()

Tablet.Reports = {
    --[[
        {
            imie i nazwisko -> name
            tresc zgloszenia -> content
            data -> dodatkowe np gps
        }
    ]]
}

function Tablet:GetReports(key)
    local rep = self.Reports[key] or {}
    table.sort(rep, function(a,b)
        return b.time < a.time
    end)
    return rep
end

function Tablet:AddReport(key, value)
    if not value.time then
        value.time = os.time()
    end
    value.accepted = 0

    if not self.Reports[key] then
        self.Reports[key] = {}
    end

    value.id = #self.Reports[key]+1

    table.insert(self.Reports[key], value)
end

function Tablet:AcceptReport(key, id)
    self.Reports[key][id].accepted = self.Reports[key][id].accepted + 1
end

function Tablet:RemoveReport(key, key2, value)
    if not value then
        table.remove(self.Reports[key], key2)
    else
        for k, v in pairs(self.Reports[key]) do
            if v[key2] == value then
                table.remove(self.Reports[key], k)
            end
        end
    end
end

function Tablet:NotifyAll(key, content)
    for k, v in pairs(DWB.Players) do
        if v:GetJob(key) then
            v:ShowNotify('info', 'Tablet', string.format("%s", content))
        end
    end
end

function Tablet:GetAllDuty(key)
    local users = {}
    for k, v in pairs(DWB.Players) do
        if v:GetJob(key) then
            table.insert(users, {
                name = v.char.data.firstname.. " "..v.char.data.lastname.." #"..(v.char.data.badge or 0).. ' Mhz: '..(v.radio or 'OFF')
            })
        end
    end
    return users
end

function Tablet:Fine(xPlayer, zPlayer, fine, reason)
    local job = xPlayer:GetJobByType('fraction')
    if job then

        
        zPlayer.bank:Transaction(0, job.name, reason, tonumber(fine))
        xPlayer.bank:Transaction(1, job.name, reason, tonumber(fine))
    end
end

function Tablet:Jail(xPlayer, zPlayer, fine, reason, time)
    local job = xPlayer:GetJobByType('fraction')
    if job then
        zPlayer.bank:Transaction(0, job.name, reason, tonumber(fine))
        xPlayer.bank:Transaction(1, job.name, reason, tonumber(fine))
        zPlayer:JailPlayer(tonumber(time))
    end
end

function Tablet:GetAllWorkers(xPlayer)

    local job = xPlayer:GetJobByType('fraction')
    local users = {}
    local added = {}
    for k, v2 in pairs(DWB.Players) do
        local job2 = v2:GetJob(job.name)
        if job2 then
            added[v2.charId] = true
            table.insert(users, {
                avatar = v2.char.data.avatar or 'https://boskierp.pl/img/ss/dwb_2lGE.png',
                firstname = v2.char.data.firstname,
                lastname = v2.char.data.lastname,
                job = job2.grade,
                online = true,
                id = k,
                badge = v2:GetBadge(job.name),
                time = v2.char.data.timeOnDuty or 1
            })
        end
    end
    local sql = string.format([[SELECT * FROM `characters` WHERE JSON_CONTAINS(jobs, '{"job": %s}')]], job.name)

    local result = Mysql.Sync:fetchAll(sql, {
    })

    for k, v in pairs(result) do
        if not added[v.id] then
            local data = json.decode(v.data)
            local jobs = json.decode(v.jobs)
            for k2, v2 in pairs(jobs) do
                if v2.job == job.name then
                    table.insert(users, {
                        avatar = data.avatar or 'https://boskierp.pl/img/ss/dwb_2lGE.png',
                        firstname = data.firstname,
                        lastname = data.lastname,
                        job = v2.grade,
                        online = false,
                        id = result.id,
                        jobs = job,
                        badge = data.badges and data.badges[job.name] or 0,
                        time = data.timeOnDuty or 1
                    })
                end
            end
        end
    end

    table.sort(users, function(a, b)
        return a.job > b.job
    end)

    return users
end

function Tablet:GetUserByCharId(id)
    for k,v in pairs(DWB.Players) do
        if v.charId == id then
            return v, k
        end
    end
end

function Tablet:GetPlayerByCharId(id)
    local found, k = self:GetUserByCharId(id)
    if not found then
        local sql = 'SELECT * FROM characters WHERE id = ?' 

        local result = Mysql.Sync:fetchAll(sql, {
            tonumber(id)
        })

        return result and result[1] or {}
    else
        return found, true, k        
    end

end

function Tablet:GetPlayerByChar(name)
    local sql ='SELECT * FROM characters WHERE JSON_EXTRACT(data, "$.firstname") = ? AND JSON_EXTRACT(data, "$.lastname") = ?'

    local names = {}

    if tonumber(name) then
        sql = 'SELECT * FROM characters WHERE id = ?'
    end


    for token in string.gmatch(name, "[^%s]+") do
        table.insert(names, token)
    end

    if not tonumber(name) and not names[2] then
        sql ='SELECT * FROM characters WHERE JSON_EXTRACT(data, "$.firstname") = ? OR JSON_EXTRACT(data, "$.lastname") = ?'
    end

    local result = Mysql.Sync:fetchAll(sql, {
        names[1],
        names[2] and names[2] or names[1]
    })

    local ppl = {}

    for k, v in pairs(result) do
        local data = json.decode(v.data)
        table.insert(ppl, {
            name = string.format("%s %s", data.firstname, data.lastname),
            id = v.id,
            src = data.avatar or 'https://boskierp.pl/img/ss/dwb_2lGE.png',
        })
    end

    return ppl
end

function Tablet:GetVehicleByPlate(plate)
    local sql =
    'SELECT owner, vehicle, characters.data FROM `owned_vehicles` JOIN characters ON characters.id = owned_vehicles.owner WHERE JSON_EXTRACT(owned_vehicles.vehicle, "$.plate") LIKE ? ORDER BY vehicle'

    local result = Mysql.Sync:fetchAll(sql, {
        "%"..plate.."%"
    })

    local ppl = {}

    for k, v in pairs(result) do
        local data = json.decode(v.data)
        local veh = json.decode(v.vehicle)
        table.insert(ppl, {
            name = string.format("%s %s %s", data.firstname, data.lastname, veh.plate),
            id = v.owner,
            src = data.avatar or 'https://boskierp.pl/img/ss/dwb_2lGE.png',
        })
    end

    return ppl
end

function Tablet:GetLicenses(id)
    local found = self:GetUserByCharId(id)
    if not found then


        local vehicles = 'SELECT *  FROM characters WHERE id = ?'

        local result2 = Mysql.Sync:fetch(vehicles, {
            tonumber(id)
        })

        local userData = json.decode(result2.data)

        local userVehicles = userData.licenses or {}

        -- for k, v2 in pairs(result2) do
        --     local veh = json.decode(v2.vehicle)
        --     table.insert(userVehicles, {
        --         state = tonumber(v2.state),
        --         plate = veh.plate,
        --         model = veh.model,
        --         time = v2.time
        --     })
        -- end

        return userVehicles
    else
        local userVehicles = found.char.data.licenses or {}
        
        -- for k, v2 in pairs(found.char.data.licenses) do
        --     table.insert(userVehicles, v2)
        -- end

        return userVehicles
    end
end


function Tablet:GetUserVehicles(id)
    local found = self:GetUserByCharId(id)
    if not found or not found.garage then

        local userVehicles = {}

        local vehicles = 'SELECT *  FROM owned_vehicles WHERE owner = ? ORDER BY time'

        local result2 = Mysql.Sync:fetchAll(vehicles, {
            tonumber(id)
        })

        for k, v2 in pairs(result2) do
            local veh = json.decode(v2.vehicle)
            table.insert(userVehicles, {
                state = tonumber(v2.state),
                plate = veh.plate,
                model = veh.model,
                time = v2.time
            })
        end

        return userVehicles
    else
        local userVehicles = {}
        
        for k, v2 in pairs(found.garage.vehicles) do
            local veh = v2.vehicle
            table.insert(userVehicles, {
                state = tonumber(v2.state),
                plate = veh.plate,
                model = veh.model,
                time = v2.time
            })
        end

        return userVehicles
    end
end

function Tablet:GetUserTags(id, job)
    local tags = {}
    local sql2 = 'SELECT * FROM tablet_tags WHERE owner = ? AND job = ?'

    local result2 = Mysql.Sync:fetchAll(sql2, {
        tonumber(id), job.name
    })

    if result2 and result2[1] then
        tags = json.decode(result2[1].tags)
    end

    return tags
end

function Tablet:GetUserNotes(id, job)
    local notes, history = {}, {}
    local sql = 'SELECT *  FROM tablet_notes WHERE suspect = ? AND job = ? ORDER BY id DESC'

    local result = Mysql.Sync:fetchAll(sql, {
        tonumber(id), job.name
    })

    for k, v in pairs(result) do 
        if v.type == 'note' then
            table.insert(notes, v)
        else
            table.insert(history, v)
        end
    end

    return notes, history
end

function Tablet:RemoveNote(id)
    Mysql.Async:Execute('DELETE FROM tablet_notes WHERE id = ?', { { id } })
end

function Tablet:AddNote(xPlayer, note)
    local job = xPlayer:GetJobByType('fraction')
    if not job then return end
    Mysql.Async:Execute('REPLACE INTO tablet_notes SET ?', {
        id = note.id,
        cop = note.cop,
        suspect = note.suspect,
        content = note.content,
        type = 'note',
        jailTime = note.jailTime or 0,
        ticket = note.ticket or 0,
        job = job.name
    })
end

function Tablet:UpdateTags(xPlayer, data)
    local job = xPlayer:GetJobByType('fraction')
    if not job then return end
    Mysql.Async:Execute('REPLACE INTO tablet_tags SET ?', {
        id = 0,
        owner = tonumber(data.userId),
        tags = json.encode(data.value),
        job = job.name
    })
end

Thread:Create(function()
    while true do
        Wait(1000 * 60)
        local time = os.time()
        for k, v in pairs(Tablet.Reports) do
            for k2, v2 in pairs(v) do
                local d = time - v2.time
                if d >= 300 then
                    Tablet:RemoveReport(k, k2)
                end
            end
        end
    end
end)
