function User:GetJob(job)
  if type(job) == "string" then
    for k, v in pairs(DWB.PlayerData.char.jobs or {}) do
      -- if v.name == job and DWB.PlayerData.char.duty and DWB.PlayerData.char.duty[job] then
      if v.name == job then
        if
          v.type ~= "fraction"
          or not DWB.PlayerData.char.data.duty
          or DWB.PlayerData.char.data.duty[v.name]
        then
          return v
        end
      end
    end
  else
    for k, v in pairs(job or {}) do
      for k2, v2 in pairs(DWB.PlayerData.char.jobs or {}) do
        if v == v2.name then
          -- if v == v2.name and DWB.PlayerData.char.duty and DWB.PlayerData.char.duty[v] then
          if
            v.type ~= "fraction"
            or not DWB.PlayerData.char.data.duty
            or DWB.PlayerData.char.data.duty[v]
          then
            return v2
          end
        end
      end
    end
  end
end

function User:GetJobByType(job)
  if type(job) == "string" then
    for k, v in pairs(DWB.PlayerData.char.jobs or {}) do
      -- if v.name == job and DWB.PlayerData.char.duty and DWB.PlayerData.char.duty[job] then
      if v.type == job then
        if
          v.type ~= "fraction"
          or not DWB.PlayerData.char.data.duty
          or DWB.PlayerData.char.data.duty[v.name]
        then
          return v
        end
      end
    end
  else
    for k, v in pairs(job or {}) do
      for k2, v2 in pairs(DWB.PlayerData.char.jobs or {}) do
        if v == v2.name then
          -- if v == v2.name and DWB.PlayerData.char.duty and DWB.PlayerData.char.duty[v] then
          return v2
        end
      end
    end
  end
end

function User:IsOnDuty(job)
  return self.char.data.duty and self.char.data.duty[job] or false
end

function User:SetDuty(job, state)
  self.char.data.duty[job] = state
  self:SyncChar("data")
end

function User:ToggleDuty(job)
  self.char.data.duty[job] = not self.char.data.duty[job]
  self:SyncChar("data")
end

function User:HasJob(job)
  if type(job) == "string" then
    local v = DWB.PlayerData.char.jobs[job]
    if v then
      if
        v.type ~= "fraction"
        or not DWB.PlayerData.char.data.duty
        or DWB.PlayerData.char.data.duty[v.name]
      then
        return v
      end
    end
  else
    for k, v in pairs(job) do
      for k2, v2 in pairs(DWB.PlayerData.char and DWB.PlayerData.char.jobs or {}) do
        if v == v2.name then
          if
            v2.type ~= "fraction"
            or not DWB.PlayerData.char.data.duty
            or DWB.PlayerData.char.data.duty[v2.name]
          then
            return v
          end
        end
      end
    end
  end
end
