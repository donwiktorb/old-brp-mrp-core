
function User:SetJobs(jobs)
    local lastJobs = self.jobs
    self.jobs = jobs
    -- TriggerEvent('dwb:updateJobs', self.source, self.jobs, lastJobs)
    -- TriggerClientEvent('dwb:updateJobs', self.source, self.jobs)
end

function User:HasJob(job, grade)
    if job then
        if grade then
            if tonumber(grade) then
                for k,v in pairs(self.jobs) do
                    if v.name == job and v.grade == grade then
                        return true
                    end
                end
            else
                for k,v in pairs(self.jobs) do
                    if v.name == job and v.grade_name == grade then
                        return true
                    end
                end
            end
        else
            return self.jobs[job] or false
        end
    end
    return false
end

function User:GetJob(job, grade)
    if job then
        if grade then
            if tonumber(grade) then
                for k,v in pairs(self.jobs) do
                    if v.name == job and v.grade == grade then
                        return v
                    end
                end
            else
                for k,v in pairs(self.jobs) do
                    if v.name == job and v.grade_name == grade then
                        return v
                    end
                end
            end
        else
            return self.jobs[job] or false
        end
    end
    return false
end

function User:AddJob(job, grade)
    local lastJobs = self.jobs
    if Job:DoesJobExist(job, grade) then
        local jobObj, gradeObj = DWB.Jobs[job], DWB.Jobs[job].grades[grade]
        local newJob = {
            name = job,
            label = jobObj.label,
            grade = tonumber(grade),
            grade_name = gradeObj.name,
            grade_label = gradeObj.label,
            grade_salary = gradeObj.salary
        }

        self.jobs[job] = newJob


        -- TriggerEvent('dwb:updateJobs', self.source, self.jobs, lastJobs)
        -- TriggerClientEvent('dwb:updateJobs', self.source, self.jobs)
    else
        Log:Error(('dwb: ignoring setJob for %s due to job not found!'):format(self.source))
    end		
end

function User:RemoveJob(job, grade)
    local lastJobs = self.jobs
    self.jobs[job] = nil

    -- TriggerEvent('dwb:updateJobs', self.source, self.jobs, lastJobs)
    -- TriggerClientEvent('dwb:updateJobs', self.source, self.jobs)
end

