
Command:Register('addlicense', {'license'}, function(xPlayer, args)
    if xPlayer.data.group or xPlayer:HasLicense('license') then 
        local zPlayer = DWB.Players[tonumber(args[1])]
        if zPlayer then
            zPlayer:AddLicense(args[2])
        end
    end
end)

Command:Register('removelicense', {'license'}, function(xPlayer, args)
    if xPlayer.data.group or xPlayer:HasLicense('license') then
        local zPlayer = DWB.Players[tonumber(args[1])]
        if zPlayer then
            zPlayer:RemoveLicense(args[2])
        end
    end
end)
