Mode = class()

function Mode:Join(lobby)
	Marker:Deactive("lobby")
	if lobby.data.map then
		if type(lobby.data.map) == "table" then
			for k, v in pairs(lobby.data.map) do
				if not IsIplActive(v) then
					Interior:Load(v)
				end
			end
		else
			if not IsIplActive(lobby.data.map) then
				Interior:Load(lobby.data.map)
			end
		end
	end
	User:Teleport(lobby.data.spawns[1])
	Event:TriggerNet("dwb:mode:join", lobby)
end
