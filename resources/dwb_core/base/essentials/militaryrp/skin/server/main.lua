Callback:Register('dwb:skin:getPlayerSkin', function(source, cb) 
	local xPlayer = DWB.Players[source]
    local sex = xPlayer:GetChar('sex')
    local skin = json.encode(xPlayer:Get('skin'))
    skin = skin ~= '{}' and json.decode(skin) or nil
    cb(skin, sex)

	-- Mysql.Async:fetch('SELECT data, skin FROM characters WHERE id = ?', {
	-- 	xPlayer.charId
	-- }, function(res)
	-- 	local user, skin, sex = res

	-- 	if user.skin then
	-- 		skin = user.skin ~= '{}' and json.decode(user.skin) or nil
	-- 	end

    --     if not skin then
    --         sex = json.decode(user.data).sex
    --     end

	-- 	cb(skin, sex)
	-- end)
end)

Event:Register('dwb:skin:save', function(skin)
	local xPlayer = DWB.Players[source]
    xPlayer:Set('skin', skin)
	-- Mysql.Async:Execute('UPDATE characters SET skin = ? WHERE id = ?', {
	-- 	json.encode(skin),
	-- 	xPlayer.charId
	-- })
end, true)

Command:Register('skin', {'skin'}, function(xPlayer, a)
    TriggerClientEvent('dwb:skin:openMenu', a[1])
end, {'superadmin', 'admin'})