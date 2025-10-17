


User:OnLoadedChar(function(self)
    self.garage = Garage(self)
    self.garage:Load()
end)    

User:OnUnloadedChar(function(self)
    self.garage:Unload(function()
        self.garage = nil
    end)
end)



User:OnSavedChar(function(self)
    self.garage:Save()
end)

Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    if action.name == 'garage-open' and data.current.value == 'pick' then
        xPlayer.garage:Open(entData.coords) 
    elseif action.name == 'garage-open' and data.current.value == 'open' then
        xPlayer.garage:Open(entData.coords) 
    elseif action.name == 'garage-open' and data.current.value == 'hide' then
        xPlayer.garage:Close()
    elseif action.name == 'garage-open' and data.current.value == 'close' then
        xPlayer.garage:Close()
    elseif action.name == 'tow' and data.current.value == 'open' then
        Event:TriggerNet('dwb:tow:open', source, GetAllTowedVehicles(source), entData)
    end
end, true)

Event:Register('dwb:garage:remove', function(source, xPlayer,idx)
    xPlayer.garage:RemoveVehicleByIdx(idx)
end, true)

Event:Register('dwb:garage:spawn', function(source, xPlayer,vehData, cData)
    local source = source
    local _xPlayer = xPlayer
    if not xPlayer.vehicles then
        xPlayer.vehicles = {}
    end
    xPlayer.garage:SpawnByIndex(vehData.id, cData, function(veh, netId, vehicle)
        print(veh, netId, vehicle)
        _xPlayer.vehicles[vehData.id] = veh
        TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1)
        Entity(veh).state.id = vehData.id
        if vehicle.items then
            Entity(veh).state.data = {
                items = vehicle.items
            }
        end
        Event:TriggerNet('dwb:garage:sync', source, netId, vehicle)
    end)
end, true)

Event:Register('dwb:garage:delete', function(source, xPlayer,vehicleData)
    local veh = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local veh2 = GetVehiclePedIsIn(GetPlayerPed(source), true)
    local entity = veh ~= 0 and veh or veh2
    local items = Entity(entity).state.data
    if items and items.items then
        vehicleData.items = items.items
    end
    xPlayer.garage:DeleteByIndex(entity, vehicleData)
end, true)

Command:Register('addveh', {'/addveh'}, function(xPlayer, a)
    local zPlayer = DWB.Players[tonumber(a[1])]
    if zPlayer then
        zPlayer.garage:AddVehicle({
            vehicle = {
                model = GetHashKey(a[2]),
                plate = a[3]
            }
        })
    else
        Garage:AddOfflineVehicle(
            {
                vehicle = {
                    model = GetHashKey(a[2]),
                    plate = a[3]
                }
            }
        )
    end
end, {})

Command:Register('dajklucze', {'Oddaj pojazd'}, function(xPlayer, args)

    local s = tonumber(args[1])
    local zPlayer = DWB.Players[s]
    local veh = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))

    if veh then
        local id = Entity(veh).state.id
        if Entity(veh).state.owner == xPlayer.source then
            local vehicleData = xPlayer.garage:GetVehicleByIdx(id)
            vehicleData.state = false
            zPlayer.garage:AddVehicle(vehicleData, veh)
            xPlayer.garage:RemoveVehicleByIdx(id)
        end
    end
end)

User:OnCustomEvent('freeveh', function(self, zoneData, posData)
    local ped = GetPlayerPed(self.source)
    if not self.freeVeh then self.freeVeh = true Vehicle:Spawn(posData.data.model, posData.data.coords, posData.data.heading, function(veh)
        TaskWarpPedIntoVehicle(ped, veh, -1)
    end) end
end)

User:OnCustomEvent('garages', function(self, zoneData, posData)
    local ped = GetPlayerPed(self.source)
    local veh = GetVehiclePedIsIn(ped)
    if veh > 0 then
        local state = Entity(veh).state
        if state.owner == self.source then
            local vehObj = self.garage:GetVehicleByIdx(state.id)
            Event:TriggerNet('dwb:garage:close', self.source)
        end
    else
        local data = posData.data
        Event:TriggerNet('dwb:garage:open', self.source, self.garage.vehicles, data.coords)
    end
end)

User:OnCustomEvent('garages-g', function(self, zoneData, posData)
    local data = posData.data
    Event:TriggerNet('dwb:garage:open2', self.source, self.garage.vehicles, data.coords)
end)

User:OnCustomEvent('pound', function(self, zoneData, posData)
    local ped = GetPlayerPed(self.source)
    local data = posData.data or zoneData.data
    Event:TriggerNet('dwb:garage:open:pound', self.source, self.garage.vehicles, data)
end)

Event:Register('dwb:garage:pound', function(source, xPlayer,vehData, cData)
    local source = source
    local itemName = cData.blackMoney and Config.Items.BlackMoney or Config.Items.Money
    local item, itemCount = xPlayer.inventory:GetItems(itemName, 'name')

    if cData.price <= itemCount  then
        xPlayer.inventory:RemoveItems(itemName, 'name', cData.price)
        if xPlayer.vehicles and xPlayer.vehicles[vehData.id] then
            if DoesEntityExist(xPlayer.vehicles[vehData.id]) then
                DeleteEntity(xPlayer.vehicles[vehData.id])
            end
        end
        xPlayer.garage:SpawnByIndex(vehData.id, {
            spawnCoords = cData.pos,
            heading = cData.heading
        }, function(veh, netId, vehicle, vehData2)
            vehData2.state = true
            TaskWarpPedIntoVehicle(GetPlayerPed(source), veh, -1)
            Entity(veh).state.id = vehData.id
            if vehicle.items then
                Entity(veh).state.data = {
                    items = vehicle.items
                }
            end

            Event:TriggerNet('dwb:garage:sync', source, netId, vehicle)
        end)
    else
        xPlayer:ShowNotify('info', label, TR("not_enough_money", comma_value(cData.price-itemCount)))
    end
end, true)

Command:Register('pojazdy', {'pojazdy'}, function(xPlayer)

    if not xPlayer.garage then return
end
    Mysql.Async:fetchAll('SELECT * FROM `owned_vehicles2` WHERE owner = ?', {
        xPlayer.identifier
    }, function(vehiclesMysql)
        if vehiclesMysql and #vehiclesMysql > 0 then
            local newVehicles = {}
            local ids = {}
            for k,v in pairs(vehiclesMysql) do
                table.insert(newVehicles, {
                    xPlayer.charId, v.vehicle
                })
                table.insert(ids, v.id)
                if not xPlayer.garage:HasVehicleByPlate(v.plate) then
                    xPlayer.garage:AddVehicle({
                        state = true,
                        vehicle = json.decode(v.vehicle)       
                    })
                end
            end
            -- -- -- -- Mysql.Async:Insert('INSERT INTO owned_vehicles (owner, vehicle) VALUES ?', {
            -- -- -- --     newVehicles
            -- -- -- -- })

            Mysql.Async:Execute('DELETE FROM `owned_vehicles2` WHERE (id) IN (?)', {
                ids
            })
        end
    end)
end)