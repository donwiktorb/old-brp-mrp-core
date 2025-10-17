Object = class()

function Object:CreateAsync(modelName, coords, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    local obj = CreateObject(model, coords.x, coords.y, coords.z, true,true, false)

    while not DoesEntityExist(obj) do
        print("waiting for object", model)
        Wait(0)
    end
    
    if cb then
        local objId = NetworkGetNetworkIdFromEntity(obj)
        cb(obj, objId)
    end
end

function Object:Create(modelName, coords, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    local object = CreateObject(model, coords.x, coords.y, coords.z, true, false)
    
    if cb then
        cb(object, id)
    end

end

function Object:Delete(obj)
    DeleteEntity(obj)
end

function Object:CreateAsync2(modelName, coords, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    local obj = CreateObjectNoOffset(model, coords.x, coords.y, coords.z, true,true, false)

    while not DoesEntityExist(obj) do
        print("waiting for object", model)
        Wait(0)
    end
    
    if cb then
        local objId = NetworkGetNetworkIdFromEntity(obj)
        cb(obj, objId)
    end
end