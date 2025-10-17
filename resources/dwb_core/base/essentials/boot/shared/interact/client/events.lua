Event:Register("dwb:interact:load", function(markers, cursor, pickups, settings)
	if not settings or settings.unloadLast then
		Interact.Markers:Unload()
		Interact.Pickups:Unload()
		Interact.Cursor:Unload()
	end
	Interact.Markers:Load(markers)
	Interact.Cursor:Load(cursor)
	Interact.Pickups:Load(pickups)
end, true)

Event:Register("dwb:markers:load", function(markers)
	while not DWB.PlayerData.char do
		Wait(0)
	end
	Interact.Markers:Load(markers)
end, true)

User:OnSyncCharData(function(self, key, value)
	while not Interact.Markers.loaded do
		Wait(0)
	end

	Interact.Markers:Refresh()
end)

Event:Register("dwb:markers:unload", function(markers)
	Interact.Markers:Unload()
end, true)

Event:Register("dwb:markers:edit", function(target, dataOrCb)
	Interact.Markers:Edit(target, dataOrCb)
end, true)

Event:Register("dwb:markers:add", function(data)
	Interact.Markers:Add(data)
end, true)

Event:Register("dwb:markers:remove", function(data)
	Interact.Markers:Remove(data)
end, true)
