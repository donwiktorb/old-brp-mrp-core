


-- -- local vehicles = {}
-- -- local towVehicles = {}

-- -- User:OnSaved(function(self)
-- --   local xPlayer = self
  
-- --     local source=  self.source
-- --     local changedVehs = {}

-- --     for k,v in pairs(vehicles[source]) do
-- --         if v.changed then
-- --             table.insert(changedVehs, {
-- --                 v.id or 0,
-- --                 xPlayer.charId,
-- --                 v.state,
-- --                 json.encode(v.vehicle)
-- --             })
-- --             v.changed = ni
-- --         end
-- --     end

-- --     -- vehicles[source] = nil

-- --     if #changedVehs > 0 then
-- --         Mysql.Async:Execute('INSERT INTO owned_vehicles (id, owner, state, vehicle) VALUES ? ON DUPLICATE KEY UPDATE owner = VALUES(owner), state = VALUES(state), vehicle = VALUES(vehicle)', {
-- --             {
-- --                 table.unpack(changedVehs) 
-- --             }
-- --         }, function(rowsChanged)
-- --             Log:Info('Saved vehs for ', source)
-- --         end)
-- --     end
-- -- end)

-- -- User:OnChanged(function(self)
-- --     local source = self.source
-- --     vehicles[source] = nil
-- --     towVehicles[source] = nil
-- --     local xPlayer = self
-- --     local charId = xPlayer.charId

-- --     if not charId then return end

-- --     local vehiclesMysql = Mysql.Sync:fetchAll('SELECT * FROM owned_vehicles WHERE owner = ? ORDER BY id', {
-- --         charId
-- --     })

-- --     for k,v in pairs(vehiclesMysql) do
-- --         v.vehicle = json.decode(v.vehicle)
-- --     end

-- --     vehicles[source] = vehiclesMysql
-- --     towVehicles[source] = {}
-- -- end)

-- -- Event:Register('dwb:player:loaded', function(source, xPlayer)
-- --     local charId = xPlayer.charId

-- --     if not charId then return end

-- --     local vehiclesMysql = Mysql.Sync:fetchAll('SELECT * FROM owned_vehicles WHERE owner = ? ORDER BY id', {
-- --         charId
-- --     })

-- --     for k,v in pairs(vehiclesMysql) do
-- --         v.vehicle = json.decode(v.vehicle)
-- --     end

-- --     vehicles[source] = vehiclesMysql
-- --     towVehicles[source] = {}
-- -- end)

-- -- Event:Register('dwb:player:dropped', function(source, xPlayer)
-- --     local source=  xPlayer.source
-- --     DeleteAllTowed(source)
-- --     local changedVehs = {}

-- --     for k,v in pairs(vehicles[source] or {}) do
-- --         if v.changed then
-- --             table.insert(changedVehs, {
-- --                 v.id or 0,
-- --                 xPlayer.charId,
-- --                 v.state,
-- --                 json.encode(v.vehicle)
-- --             })
-- --         end
-- --     end

-- --     vehicles[source] = nil

-- --     if #changedVehs > 0 then
-- --         Mysql.Async:Execute('INSERT INTO owned_vehicles (id, owner, state, vehicle) VALUES ? ON DUPLICATE KEY UPDATE owner = VALUES(owner), state = VALUES(state), vehicle = VALUES(vehicle)', {
-- --             {
-- --                 table.unpack(changedVehs) 
-- --             }
-- --         }, function(rowsChanged)
-- --             Log:Info('Saved vehs for ', source)
-- --         end)
-- --     end

-- -- end)

-- -- Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
-- --     if action.name == 'garage-open' and data.current.value == 'pick' then
-- --         local coords = entData.spawnCoords
-- --         local heading = entData.heading
        
-- --         Event:TriggerNet('dwb:garage:open', source, vehicles[source], entData.coords)
-- --     elseif action.name == 'garage-open' and data.current.value == 'open' then
-- --         local coords = entData.spawnCoords
-- --         local heading = entData.heading
        
-- --         Event:TriggerNet('dwb:garage:open2', source, vehicles[source], entData.coords)
-- --     elseif action.name == 'garage-open' and data.current.value == 'hide' then
-- --         Event:TriggerNet('dwb:garage:close', source)

-- --     elseif action.name == 'garage-open' and data.current.value == 'close' then
-- --         Event:TriggerNet('dwb:garage:close2', source)
-- --     elseif action.name == 'tow' and data.current.value == 'open' then

-- --         local coords = entData.spawnCoords
-- --         local heading = entData.heading
-- --         Event:TriggerNet('dwb:tow:open', source, GetAllTowedVehicles(source), entData)
-- --     end
-- -- end, true)

-- -- function GetVehicle(source, plate, state)
-- --     for k,v in pairs(vehicles[source]) do
-- --         local veh = v.vehicle
-- --         if veh.plate == plate then
-- --             local lastState = v.state
-- --             if v.state ~= state then
-- --                 v.changed = true
-- --             end
-- --             v.state = state
-- --             return veh, k, lastState
-- --         end
-- --     end
-- -- end

-- -- function ChangeVehProperties(source, plate, properties, state)
-- --     for k,v in pairs(vehicles[source]) do
-- --         local veh = v.vehicle
-- --         if veh.plate and plate and string.lower(veh.plate) == string.lower(plate) then
-- --             v.vehicle = properties
-- --             v.state = state
-- --             v.changed = true
-- --             return true
-- --         end
-- --     end
-- -- end

-- -- function AddTowed(source, veh, plate)
-- --     table.insert(towVehicles[source], {
-- --         veh = veh,
-- --         plate = plate
-- --     })
-- -- end

-- -- function RemoveFromTowed(source, plate)
-- --     for k,v in pairs(towVehicles[source]) do
-- --         if v.plate == plate then
-- --             table.remove(towVehicles[source], k)
-- --         end
-- --     end
-- -- end

-- -- function DeleteTowed(source, plate)
-- --     for k,v in pairs(towVehicles[source]) do
-- --         if v.plate == plate then
-- --             if DoesEntityExist(v.veh) then
-- --                 DeleteEntity(v.veh)
-- --             end
-- --             table.remove(towVehicles[source], k)
-- --         end
-- --     end
-- -- end

-- -- function DeleteAllTowed(source)
-- --     for k,v in pairs(towVehicles[source] or {}) do
-- --         if DoesEntityExist(v.veh) then
-- --             DeleteEntity(v.veh)
-- --         end
-- --     end
-- --     towVehicles[source] = nil
-- -- end

-- -- function GetAllTowedVehicles(source)
-- --     local towed = {}
-- --     for k,v in pairs(vehicles[source]) do
-- --         local veh = v.vehicle
-- --         for k2,v2 in pairs(towVehicles[source]) do
-- --             if veh.plate == v2.plate and not DoesEntityExist(v2.veh) then
-- --                 table.insert(towed, v)
-- --             end
-- --         end
-- --     end
-- --     return towed
-- -- end

-- -- function RemoveVehicle(source, plate)
-- --     for k,v in pairs(vehicles[source]) do
-- --         local veh = v.vehicle
-- --         if veh.plate == plate then
-- --             table.remove(vehicles[source], k)
-- --             if v.id and v.id > 0 then
-- --                 Mysql.Async:Execute('DELETE FROM owned_vehicles WHERE id = ? AND owner = ?', {
-- --                     v.id,
-- --                     DWB.Players[source].charId
-- --                 })
-- --             else
-- --                 Mysql.Async:Execute('DELETE FROM owned_vehicles WHERE JSON_EXTRACT(vehicle, "$.plate") = ? AND owner = ?', {
-- --                     plate,
-- --                     DWB.Players[source].charId
-- --                 })
-- --             end
-- --         end
-- --     end
-- -- end

-- -- Event:Register('dwb:garage:delete', function(source, xPlayer,plate)
-- --     local plate = Math:Trim(plate)
-- --     RemoveVehicle(source, plate)
-- -- end, true)

-- -- Event:Register('dwb:garage:spawn', function(source, xPlayer,plate, cData)
-- -- plate = Math:Trim(plate)
-- --     local vehicle, id, last = GetVehicle(source, plate, false)
-- --     if vehicle and last  then
-- --         local ped = GetPlayerPed(source)
-- --         local source = source
-- --         -- xPlayer:AddInventoryItem(false, 'car_keys', 1, {
-- --         --     plate= plate
-- --         -- })
-- --         Vehicle:Spawn(vehicle.model, cData.spawnCoords, cData.heading, function(veh)
-- --             TaskWarpPedIntoVehicle(ped, veh, -1)
-- --             Entity(veh).state.data = {
-- --                 items = vehicle.items or {}
-- --             }
-- --             AddTowed(source, veh, plate)
-- --             -- -- TaskEnterVehicle(ped, veh, 9000, -1, 1.0, 1, 0)
-- --             local netId = NetworkGetNetworkIdFromEntity(veh)
-- --             Event:TriggerNet('dwb:garage:spawn', source, vehicle, netId)
-- --         end)
-- --     else
-- --         Log:Info("Something sussy, player vehicle not found", source, plate)
-- --     end
-- -- end, true)

-- -- Event:Register('dwb:garage:close', function(source, xPlayer,properties)
-- --     local ped = GetPlayerPed(source)
-- --     local veh2 = GetVehiclePedIsIn(ped, false)
-- --     local veh = veh2 ~= 0 and veh2 or  GetVehiclePedIsIn(ped, true)
-- --     if veh then
-- --         local plate = Math:Trim(GetVehicleNumberPlateText(veh))
-- --         local items = Entity(veh).state.data and Entity(veh).state.data.items or {}
-- --         properties.items = items 
-- --         local vehObj = GetVehicle(source, plate)
-- --         if vehObj then
-- --             -- -- if vehObj.mdel ~= properties.model or vehObj.model ~= GetEntityModel(veh) then
-- --             -- --     Log:Warn('Vehicle copy', properties.model, vehObj.model, GetEntityModel(veh))
-- --             -- --     return
-- --             -- --     -- return Event:Trigger('dwb:admin:ban:me', source, "Change Vehicle Model (Vehicle Copy)", -1)
-- --             -- -- end
-- --             local vehicle = ChangeVehProperties(source, plate, properties, true, items)
-- --             if vehicle then
-- --                 -- xPlayer:RemoveInventoryItemByMD('car_keys', 'plate', plate, 1)
-- --                 DeleteEntity(veh)
-- --                 RemoveFromTowed(source, plate)
-- --                 xPlayer:ShowNotify('info', 'Garaż', 'Schowałeś pojazd')
-- --             else
-- --                 Log:Info("Something sussy, player vehicle not found", source, plate)
-- --             end
-- --         end
-- --     else
-- --         Log:Info("Something sussy, player vehicle not found", source)
-- --     end
-- -- end, true)

-- -- Event:Register('dwb:garage:add:vehicle', function(source, veh, properties)
-- --     local xPlayer = DWB.Players[source]

-- --     -- -- print(source)
    
-- --     table.insert(vehicles[source], {
-- --         owner = xPlayer.charId,
-- --         vehicle = properties,
-- --         state = false,
-- --         changed = true
-- --     }) 
-- -- end)

-- -- Command:Register('dajklucze', {'Oddaj pojazd'}, function(xPlayer, args)
-- --     local s = tonumber(args[1])
-- --     local zPlayer = DWB.Players[s]
-- --     local veh = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
-- --     if veh then
-- --         local plate = Math:Trim(GetVehicleNumberPlateText(veh))
-- --         local vehicle, vehId = GetVehicle(xPlayer.source, plate, false)
-- --         -- -- print(vehicle)
-- --         if vehicle then
-- --         table.insert(vehicles[s], {
-- --             owner = zPlayer.charId,
-- --             vehicle = vehicle,
-- --             state = false,
-- --             changed = true
-- --         }) 
-- --         table.remove(vehicles[xPlayer.source], vehId)
-- --         Mysql.Async:Execute('DELETE FROM owned_vehicles WHERE owner = ? AND JSON_EXTRACT(vehicle, "$.plate") = ?', {
-- --             xPlayer.charId,
-- --             plate
-- --         })
-- --     end
-- --     end
-- -- end)

-- -- Command:Register('addveh', {'Dodaj pojazd'}, function(xPlayer, args)
-- --     local s = tonumber(args[1])
-- --     local zPlayer = DWB.Players[s]
-- --     if zPlayer then
-- --         local model = GetHashKey(args[2])
-- --         table.remove(args, 1)
-- --         table.remove(args, 1)
-- --         local plate = table.concat(args, '')
-- --         if not vehicles[s] then
-- --             vehicles[s] = {}
-- --         end
-- --         table.insert(vehicles[s], {
-- --             owner = zPlayer.charId,
-- --             vehicle = {
-- --                 plate = tostring(plate),
-- --                 model = tonumber(model)
-- --             },
-- --             state = true,
-- --             changed = true
-- --         }) 
-- --     end
-- -- end, {'superadmin', 'admin'})

-- -- Command:Register('ownveh', {'Dodaj pojazd'}, function(xPlayer, args)
-- --     local s = tonumber(args[1])
-- --     local sql = "SELECT * FROM `owned_vehicles` WHERE JSON_SEARCH(vehicle, 'one', ?, NULL, '$.model') IS NOT NULL"


-- --     local result = Mysql.Sync:fetchAll(sql, {
-- --         s
-- --     })
-- --     if result and result[1] then
-- --         Log:Info('Vehicle owned')
-- --     end
-- -- end, {'superadmin', 'admin'})

-- -- Event:Register('dwb:tow:spawn', function(source, xPlayer,plate, cData, price)
-- --     local vehicle = GetVehicle(source, plate, true)
-- --     if vehicle then
-- --         local ped = GetPlayerPed(source)
-- --         local source = source
-- --         DeleteTowed(source, plate)
-- --         Vehicle:Spawn(vehicle.model, cData.spawnCoords, cData.heading, function(veh)
-- --             Entity(veh).state.data = {
-- --                 items = vehicle.items or {}
-- --             }
-- --             TaskEnterVehicle(ped, veh, 9000, -1, 1.0, 1, 0)
-- --             local netId = NetworkGetNetworkIdFromEntity(veh)
-- --             Event:TriggerNet('dwb:garage:spawn', source, vehicle, netId)
-- --         end)
-- --     else
-- --         Log:Info("Something sussy, player vehicle not found", source, plate)
-- --     end
-- -- end, true)

-- -- -- -- Thread:Create(function()
-- -- -- --     local time = 1000*60*3
-- -- -- --     while true do
-- -- -- --         Wait(time)
-- -- -- --         for k,v in pairs(GetAllVehicles()) do
-- -- -- --             if Entity(v).state.removeMe then

-- -- -- --             else
-- -- -- --                 local inVeh = false
-- -- -- --                 for i=-1, 9 do
-- -- -- --                     local ped = GetPedInVehicleSeat(v, i)
-- -- -- --                     if ped > 0 then
-- -- -- --                         inVeh = true
-- -- -- --                 end
-- -- -- --                 end
-- -- -- --             end
-- -- -- --         end
-- -- -- --     end
-- -- -- -- end)