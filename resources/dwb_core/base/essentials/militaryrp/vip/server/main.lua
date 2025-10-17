RegisterCommand('setvip', function(s,a,r)
    local id = a[1]
    print('vip for '..id)
    local xPlayer = DWB.Players[id]
    if xPlayer then
        xPlayer:SetData('vip', true)
    else
        Wait(5000)
        xPlayer = DWB.Players[id]
        if xPlayer then
            xPlayer:SetData('vip', false)
        end
    end
end, true)

RegisterCommand('remvip', function(s,a,r)
    local id = a[1]
    print('vip for '..id)
    local xPlayer = DWB.Players[id]
    if xPlayer then
        xPlayer:SetData('vip', false)
    else
        Wait(5000)
        xPlayer = DWB.Players[id]
        if xPlayer then
            xPlayer:SetData('vip', false)
        end
    end
end, true)

Event:Register('dwb:player:loaded', function(source, xPlayer)
    local data = Discord:GetUserData(source)
    if data and data.inDiscord and data.isBooster then
        xPlayer:SetData('vip', true)
    end
end)
