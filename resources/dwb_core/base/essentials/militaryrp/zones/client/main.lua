local blips = {}
local colors = {
	["USA"] = 29,
	["RU"] = 75,
	["EQUAL"] = 66,
	["ISIS"] = 23,
	["NONE"] = 34,
}

function TakeZone(zone, team)
	UI:Open("Bar", {
		name = "zone",
		task = "Przejmowanie strefy",
		time = 60 * 2,
	}, function(data, menu)
		-- Timer:Add(function()
		if not IsPedInAnyVehicle(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			Event:TriggerNet("dwb:zones:owned", zone, team)
		else
			Event:TriggerNet("dwb:zones:clear:owned", zone, team)
		end
		-- end, 60*1000*0.10)
	end)
end

Event:Register("dwb:zones:state", function(name)
	for k, v in pairs(Config.Zones.Zones) do
		if v.name == name then
			v.disable = not v.disable
		end
	end
end, true)

Event:Register("dwb:zones:sync:blip", function(zn)
	for k, v in pairs(blips) do
		for k2, v2 in pairs(zn) do
			if v.zone == v2.name then
				SetBlipColour(v.blip --[[ Blip ]], colors[v2.team])
			end
		end
	end
end, true)

Event:Register("dwb:zones:blip", function(zone, team)
	for k, v in pairs(blips) do
		if v.zone == zone then
			SetBlipColour(v.blip --[[ Blip ]], colors[team])
		end
	end
end, true)

Event:Register("dwb:zones:take", function(zone, team)
	TakeZone(zone, team)
end, true)

Event:Register("dwb:team:chosen", function(team, whitelist)
	Marker:Add("zones", {
		messages = {},
		marker = {
			-- type = 28,
			-- color = {
			--     r = 20,
			--     g = 222,
			--     b = 222,
			--     a = 222
			-- },
			-- animate = true
		},
		settings = {
			drawDist = 200,
			alwaysOn = true,
			radius = 40,
			overrideCoords = true,
			drawMarker = false,
		},
		coords = Config.Zones.Zones,
		functions = {
			onClickCb = function(zone, pos)
				if
					pos.name
					and team
					and not pos.disable
					and not IsPedInAnyVehicle(PlayerPedId())
					and not IsEntityDead(PlayerPedId())
				then
					Event:TriggerNet("dwb:zones:take", pos.name, team)
				end
			end,
			onEnterCb = function(zone, pos)
				if pos.name and team and not pos.disable and not IsPedInAnyVehicle(PlayerPedId()) then
					Event:TriggerNet("dwb:zones:enter", pos.name, team)
				end
			end,
			onExitCb = function(zone, pos)
				if pos.name and team and not pos.disable then
					Event:TriggerNet("dwb:zones:exit", pos.name, team)
				end
			end,
		},
	})

	for k, v in pairs(Config.Zones.Zones) do
		createBlipZone(v.label, v.name, v.pos, v.radius)
	end

	Event:TriggerNet("dwb:zones:sync:blip", team)
end, true)

function createBlipZone(name, zone, coords, radius)
	local radius = radius * 4 or 20
	local blip = AddBlipForRadius(coords, radius + 0.0)

	SetBlipSprite(blip, 9)
	SetBlipColour(blip --[[ Blip ]], 47)
	SetBlipAsShortRange(blip, true)
	SetBlipAlpha(blip, 80)

	-- SetBlipRotation(blip, math.ceil(data.heading))
	-- SetBlipNameToPlayerName(blip, id)
	-- SetBlipScale(blip, 0.85) -- set scale

	-- BeginTextCommandSetBlipName("STRING")

	-- AddTextComponentString("! "..name)

	-- EndTextCommandSetBlipName(blip)

	table.insert(blips, {
		blip = blip,
		zone = zone,
	}) -- add blip to array so we can remove it later
end

