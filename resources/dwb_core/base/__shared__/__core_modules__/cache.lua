Cache = class()

function Cache:Add(key, value)
    Temp[key] = value
end

function Cache:Remove(key)
    Temp[key] = nil
end

function Cache:Get(key)
    return Temp[key]
end

function Cache:AddTemp(key, value, time)
    Temp[key] = value

    SetTimeout(time*1000, function()
        Cache:Remove(key)
    end)


end