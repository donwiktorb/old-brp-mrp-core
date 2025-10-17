Event:RegisterCb('dwb:skin:getPlayerSkin', function(source, cb) 
	local xPlayer = DWB.Players[source]
    local sex = xPlayer:GetChar('sex')
    local skin = json.encode(xPlayer:Get('skin'))
    skin = skin ~= '{}' and json.decode(skin) or nil
    cb(skin, sex)
end)

Event:Register('dwb:skin:save', function(source, xPlayer,skin)
    xPlayer:SetChar('skin', skin)
end, true)

Command:Register('skin', {'skin'}, function(xPlayer, a)
    Event:TriggerNet('dwb:skin:open', a[1] and a[1] or xPlayer.source)
end, {})