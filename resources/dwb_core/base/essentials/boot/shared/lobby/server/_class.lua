Lobby = class(Config.Lobby)
function Lobby:Init()
	for i = 1, Config.Lobby.numLobbies do
		table.insert(Config.Lobby.Lobbies, {
			label = string.format("Lobby #%s", i),
			players = {},
			enabled = true,
			bucket = i,
		})
	end
end
function Lobby:GetLobbyId()
	local lowestPlayerCountLobbyId = 0
	local lowestPlayerCount
	for k, v in pairs(Config.Lobby.Lobbies) do
		if not lowestPlayerCount then
			lowestPlayerCountLobbyId = k
			lowestPlayerCount = #v.players
		end
		if #v.players < lowestPlayerCount then
			lowestPlayerCount = #v.players
			lowestPlayerCountLobbyId = k
		end
	end

	return lowestPlayerCountLobbyId, lowestPlayerCount
end

function Lobby:SetPlayerLobby(source, lobby)
	if lobby then
		SetPlayerRoutingBucket(source, lobby)
	else
		local lobby, lobbyCount = self:GetLobbyId()
		SetPlayerRoutingBucket(source, lobby)
	end
end
function Lobby:GetModePlayers(mode)
	local players = {}
	if mode then
		for k, v in pairs(DWB.Players) do
			if v.data.mode == mode then
				table.insert(players, v.source)
			end
		end
	else
		for k, v in pairs(DWB.Players) do
			if v.data.mode then
				table.insert(players, v.source)
			end
		end
	end
	return players
end
function Lobby:RemovePlayer(player)
	for k, v in pairs(Config.Lobby.Lobbies) do
		for k4, v4 in pairs(v.players) do
			if v4 == player then
				table.remove(v.players, k4)
			end
		end
	end
end
function Lobby:Refresh()
	for k, v in pairs(Config.Lobby.Lobbies) do
		for k4, v4 in pairs(v.players) do
			Event:TriggerNet("dwb:lobby:refresh", v4, Config.Lobby.Modes)
		end
	end
end

function Lobby:GetLobbyPlayers()
	local players = {}

	for k, v in pars(Config.Lobby.Lobbies) do
		for k4, v4 in pairs(v.players) do
			table.insert(players, v4)
		end
	end
	return players
end

Lobby:Init()
