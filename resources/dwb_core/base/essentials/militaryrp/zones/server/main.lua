local zones = Config.Zones.Zones

for k, v in pairs(zones) do
	if not v.players then
		v.players = {}
	end
end

function removePlayer(source)
	for k, v in pairs(zones) do
		if v.players[source] then
			v.players[source] = nil
		end
	end
end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1000)
--         for k,v in pairs(zones) do
--             if v.owned then
--                 print(json.encode(v, {ident = true}))
--             end
--         end
--     end
-- end)

Event:Register("dwb:player:died", function(data)
	if data and data.killerServerId then
		local xPlayer = DWB.Players[data.killerServerId]
		if xPlayer then
			xPlayer:AddInventoryItem(nil, "money", 10)
		end
	end
end, true)

function getZone(name)
	for k, v in pairs(zones) do
		if v.name == name then
			return k, v
		end
	end
end

function getOwned(source)
	for k, v in pairs(zones) do
		if v.owned and v.owned.source == source then
			return k, v
		end
	end
end

Event:Register("dwb:zones:sync:blip", function()
	local zn = {}
	for k, v in pairs(zones) do
		if v.owned then
			table.insert(zn, {
				name = v.name,
				team = v.owned.team,
			})
		end
	end

	Event:TriggerNet("dwb:zones:sync:blip", source, zn)
end, true)

Event:Register("dwb:zones:enter", function(zone, team)
	local k, zn = getZone(zone)
	if zn then
		zn.players[source] = team
	end
end, true)

Event:Register("dwb:zones:owned", function(zone, team)
	local k, zn = getZone(zone)
	if zn then
		if zn.owned then
			local zPlayer = DWB.Players[zn.owned.source]
			if zPlayer then
				zPlayer:AddInventoryItem(nil, "money", 250)
			end
		end
		for k2, v in pairs(zn.players) do
			if v == team then
				local xPlayer = DWB.Players[k2]
				if xPlayer then
					xPlayer:AddInventoryItem(nil, "money", 250)
				else
					zn.players[k2] = nil
				end
			end
		end
		zn.owned = nil
		zn.disabled = true
		Event:TriggerNet("dwb:zones:blip", -1, zone, team)
		Event:TriggerNet(
			"dwb:show:notify",
			-1,
			"warn",
			"Strefy",
			"Strefa " .. zone .. " została przejęta przez " .. team .. "!"
		)
		Timer:Add(function()
			zn.disabled = nil
			-- Event:TriggerNet('dwb:zones:blip', -1, zone, 'NONE')
			Event:TriggerNet(
				"dwb:show:notify",
				-1,
				"success",
				"Strefy",
				"Strefa " .. zone .. " jest dostępna do przejęcia!"
			)
		end, 60 * 1000 * 7)
	end
end, true)

Event:Register("dwb:zones:clear:owned", function(zone, team)
	local k, zn = getZone(zone)
	if zn then
		zn.owned = nil
	end
end, true)

Event:Register("dwb:zones:take", function(zone, team)
	local k, zn = getZone(zone)
	if zn and not zn.owned and not zn.disabled then
		zn.owned = {
			team = team,
			source = source,
		}
		Event:TriggerNet("dwb:zones:take", source, zone, team)
	end
end, true)

Event:Register("dwb:player:died", function(data)
	local k, owned = getOwned(source)

	if owned and owned.owned then
		zones[k].owned = nil
	end
end, true)

Event:Register("dwb:zones:exit", function(zone, team)
	local k, zn = getZone(zone)
	if zn then
		if zn.owned and zn.owned.source == source then
			zn.owned = nil
		end
		zn.players[source] = nil
	end
end, true)

Event:Register("dwb:player:dropped", function(source, xPlayer, Reason)
	removePlayer(source)
end)

