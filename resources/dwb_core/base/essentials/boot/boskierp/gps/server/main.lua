-- -- RegisterCommand('gps', function()
-- --     for k,v in pairs(DWB.Players) do
-- --         local ped = GetPlayerPed(k)
-- --         local veh = GetVehiclePedIsIn(ped, lastVehicle)
-- --         local blip = AddBlipForEntity(veh)
-- --         Event:TriggerNet('dwb:gps:make', -1, blip, k)
-- --     end
-- -- end)

-- -- AddEventHandler('playerEnteredScope', function(data)
-- --     local player = data['for']
-- --     local player2 = data.player
-- --     Event:TriggerNet('dwb:gps:create', player2, player)
-- --     Event:TriggerNet('dwb:gps:create', player, player2)
-- -- end)

-- -- AddEventHandler('playerLeftScope', function(data)
-- --     local player = data['for']
-- --     local player2 = data.player
-- --     Event:TriggerNet('dwb:gps:remove', player2, player)
-- --     Event:TriggerNet('dwb:gps:remove', player, player2)
-- -- end)

Citizen.CreateThread(function()
    while true do
        Wait(3000)

        local users={}

        for k,v in pairs(DWB.Players) do
            if v.char then
                local gps = v.inventory:GetItem('gps', 'name')
                if gps and gps.data and gps.data.toggle then
                    local job = v:GetJobByType('fraction')
                    local name = v.char.data.firstname..' '..v.char.data.lastname
                    local vehType
                    local ped = GetPlayerPed(k)
                    local veh = GetVehiclePedIsIn(ped)
                    local toggled
                    if veh and DoesEntityExist(veh) then
                        vehType = GetVehicleType(veh) == 'heli' and 'heli' or 'car'
                        toggled=Entity(veh).state.toggle
                    end
                    table.insert(users, {
                        job = job and job.name or false,
                        badge = v:GetBadge(job and job.name) or 0,
                        name = name ,
                        src = k,
                        vehType = vehType,
                        coords = GetEntityCoords(ped),
                        heading = GetEntityHeading(ped),
                        toggled = toggled
                    })
                end
            end
        end

        for k,v in pairs(users) do
            Event:TriggerNet('dwb:gps:sync', v.src, users)
        end
    end
end)

Item:RegisterUsable('gps', function(source)
    local xPlayer = DWB.Players[source]
    
    
    local item = xPlayer.inventory:GetItem('gps', 'name')

    local toggle = true

    if item.data then
        toggle = not item.data.toggle
    end

    xPlayer.inventory:SetItemData(item.slot, 'slot', {
        ['toggle'] = toggle
    })

    if not toggle then
        Event:TriggerNet('dwb:gps:clear', -1, source, toggle)
    end
end)

User:OnUnloadedChar(function(self)
    Event:TriggerNet('dwb:gps:left', -1, self.source)
end)

Event:Register('dwb:inventory:item:remove', function(self,item)
    if item.name == 'gps' then
        Outlaw:Notify(self.source, 'lost-gps', false, self.char.data.firstname, self.char.data.lastname, self.char.data.avatar)
    end
end)