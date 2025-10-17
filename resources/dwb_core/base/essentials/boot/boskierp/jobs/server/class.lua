-- -- Jobs = class(nil,nil,nil, User)

-- -- function Jobs:HasJob(name)
-- --     if self.char.jobs[name] then return true end
-- -- end

-- -- function Jobs:GetJob(name)
-- --     if type(name) == 'string' then
-- --         return self.char.jobs[name]
-- --     elseif type(name) == 'table' then
-- --         for k,v in pairs(name) do
-- --             return self.char.jobs[v]
-- --         end
-- --     end
-- -- end

-- -- function Jobs:SetJob(name, grade, whitelisted)
-- --     if type(self.char.jobs) ~= 'table' then
-- --         self.char.jobs = {}
-- --     end

-- --     local res, job = Job:DoesJobExist(name, grade)
    
-- --     if res and whitelisted and not job.whitelisted then
-- --         return
-- --     end
    
-- --     if res then
-- --         self.char.jobs[name] = job
-- --     end
-- -- end

-- -- function Jobs:RemoveJob(name)
-- --     self.char.jobs[name] = nil  
-- -- end

-- -- function Jobs:Load()
-- --     local newJobs = {}

-- --     for k,v in pairs(self.char.jobs or {}) do
-- --         local jobObj, gradeObj = Job:GetJobFromNameGrade(v.job, tonumber(v.grade))
-- --         newJobs[v.job] = gradeObj
-- --     end

-- --     self.char.jobs = newJobs
-- -- end