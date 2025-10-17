Citizen.CreateThread(function()
    while true do
        local vehs = GetAllVehicles()
        for k,v in pairs(vehs) do
            if GetVehicleBodyHealth(v) == 0.0 then
                DeleteEntity(v)
            end
        end
        Wait(60000)
    end
end)