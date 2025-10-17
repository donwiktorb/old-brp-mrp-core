local drivin = false

Event:Register('dwb:taxi:search', function(posData)
    drivin = false
    local found = false
    for k,v in pairs(DWB.PlayerData.ClosestPeds) do
        if NetworkHasControlOfEntity(v.ped) then
            found = v
        end
    end

    if found then
        SetBlockingOfNonTemporaryEvents(found.ped, true)
        TaskEnterVehicle(found.ped, DWB.PlayerData.Vehicle, 5000, 2, 1.0,1)
        Wait(5000)

        local b = GetClosestBlipOfType(math.random(1,700))
        while b <= 0 do
            Wait(0) 
            b = GetClosestBlipOfType(math.random(1, 700))
        end
        SetBlipRoute(b, true)
        local dest = GetBlipCoords(b)
        drivin = true
        local totalDist = #(DWB.PlayerData.Coords-dest)
        Thread:Create('taxi', function()
            while drivin do
                Wait(0)
                local dist = #(DWB.PlayerData.Coords-dest)
                if dist <= 25.0 then
                    SetBlockingOfNonTemporaryEvents(found.ped, false)
                    TaskLeaveVehicle(found.ped)
                    Event:TriggerNet('dwb:taxi:pay', totalDist)
                    Wait(1000)
                    DeleteEntity(found.ped)
                    drivin = false
                    SetBlipRoute(b, false)
                end
            end
        end)
    else

        Notification:ShowCustom('info', 'Taxi', 'Nie znaleziono')
    end
end, true)