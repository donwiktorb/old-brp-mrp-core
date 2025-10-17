Garage = class(nil, nil, nil, User)

function Garage:SpawnByIndex(idx, coords, cb)
  local vehicle = self.vehicles[idx]
  self:Spawn(vehicle, coords, cb)
end

function Garage:Spawn(vehicleData, cData, cb)
  local vehicle = vehicleData.vehicle
  local source = self.source
  Vehicle:Spawn(vehicle.model, cData.spawnCoords, cData.heading, function(veh, netId)
    vehicleData.state = false
    Entity(veh).state.owner = source
    if cb then
      cb(veh, netId, vehicle, vehicleData)
    end
  end)
end

function Garage:DeleteByIndex(vehicle, vehicleData)
  local entityData = Entity(vehicle).state
  if entityData.owner == self.source then
    local veh = self.vehicles[entityData.id]
    if veh then
      for k, v in pairs(vehicleData) do
        veh.vehicle[k] = v
      end
      veh.changed = true
      self:Delete(vehicle, veh)
    end
  end
end

function Garage:Delete(vehicle, veh)
  veh.state = true
  DeleteEntity(vehicle)
end

function Garage:Load(cb)
  Mysql.Async:fetchAll("SELECT * FROM owned_vehicles WHERE owner = ? ORDER BY id", {
    self.charId,
  }, function(vehiclesMysql)
    for k, v in pairs(vehiclesMysql) do
      v.vehicle = json.decode(v.vehicle)
    end

    self.vehicles = vehiclesMysql
    if cb then
      cb()
    end
  end)
end

function Garage:GetVehicleByIdx(idx)
  return self.vehicles[idx]
end

function Garage:HasVehicleByPlate(plate)
  for k, v in pairs(self.vehicles) do
    if v.vehicle.plate == plate then
      return true
    end
  end
end

function Garage:AddVehicle(data, entity)
  table.insert(self.vehicles, {
    id = data.id or 0,
    state = data.state or 1,
    vehicle = data.vehicle,
    changed = true,
  })

  if entity then
    Entity(entity).state.owner = self.source
    Entity(entity).state.id = #self.vehicles
  end
end

function Garage:RemoveVehicle(data)
  local key = data.model and "model" or data.plate and "plate"
  local target = data.model or data.plate or data.id
  for k, v in pairs(self.vehicles) do
    if key and (v.vehicle[key] == target) or (v.id == target) then
      table.remove(self.vehicles, k)
      if v.id then
        Mysql.Async:Execute("DELETE FROM owned_vehicles WHERE id = ?", {
          v.id,
        })
      end
    end
  end
end

function Garage:RemoveVehicleByIdx(idx)
  local v = self.vehicles[idx]
  if v.id then
    Mysql.Async:Execute("DELETE FROM owned_vehicles WHERE id = ?", {
      v.id,
    })
  end
  table.remove(self.vehicles, idx)
end

function Garage:UpdateVehicle(data, vehData)
  local key = data.model and "model" or data.plate and "plate"
  local target = data.model or data.plate or data.id
  for k, v in pairs(self.vehicles) do
    if key and (v.vehicle[key] == target) or (v.id == target) then
      if vehData.vehicle then
        for k, v in pairs(vehData.vehicle) do
          v.vehicle[k] = v
        end
      end

      if vehData.owner then
        local vehicle = v
        vehicle.changed = true
        self.vehicles[key] = nil
        vehData.owner:AddVehicle(vehicle)
      end

      if vehData.state then
        v.state = vehData.state
      end
    end
  end
end

function Garage:Save(cb)
  local changedVehs = {}

  for k, v in pairs(self.vehicles) do
    if v.changed then
      table.insert(changedVehs, {
        v.id or 0,
        self.charId,
        v.state,
        json.encode(v.vehicle),
      })
      v.changed = nil
    end
  end

  if #changedVehs > 0 then
    Mysql.Async:Execute(
      "INSERT INTO owned_vehicles (id, owner, state, vehicle) VALUES ? ON DUPLICATE KEY UPDATE owner = VALUES(owner), state = VALUES(state), vehicle = VALUES(vehicle)",
      {
        {
          table.unpack(changedVehs),
        },
      },
      function(rowsChanged)
        if cb then
          cb()
        end
        --Log:Info('Saved vehs for ', self.source)
      end
    )
  end
end

function Garage:Unload(cb)
  self:Save(function()
    self.vehicles = nil
    if cb then
      cb()
    end
  end)
end
function Garage:Open(coords)
  Event:TriggerNet("dwb:garage:open", self.source, self.vehicles, coords)
end

function Garage:Close()
  Event:TriggerNet("dwb:garage:close", self.source)
end

function Garage:AddOfflineVehicle(data)
  Mysql.Async:Execute(
    "INSERT INTO owned_vehicles (id, owner, state, vehicle) VALUES ? ON DUPLICATE KEY UPDATE owner = VALUES(owner), state = VALUES(state), vehicle = VALUES(vehicle)",
    {
      {
        data,
      },
    }
  )
end
