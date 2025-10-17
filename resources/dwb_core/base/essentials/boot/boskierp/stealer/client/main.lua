


local blip
local vehicle

local vehName
local streetName
Event:Register('dwb:stealer:accept', function(veh2, coords, netId)
    -- -- while not NetworkDoesEntityExistWithNetworkId(netId) do
    -- --     Wait(0)
    -- --    print('no net') 
    -- -- end
    local vehicle2 = NetworkGetEntityFromNetworkId(netId)
    local model = veh2.model
    local name = GetDisplayNameFromVehicleModel(model)
    vehName = name
    local offsetX = math.random(-50, 50)
    local offsetY = math.random(-50, 50)
    local offsetZ = math.random(-50, 50)
    local coord = coords[1]
    blip = AddBlipForRadius(coord.x + offsetX, coord.y + offsetY, coords.z, 300.0) 
    local street, crossing = GetStreetNameAtCoord(coord.x, coord.y, coord.z)
    local streetName2 = GetStreetNameFromHashKey(street)
    streetName = streetName2

    Notification:ShowCustom('info', TR("stealer"), TR("stealer_vehicle", name, streetName))

    vehicle = true

    -- if DoesEntityExist(vehicle2) then
    --     Cam:CinameticVehicle(vehicle2, coords)
    -- end

end, true)

Event:Register('dwb:stealer:deny', function()
    RemoveBlip(blip)
    vehicle = nil
    blip = nil 
end, true)

local stealin = false

function startStealer()
    Event:TriggerNet('dwb:outlaw:notify', 'carthief_start', false, vehName, streetName)
    stealin = not stealin
    if stealin then
        Thread:Create(function()
            while stealin do
                Wait(5000)
                Event:TriggerNet('dwb:outlaw:notify', 'carthief', false, vehName, streetName)
            end
        end)
    end
end

Event:Register('dwb:player:vehicle:enter', function(veh, seat)
    if vehicle and Entity(veh).state.stealer == GetPlayerServerId(PlayerId()) then
        vehicle = nil
        FreezeEntityPosition(veh, false)
        RemoveBlip(blip)
        blip = nil
        Notification:ShowCustom('info', TR("stealer"), TR("stealer_content"))
        -- Event:TriggerNet('dwb:stealer:notify', vehName, streetName)
        -- Event:TriggerNet('dwb:outlaw:notify', 'carthief', vehName, streetName)
        UI:Open('Bar', {
            name = 'steler',
            time = 60,
            show = true,
            task = "Odłączasz gps",
            forceOpen = true,
            forceClose = true
        }, function(data,menu)
            menu.close()

        startStealer()
        
        end)
        startStealer()
    end
end)