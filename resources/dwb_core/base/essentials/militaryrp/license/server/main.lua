
Command:Register('addlicense', {'license'}, function(xPlayer, args)
    if args[2] == 'license' then
        if xPlayer.data.group == 'superadmin' or xPlayer.data.group == 'admin' then
            local zPlayer = DWB.Players[tonumber(args[1])]
            if zPlayer and xPlayer:GetChar('team') == zPlayer:GetChar('team') then
                zPlayer:AddLicense(args[2])
            end
        end
    else
        if xPlayer:HasLicense('license') then
            local zPlayer = DWB.Players[tonumber(args[1])]
            zPlayer:AddLicense(args[2])
        end
    end
end)

Command:Register('removelicense', {'license'}, function(xPlayer, args)
    if args[2] == 'license' then
        if xPlayer.data.group == 'superadmin' or xPlayer.data.group == 'admin' then
            local zPlayer = DWB.Players[tonumber(args[1])]
            if zPlayer and xPlayer:GetChar('team') == zPlayer:GetChar('team') then
                zPlayer:RemoveLicense(args[2])
            end
        end
    else
        if xPlayer:HasLicense('license') then
            local zPlayer = DWB.Players[tonumber(args[1])]
            if zPlayer and xPlayer:GetChar('team') == zPlayer:GetChar('team') then
                zPlayer:RemoveLicense(args[2])
            end
        end
    end
end)

Command:Register('wl', {'wl'}, function(xPlayer, args)
    if xPlayer:HasLicense('wl') then
        local zPlayer = DWB.Players[tonumber(args[1])]
        zPlayer:SetChar('whitelist', true)
        Event:TriggerNet('dwb:team:whitelisted', tonumber(args[1]))
    end
end)

Callback:Register('dwb:check:license', function(source, cb, license)
    local player = DWB.Players[source]
    cb(player:HasLicense(license))
end)