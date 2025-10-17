Citizen.CreateThread(function()
    while true do
        local table = {}
        for k,v in pairs(DWB.Players) do
            if v then
                table[k] = {
                    data = {
                        coords = GetEntityCoords(GetPlayerPed(k)),
                        heading = GetEntityHeading(GetPlayerPed(k)),
                        recruter = v:HasLicense('wl'),
                        wl = v:GetChar('whitelist')
                    },
                    team = v:GetChar('team'),
                    name = v:GetChar('firstname')..' '..v:GetChar('lastname')
                }
            end
        end
        Event:TriggerNet('dwb:akagps:update', -1, table)
        Citizen.Wait(10000)
    end

end)