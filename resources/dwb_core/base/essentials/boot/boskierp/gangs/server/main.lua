


Event:Register('dwb:gangs:open:locker', function(source, xPlayer)
    local job = xPlayer:GetJobByType('gang')
    if job then
        xPlayer.inventory:OpenEasy({
            name = 'gang',
            label = 'Szafka',
            items = DWB.Jobs[job.name].items         
        }, {
            canChangeSlot = true,
            canChangeItem = true,
            doNotRemoveItem = false
        }, function(data)
            return true
        end, function(data)
            return true
        end, function(data, inv)
            Job:SaveJob(job.name)
            return true
        end)
    end
end, true)

Event:Register('dwb:gangs:take', function(source, xPlayer, data)
    local posData = data[1]
    local gang = posData.gang
    xPlayer.inventory:OpenEasy({
        name = 'gang',
        label = 'Szafka',
        items = DWB.Jobs[gang].items         
    }, {
        canChangeSlot = true,
        canChangeItem = true,
        doNotRemoveItem = false
    }, function(data)
        return true
    end, function(data)
        return true
    end, function(data, inv)
        Job:SaveJob(gang)
        return true
    end)
end, true)

User:OnCustomEvent('gang-room', function(self, zoneData, posData)
    local job = self:GetJobByType('gang')
    if job then
        local users = Users:GetAllBy(function(k,v)
            return v:GetJob(job.name)
        end, function(k,v)
            return {
                label = v.char.data.firstname.. ' '..v.char.data.lastname,
                value = k
            }
        end)
        if posData.gang == job.name then
            -- local users = {}
            -- for k,v in pairs(DWB.Players) do
            --     if v:GetJob(job.name) then
            --         table.insert(users, {
            --             label = v.char.data.firstname.. ' '..v.char.data.lastname,
            --             value = k
            --         })
            --     end
            -- end
            Event:TriggerNet('dwb:gangs:open', self.source, posData, job, DWB.Jobs[posData.gang].clothes, users)
        elseif #users >= 2 then
            Outlaw:NotifyEx(self.source, 'gang-room-take', false, {
                jobs = posData.gang
            })
            Event:TriggerNet('dwb:gangs:take', self.source, {posData, job, DWB.Jobs[posData.gang].clothes, users})
            -- local _xPlayer = self
            -- local _posData = posData 
            -- SetTimeout(function()
            --     if not _xPlayer:GetCharData('IsDead') then
            --         Event:TriggerNet('dwb:gangs:open', _xPlayer.source, posData, job, DWB.Jobs[_posData.gang].clothes, users)
            --     end
            -- end, 1000*5)
        end
    end
end)

Event:Register('dwb:gangs:save:skin', function(source, xPlayer,name, skin)
    local job = xPlayer:GetJobByType('gang')
    if job then
        table.insert(DWB.Jobs[job.name].clothes, {
            label = name,
            skin = skin
        })
        Job:SaveJob(job.name)
    end
end, true)

Event:Register('dwb:gangs:remove:skin', function(source, xPlayer,id)
    local job = xPlayer:GetJobByType('gang')
    if job then
        table.remove(DWB.Jobs[job.name].clothes, id)
        Job:SaveJob(job.name)
    end
end, true)

Event:Register('dwb:gangs:add:user', function(source, xPlayer,id)
    local job = self:GetJobByType('gang')
    if job then
        DWB.Players[id]:SetJob(job.name, 1)
    end
end, true)

Event:Register('dwb:gangs:remove:user', function(source, xPlayer,id)
    local job = self:GetJobByType('gang')
    if job then
        DWB.Players[id]:RemoveJob(job.name, 1)
    end
end, true)


RegisterCommand('create', function(src, args)
    Group:Create(src, args[1])
end)

RegisterCommand('join', function(src, args)
    Group:Join(src, args[1])
end)

RegisterCommand('add', function(src, args)
    Group:Add(src, args[1])
end)

RegisterCommand('remove', function(src, args)
    Group:Remove(src, args[1])
end)

RegisterCommand('leave', function(src, args)
    Group:Leave(src)
end)

RegisterCommand('action', function(src, args)
    Group:SetGroupAction(src, 'robbery', '')
end)