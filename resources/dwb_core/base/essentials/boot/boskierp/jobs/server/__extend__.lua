function User:SyncJobs()
    self:SyncChar('jobs')
    -- Event:TriggerNet('dwb:player:update', self.source, {
    --     jobs = self.char.jobs
    -- })
end

function User:HasJob(name)
    if not self.char then
        return
    end
    if type(name) == 'table' then
        for k,v in pairs(name) do
            if self.char.jobs[v] then
                return true
            end
        end
    elseif self.char.jobs[name] then 
        return true
    end
end

function User:HasJobType(name)
    if not self.char then
        return
    end
    if type(name) == 'table' then
        for k,v in pairs(name) do
            for k2,v2 in pairs(self.char.jobs) do
                if v2.type == v then
                    return true
                end
            end
        end
    else
        for k2,v2 in pairs(self.char.jobs) do
            if v2.type == name then
                return true
            end
        end
    end
end

function User:GetJob(name, dontCheckDuty)
    if not self.char then return false end
    if type(name) == 'string' then
        local jo = self.char.jobs[name]
        if jo then
            if jo.type ~= 'fraction' or (not self.char.data.duty or self.char.data.duty[jo.name]) then
                return jo
            end
        end
    elseif type(name) == 'table' then
        for k,v in pairs(name) do
            local jo = self.char.jobs[v]
            if jo then
                if jo.type ~= 'fraction' or (not self.char.data.duty or self.char.data.duty[jo.name]) then
                    return jo
                end
            end
        end
    end
end

function User:GetJobGrade(name, grade)
    if type(name) == 'string' then
        return self.char.jobs[name] and self.char.jobs[name].grades[grade] or {}
    else
        for k,v in pairs(self.char.jobs) do
            for k2,v2 in pairs(name) do
                if k2 == v2 then
                    return v.grades[grade]
                end
            end
        end
    end
end

function User:IsOnDuty(job)
    return self.char.data.duty[job]
end

function User:SetDuty(job, state)
    self.char.data.duty[job] = state
    self:SyncChar('data')
end

function User:ToggleDuty(job)
    self.char.data.duty[job] = not self.char.data.duty[job]
    self:SyncChar('data')
end

function User:GetJobByType(type, noDuty)

    for k,v in pairs(self.char and self.char.jobs or {}) do
        if v.type == type then
            if noDuty or type ~= 'fraction' or not self.char.data.duty or self.char.data.duty[v.name] then
                return v
            end
        end
    end
end

function User:SetJobData(name, data)
    if self.char.jobs[name] then
        self.char.jobs[name].data = data
    end
end

function User:SetJob(name, grade, whitelisted)
    if type(self.char.jobs) ~= 'table' then
        self.char.jobs = {}
    end
    local res, job = Job:DoesJobExist(name, grade)
    
    if res and whitelisted and not job.whitelisted then
        return
    end
    
    if res then
        local type = self:GetJobByType(job.type)
        if type and type.name ~= name then return end
        self.char.jobs[name] = job
        self:SyncJobs()
    end
end

function User:RefreshJ()
    for k,v in pairs(self.char.jobs) do
        local res, job = Job:DoesJobExist(v.name, v.grade)
        if res then
            self.char.jobs[job.name] = job
        else
            self.char.jobs[k] = nil
        end
    end
    self:SyncJobs()
end

function User:RemoveJob(name)
    -- if not grade then
        self.char.jobs[name] = nil  
        self:SyncJobs()
        return
    -- end
    -- local res, job = Job:DoesJobExist(name, grade)
    -- if (res and self:HasJob(name)) or not res then
    --     self.char.jobs[name] = nil
    --     self:SyncJobs()
    -- end
end