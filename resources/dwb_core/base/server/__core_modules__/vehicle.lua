Vehicle = class()

function Vehicle:Spawn(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)

    local timeout = 500

    while not DoesEntityExist(vehicle) and timeout > 0 do
        Wait(0)
        timeout = timeout - 1
    end

    if timeout <= 0 then
        return Log:Info('Vehicle timeout', modelName)
    end

    local id      = NetworkGetNetworkIdFromEntity(vehicle)

    if cb then
        cb(vehicle, id)
    end

end

function Vehicle:Delete(vehicle)
	DeleteEntity(vehicle)
end

function Vehicle:SpawnServer(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    local vehicle = CreateVehicleServerSetter(model, 'automobile', coords, heading)

    local timeout = 500

    while not DoesEntityExist(vehicle) and timeout > 0 do
        Wait(0)
        timeout = timeout - 1
    end

    if timeout <= 0 then
        return Log:Info('Vehicle timeout', modelName)
    end

    local id      = NetworkGetNetworkIdFromEntity(vehicle)

    if cb then
        cb(vehicle, id)
    end

end