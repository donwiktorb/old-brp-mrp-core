Job = class()

function Job:GetAllJobs()
    return DWB.Jobs
end

function Job:GetJobFromNameGrade(job, grade)
    if job and grade and DWB.Jobs[job] and DWB.Jobs[job].grades[grade] then
        return DWB.Jobs[job], DWB.Jobs[job].grades[grade]
    end
    -- return DWB.Jobs['unemployed'], DWB.Jobs['unemployed'].grades[1]
    return {}, {}
end

function Job:DoesJobExist(job, grade)
	if job and grade and DWB.Jobs[job] and DWB.Jobs[job].grades[grade] then
        return true, DWB.Jobs[job].grades[grade]
    end
    return false

end

function Job:GetDatabaseFormat(jobs)
    local db = {}
    for k,v in pairs(jobs) do
        table.insert(db, {
            job = v.name,
            grade = v.grade,
            data = v.data or {}
        })
    end
    return db
end

function Job:GetPlayersByJob(key)
    local count = 0
    local players =  {}
    for k,v in pairs(DWB.Players) do
        if v.char then
            if v.char.jobs[key] then
                count = count + 1
                table.insert(players, v)
            end
        end
    end
    return count, players
end

function Job:LoadJobs(cb)
    Mysql.Async:fetchAll('SELECT * FROM jobs', {}, function(result)
        -- print(json.encode(result))
        for k,v in pairs(result) do
            -- print(k,v)
            -- print(v.grades)
            local name, label, whitelisted, grades, type = v.name, v.label, v.whitelisted, json.decode(v.grades), v.type

            for k2,v2 in pairs(grades) do
                v2.clothes = v2.clothes or {}
                v2.grade = k2
                v2.grade_name = v2.grade_name or v2.name
                v2.job = v.name
                v2.name = v.name
                local gradeLabel = tostring(v2.label)
                if not v2.grade_label then
                    v2.grade_label = tostring(gradeLabel)
                end
                v2.label = v.label
                v2.whitelisted = whitelisted 
                v2.type = type
                v2.color = json.decode(v.color)
                v2.zoneColor = v.zoneColor
                v2.data = json.decode(v.data) or {}
            end

            DWB.Jobs[name] = {
                label = label,
                whitelisted = whitelisted,
                grades = grades,
                name = name,
                type = type,
                items = json.decode(v.items),
                clothes = json.decode(v.clothes)
            }
        end

        if cb then
            cb()
        end

    end)
end

function Job:Set(name, key, value)
    DWB.Jobs[name][key] = value
end

function Job:SetData(name, key, value)
    if not DWB.Jobs[name].data then
        DWB.Jobs[name].data = {}
    end
    DWB.Jobs.data[name][key] = value
end

function Job:RemoveMoney(name, value)
    if not DWB.Jobs[name].data then
        DWB.Jobs[name].data = {}
    end

    local money = DWB.Jobs[name].data.money or 0 

    if value <= money then
        DWB.Jobs[name].data.money = money-value
        return true
    end
end

function Job:AddMoney(name, value)
    if not DWB.Jobs[name].data then
        DWB.Jobs[name].data = {}
    end

    local money = DWB.Jobs[name].data.money or 0 

    DWB.Jobs[name].data.money = money+value
    return true
end

function Job:SaveData(name)
    Mysql.Async:Execute('UPDATE jobs SET data = ? WHERE name = ?', {
        json.encode(DWB.Jobs[name].data),
        name
    }, function(rowsChanged)
    end)
end

function Job:SaveJob(name)
    Mysql.Async:Execute('UPDATE jobs SET items = ?, clothes = ? WHERE name = ?', {
        json.encode(DWB.Jobs[name].items),
        json.encode(DWB.Jobs[name].clothes),
        name
    }, function(rowsChanged)
    end)
end


function Job:SaveJobAll(name)
    local data = DWB.Jobs[name].grades
    Mysql.Async:Execute('UPDATE jobs SET grades = ?, items = ?, clothes = ? WHERE name = ?', {
        json.encode(DWB.Jobs[name].grades),
        json.encode(DWB.Jobs[name].items),
        json.encode(DWB.Jobs[name].clothes),
        name
    }, function(rowsChanged)
    end)
end

function Job:GetByType(type)
    for k,v in pairs(DWB.Jobs) do
        if v.type == type then
            return v,k
        end
    end
end