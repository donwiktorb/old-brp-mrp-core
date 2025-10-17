Data = class()

function Data:Create(name, data)
    if not server then return end
    SaveResourceFile(GetCurrentResourceName(), 'base/data/'..name, data)
end

function Data:GetDataFromFile(name)
    return LoadResourceFile(GetCurrentResourceName(), 'base/data/'..name)
end

function Data:Reload()
    CachedData = json.decode(LoadResourceFile(GetCurrentResourceName(), 'base/data/data.json')) or {}
end

function Data:Save()
    if not server then return end
    SaveResourceFile(GetCurrentResourceName(), 'base/data/data.json', CachedData)
end

function Data:Add(key, value)
    CachedData[key] = value
    Data:Save()
end

function Data:Get(key)
    return CachedData[key]
end

function Data:Remove(key)
    CachedData[key] = nil
    Data:Save()
end