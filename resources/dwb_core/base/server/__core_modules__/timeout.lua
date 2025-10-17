


Timeout = class()
Timeout.ID = 0
Timeout.Cancel = {}

function Timeout:GetId()
    local id = self.ID + 1
    if id > 99 then id = 0 self.ID = 0 end
    return id
end

function Timeout:Set(cb, ms)
    local id = self:GetId()
    SetTimeout(ms, function()
        if self.Cancel[id] then 
            self.Cancel[id] = nil
        else
            cb()
        end
    end)

    return id    
end

function Timeout:Clear(id, clearCancel)
    if id then
        self.Cancel[id] = clearCancel and nil or true 
    end
end