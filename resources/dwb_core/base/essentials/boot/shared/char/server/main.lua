Event:Register("dwb:char:choose", function(source, xPlayer, charId)
	local charId = charId
	local _xPlayer = xPlayer

	_xPlayer:LoadChar(charId, function()
		Player(_xPlayer.source).state.data = xPlayer
		_xPlayer:CharLoaded()
	end)
end, true)

Event:Register("dwb:char:new", function(source, xPlayer, _charData)
	local charData = {
		data = _charData,
		inventory = Table:Copy(Config.Default.PlayerData.inventory),
	}

	local _xPlayer = xPlayer

	_xPlayer:CreateChar(charData, function(charId)
		charData.id = charId
		_xPlayer:LoadCharFromData(charId, charData, function()
			Player(_xPlayer.source).state.data = _xPlayer
			_xPlayer:CharLoaded(true)
		end)
	end)
end, true)
