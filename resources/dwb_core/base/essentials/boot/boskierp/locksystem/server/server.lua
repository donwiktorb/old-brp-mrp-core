
local vehicles = {}

function GetVehicleOwnerByPlate(plate)

    for k,v in pairs(vehicles) do
        if v[plate] then
            return k
        end
    end

    return false
end

Config.Msgs =  {
    'Znalazłeś kluczyki w schowku.',
    'Znalazłeś kluczyki w stacyjce.'
}

Event:RegisterCb('dwb:ls:check:owned', function(source, cb, plate, inVeh)
    if plate then
    
        if vehicles[source] and vehicles[source][plate] then
            cb(true)
        else
            local owner = GetVehicleOwnerByPlate(plate)
            if not owner then
                if inVeh then
                    if not vehicles[source] then vehicles[source] = {} end
                    vehicles[source][plate] = true
                    Event:TriggerNet('dwb:notify:custom', source, "info", "Kluczyki", Config.Msgs[math.random(1, #Config.Msgs)])
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false) 
            end
        end
    else
        Event:TriggerNet('dwb:notify:custom', source, "info", "Kluczyki", "Nie znaleziono rejestracji.")
        cb(false)
    end
end)

Event:Register('dwb:player:dropped', function(source)
    if vehicles[source] then
	    vehicles[source] = nil
    end
end)

function getClosestVehicleWithPlate(coords, radius, plate)
    for k,v in pairs(GetAllVehicles()) do
        local dist = #(GetEntityCoords(v)-coords)
        if dist <= radius then
            local plate2 = Math:Trim(GetVehicleNumberPlateText(v))
            if plate == plate2 then
                return v
            end
        end
    end
end

Item:RegisterUsable('car_keys', function(source)
    local xPlayer = DWB.Players[source]
    local item = xPlayer:GetInventoryItem('car_keys')
    if item then
        local ped = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~=0 then
            local plate = Math:Trim(GetVehicleNumberPlateText(vehicle))
            if item.data and plate == item.data.plate then
                Event:TriggerNet('dwb:keys:engine', source)
            end
        else
            local veh = getClosestVehicleWithPlate(GetEntityCoords(ped), 5.0, item.data.plate)
            if veh then
                local locked = GetVehicleDoorLockStatus(veh)
                if locked == 1 or locked==0 then
                    SetVehicleDoorsLocked(veh, 4)
                    Event:TriggerNet('dwb:keys:lock', source, true)
                else
                    SetVehicleDoorsLocked(veh,  1)
                    Event:TriggerNet('dwb:keys:lock', source, false)
                end 
            end
        end
    end
end)