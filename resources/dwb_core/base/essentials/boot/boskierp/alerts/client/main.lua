local lastCoords = vec3(0, 0, 0)

-- -- Event:Register('dwb:outlaw:drugs', function(coords)
-- --     -- -- local coords = DWB.PlayerData.Coords
-- --     local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
-- --     local sName = GetStreetNameFromHashKey(street)
-- --     local cName
-- --     if crossing ~= 0 then
-- --         cName = GetStreetNameFromHashKey(crossing)
-- --     end

-- --     if not cName then
-- --         Notification:ShowCustom('info', TR("drug_title"), TR("outlaw_drug", sName))
-- --     else
-- --         Notification:ShowCustom('info', TR("drug_title"), TR("outlaw_drug2", sName, cName))
-- --     end

-- --     local transG = 250
-- --     local blip = AddBlipForRadius(coords, 50.0)
-- --     SetBlipSprite(blip,  9)
-- --     SetBlipColour(blip,  1)
-- --     SetBlipAlpha(blip,  transG)
-- --     SetBlipAsShortRange(blip,  true)
-- --     BeginTextCommandSetBlipName("STRING")
-- --     AddTextComponentString(TR("drug_title"))
-- --     EndTextCommandSetBlipName(blip)

-- --     local blip2 = AddBlipForCoord(coords)
-- --     SetBlipSprite(blip2,  119)
-- --     SetBlipColour(blip2,  1)
-- --     SetBlipAlpha(blip2,  transG)
-- --     SetBlipAsShortRange(blip2,  true)
-- --     SetBlipScale(blip2,1.0)
-- --     BeginTextCommandSetBlipName("STRING")
-- --     AddTextComponentString(TR("drug_title"))
-- --     EndTextCommandSetBlipName(blip2)

-- --     while transG ~= 0 do
-- --         Wait(160)
-- --         transG = transG - 1
-- --         SetBlipAlpha(blip,  transG)
-- --         SetBlipAlpha(blip2,  transG)
-- --         if transG == 0 then
-- --             RemoveBlip(blip)
-- --             RemoveBlip(blip2)
-- --             return
-- --         end
-- --     end

-- -- end, true)

-- -- Event:Register('dwb:outlaw:shooting', function(coords, sName, cName)
-- --     if not cName then
-- --         Notification:ShowCustom('info', TR("shooting_title"), TR("outlaw_shooting", sName))
-- --     else
-- --         Notification:ShowCustom('info', TR("shooting_title"), TR("outlaw_shooting2", sName, cName))
-- --     end

-- --     local dist = #(coords-lastCoords)

-- --     lastCoords=  coords

-- --     if dist <= 100.0 then
-- --         local transG = 250
-- --         local blip = AddBlipForRadius(coords, 50.0)
-- --         SetBlipSprite(blip,  9)
-- --         SetBlipColour(blip,  1)
-- --         SetBlipAlpha(blip,  transG)
-- --         SetBlipAsShortRange(blip,  true)
-- --         BeginTextCommandSetBlipName("STRING")
-- --         AddTextComponentString('10-71')
-- --         EndTextCommandSetBlipName(blip)

-- --         local blip2 = AddBlipForCoord(coords)
-- --         SetBlipSprite(blip2,  119)
-- --         SetBlipColour(blip2,  1)
-- --         SetBlipAlpha(blip2,  transG)
-- --         SetBlipAsShortRange(blip2,  true)
-- --         SetBlipScale(blip2,1.0)
-- --         BeginTextCommandSetBlipName("STRING")
-- --         AddTextComponentString('10-71')
-- --         EndTextCommandSetBlipName(blip2)

-- --         while transG ~= 0 do
-- --             Wait(160)
-- --             transG = transG - 1
-- --             SetBlipAlpha(blip,  transG)
-- --             SetBlipAlpha(blip2,  transG)
-- --             if transG == 0 then
-- --                 RemoveBlip(blip)
-- --                 RemoveBlip(blip2)
-- --                 return
-- --             end
-- --         end

-- --     else
-- --         local transG = 250
-- --         local blip = AddBlipForCoord(coords)
-- --         SetBlipSprite(blip,  119)
-- --         SetBlipColour(blip,  1)
-- --         SetBlipAlpha(blip,  transG)
-- --         SetBlipAsShortRange(blip,  true)
-- --         SetBlipScale(blip,1.0)
-- --         BeginTextCommandSetBlipName("STRING")
-- --         AddTextComponentString('10-71')
-- --         EndTextCommandSetBlipName(blip)
-- --         while transG ~= 0 do
-- --             Wait(160)
-- --             transG = transG - 1
-- --             SetBlipAlpha(blip,  transG)
-- --             if transG == 0 then
-- --                 RemoveBlip(blip)
-- --                 return
-- --             end
-- --         end
-- --     end

-- -- end, true)

Thread:Create(function()
	local areas = {
		{
			coords = vec3(0, 0, 0),
			radius = 10.0,
			chance = 4, -- 25% 1/4
		},
	}
	local weapons = {
		[`weapon_stungun`] = true,
	}
	local last = {
		street = nil,
		crossing = nil,
	}
	while true do
		Wait(0)
		if DWB.PlayerData.HasWeapon and DWB.PlayerData.IsShooting then
			if not IsPedCurrentWeaponSilenced(DWB.PlayerData.Ped) then
				local coords = DWB.PlayerData.Coords
				local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)

				if last.street ~= street and last.crossing ~= crossing then
					last = {
						street = street,
						crossing = crossing,
					}

					local InArea = false

					for k, v in pairs(areas) do
						local dist = #(v.coords - coords)
						if dist <= v.radius then
							if v.chance then
								local x = math.random(1, v.chance)
								if x == 1 then
									InArea = true
								end
							else
								InArea = true
							end
							break
						end
					end

					if not InArea then
						local streetName = GetStreetNameFromHashKey(street)
						local crossingName = GetStreetNameFromHashKey(crossing)
						if crossing ~= 0 then
							Event:TriggerNet("dwb:outlaw:notify", "shooting", coords, streetName, crossingName)
						else
							Event:TriggerNet("dwb:outlaw:notify", "shooting", coords, streetName)
						end
						Wait(5000)
					end
				end
			end
		end
	end
end)

local outBlips = {}

Thread:Create(function()
	while true do
		Wait(250)
		for k, v in pairs(outBlips) do
			if not v.noRemove then
				v.trans = v.trans - 1

				SetBlipAlpha(v.blip, v.trans)

				if v.trans == 0 then
					RemoveBlip(v.blip)
					table.remove(outBlips, k)
				end
			end
		end
	end
end)

function outlawBlip(blipData, coords)
	local blip

	if not blipData.type then
		blip = AddBlipForCoord(coords)
	else
		blip = AddBlipForRadius(coords, blipData.radius)
	end

	if blipData.sprite then
		SetBlipSprite(blip, blipData.sprite)
	end

	SetBlipColour(blip, blipData.color)
	SetBlipAlpha(blip, 250)
	SetBlipAsShortRange(blip, blipData.shortRange)
	SetBlipScale(blip, blipData.scale)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blipData.label)
	EndTextCommandSetBlipName(blip)

	table.insert(outBlips, {
		blip = blip,
		data = blipData,
		trans = blipData.trans or 250,
		noRemove = blipData.noRemove,
	})
end

Event:Register("dwb:outlaw:notify", function(name, coords, ...)
	local args = { ... }
	local outlaw = Config.Alerts[name]
	local notify = outlaw.notify

	if notify then
		if notify.custom then
			Notification:ShowCustom(notify.type, notify.title, { ... })
		else
			if type(notify.content) == "table" then
				local notifyContent = notify.content[#args] or notify.content[1]
				Notification:ShowCustom(notify.type, notify.title, TR(notifyContent, ...))
			else
				Notification:ShowCustom(notify.type, notify.title, notify.content)
			end
		end
	end

	local blip = outlaw.blip

	local distBlip = outlaw.distBlip

	if distBlip then
		local dist = #(coords - lastCoords)

		lastCoords = coords

		if dist <= outlaw.minDist then
			outlawBlip(distBlip, coords)
			if outlaw.showBoth and blip then
				outlawBlip(blip, coords)
			end
		else
			if blip then
				outlawBlip(blip, coords)
			end
		end
	else
		if blip then
			outlawBlip(blip, coords)
		end
	end
end, true)

