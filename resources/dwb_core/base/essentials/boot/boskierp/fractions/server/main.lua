function User:GetBadge(name)
    if not name then
        local job = self:GetJobByType('fraction')
        name = job and job.name
    end
    if not name then return end
    return self.char.data.badges and self.char.data.badges[name] or 0
end

function User:SetBadge(name, badge)
    if not self.char.data.badges then
        self.char.data.badges = {}
    end
    self.char.data.badges[name] = badge
end

Event:Register('dwb:fraction:garage:spawn', function(source, xPlayer,vehicle, spawn)
    local vehData = vehicle
    if spawn then
        local ped = GetPlayerPed(source)
        local _src = source
        Vehicle:Spawn(vehicle.model, spawn.coords, spawn.heading, function(veh, vehId)
            TaskWarpPedIntoVehicle(ped, veh, -1)
            if vehData.properties then
                Event:TriggerNet('dwb:garage:sync', _src,  vehId, vehData.properties)
            end
        end)
    else
        xPlayer:ShowNotify('info', TR("parking"), TR("not_enough_place"))
    end
end, true)

User:OnCustomEvent('cloakroom', function(self, zoneData, posData)
    Event:TriggerNet('dwb:fraction:cloakroom:open', self.source, posData)
end)

User:OnCustomEvent('vehicle', function(self, zoneData, posData)
    Event:TriggerNet('dwb:fraction:garage:open', self.source, posData)
end)

Event:Register('dwb:fraction:open:menu', function(source, xPlayer)
    Event:TriggerNet('dwb:fraction:open:menu', source)
end, true)

Event:Register('dwb:fraction:menu:action', function(source, xPlayer,current, current2, data5)
    xPlayer:CustomEvent('fraction-action', current, current2, data5)
end, true)

User:OnCustomEvent('fraction-action', function(self, data, data2, data5)
    if data.value == 'objects' then
        Event:TriggerNet('dwb:fraction:place:object', self.source, data2)
    elseif data.value == 'vehicle' then
        local veh = NetworkGetEntityFromNetworkId(data5)
        if DoesEntityExist(veh) then
            if data2.value == 'open' then
                SetVehicleDoorsLocked(veh, 1)               
            elseif data2.value == 'fix' then
                Event:TriggerNet('dwb:mechanic:fix', self.source)
            elseif data2.value == 'clean' then
                SetVehicleDirtLevel(veh, 0.0)
            elseif data2.value == 'delete' then
                DeleteEntity(veh)
            elseif data2.value == 'put' then

            elseif data2.value == 'remove' then

            end
            -- -- Event:TriggerNet('dwb:fraction:place:object', self.source, data2, data5)
        end
    elseif data.value == 'person' then
        local player, dist = Core:GetClosestPlayer(self:GetPedCoords(), 4.0, false, self.source)
        local current = data2
        if player then
            if current.value == 'proch' then
                if player.lastWeapon then
                    self:ShowNotify('info', 'Proch', ('Bron: %s'):format(player.lastWeapon.label))
                end
            elseif current.value == 'id' then


                self:ShowNotify('info', 'ID', ('ID: %s'):format(player.charId))
            elseif current.value == 'license-take' then
                player:RemoveLicense(current.license)
            elseif current.value == 'license-give' then
                player:AddLicense(current.license)
            end
        end
    end
end)

Event:Register('dwb:fraction:place:object', function(source, xPlayer,item, forward, rot)
    Object:Create(item.value, forward, function(obj)
        SetEntityHeading(obj, rot)
    end)
end, true)

Command:Register('duty', {'duty'}, function(xPlayer, args)
    local job = xPlayer:GetJobByType('fraction', true)
    if job then
        local duty = xPlayer.char.data.duty or {}
        duty[job.name] = not duty[job.name]


        xPlayer:SetCharData('duty', duty)
    end
end)

Command:Register('10-13', {'10-13'}, function(xPlayer)
    if xPlayer:GetJobByType('fraction') then Outlaw:Notify(xPlayer.source, '10-13', nil, xPlayer:GetCharName()) end
end)