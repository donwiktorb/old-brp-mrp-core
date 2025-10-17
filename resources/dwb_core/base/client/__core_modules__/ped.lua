Ped = class()

function Ped:Create(name, data, cb)
    Stream:RequestModel(data.ped.modelHash, function()
        local ped = CreatePed(data.ped.type, data.ped.hash, data.ped.coords, data.ped.heading, data.ped.network or false, data.ped.bScriptHostPed or false)
        if not DWB.Peds[name] then DWB.Peds[name] = {} end
        data.ped.ped = ped
        table.insert(DWB.Peds[name], data)
        if cb then return cb(ped, #DWB.Peds[name]) end
        return ped, #DWB.Peds[name]
    end)
end

function Ped:RemoveAll(name)
    for k,v in pairs(DWB.Peds[name]) do
        for n,m in pairs(v) do
            -- SetEntityAsNoLongerNeeded(m.ped.ped)  
            DeletePed(m.ped.ped)
        end
    end
    DWB.Peds[name] = nil 
end

function Ped:GetClosest(coords, radius, check)
    local handle, ped = FindFirstPed()
    local success
    local inDistance = false
    local playerPed = PlayerPedId()

    while not success and not inDistance do
        Citizen.Wait(0)
        success, ped = FindNextPed(handle)
        if check then
            if check(ped) then inDistance = true end 
        else 
            if #(GetEntityCoords(ped) - coords) <= radius and ped ~= playerPed then
                inDistance = true      
            end     
        end
    end

    EndFindPed(handle)

    return success, ped
end

function Ped:IsType(ped, _type)
    local pedType = GetPedType(ped)
    if type(_type) == 'table' then
        for k,v in pairs(_type) do
            if v == pedType then
                return true
            end
        end
    else
        if _type == pedType then
            return true
        end
    end
end

function Ped:GetMugshot(ped, transparent)
    if not DoesEntityExist(ped) then
        return
    end

    local handle = transparent and RegisterPedheadshotTransparent(ped) or RegisterPedheadshot(ped)
   
    local timeout = 4

    while not IsPedheadshotReady(handle) and timeout > 0 do
        timeout = timeout -1
    	Citizen.Wait(1000)
    end

    local txd = GetPedheadshotTxdString(handle)
    return handle, txd
end
