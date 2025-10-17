Event:Register("dwb:open:skin:shop", function(elements, _item, _count)
	local item = _item
	local count = _count
	Event:TriggerCb("dwb:has:enough:item", function(bought)
		if bought then
			Notification:ShowCustom("info", TR("clotheshop"), TR("set_in_place_and_wait_10_seconds"))

			Wait(10000)
			Skinchanger:SaveSkin()
			Event:Trigger("dwb:skin:open:restricted", function(data, menu)
				menu.close()

				Event:TriggerCb("dwb:has:enough:item", function(bought)
					if bought then
						local skin = Skinchanger:GetSkin()
						Event:TriggerNet("dwb:skin:save", skin)
						Event:TriggerNet("dwb:shop:pay", item, count)
					else
						Skinchanger:RestoreSkin()
						-- Event:TriggerCb('dwb:skin:getPlayerSkin', function(skin)
						--     Skinchanger:LoadSkin(skin)
						-- end)
						Notification:ShowCustom("info", "Sklep", TR("not_enough_money", Math:Format(count)))
					end
				end, item, count)
			end, function(data, menu)
				menu.close()
			end, elements or {
				"hair_1",
				"hair_2",
				"hair_color_1",
				"hair_color_2",
				"beard_1",
				"beard_2",
				"beard_3",
				"beard_4",
				"chest_1",
				"chest_2",
				"chest_3",
			})
		else
			Notification:ShowCustom("info", "Sklep", TR("not_enough_money", Math:Format(count)))
		end
	end, item, count)
end, true)

Event:Register("dwb:shop:rob", function(data, zone, pos)
	local rob = true
	local timer = data.time
	local robbed = true
	Thread:Create(function()
		while timer > 0 do
			Wait(1000)
			timer = timer - 1
		end
		rob = false
	end)

	Thread:Create(function()
		while rob do
			Wait(0)
			Text:Draw(timer, {
				x = 0.7,
				y = 0.9,
				font = 7,
				size = 3,
			})
			local dist = #(DWB.PlayerData.Coords - pos.pos)
			local maxDist = data.maxDist or 10.0
			if dist > maxDist then
				robbed = false
				rob = false
				timer = 0
				Event:TriggerNet("dwb:shop:stopped", data, zone, pos)
			end
		end
		if robbed then
			Event:TriggerNet("dwb:shop:robbed", data, zone, pos)
		end
	end)
end, true)

-- -- RegisterCommand('naped', function()
-- --     local obj  = GetClosestObjectOfType(DWB.PlayerData.Coords, 5.0, `v_ilev_gb_vauldr`, true, true, true)

-- --     if DoesEntityExist(obj) then
-- --         local coords = GetOffsetFromEntityInWorldCoords(obj, 0.0, -1.0, -0.5)

-- --         local obj = CreateObject(`brp_thermal`, coords, false, true)

-- --         while not DoesEntityExist(obj) do
-- --             Wait(1000)
-- --         end

-- --         local heading = GetEntityHeading(obj)

-- --         SetEntityHeading(obj, heading)

-- --         -- -- RemoveReplaceTexture('brp_thermal', 'brp_blue')

-- --         -- -- Wait(5000)

-- --         -- -- local txd = CreateRuntimeTxd('meow')

-- --         -- -- local duiUrl = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/base/static/ui/boskierp/index.html'

-- --         -- -- local duiObject = CreateDui(duiUrl, 854, 884)

-- --         -- -- local duiHandle = GetDuiHandle(duiObject)

-- --         -- -- local runtimeTxt = CreateRuntimeTextureFromDuiHandle(txd, 'meow', duiHandle)

-- --         -- -- CommitRuntimeTexture(runtimeTxt)

-- --         -- -- AddReplaceTexture('brp_thermal', 'brp_blue', 'meow', 'meow')

-- --         -- -- CommitRuntimeTexture(runtimeTxt)

-- --         -- -- Wait(10000)

-- --         -- -- SendDuiMessage(duiObject, json.encode({
-- --         -- --     show = true,
-- --         -- --     type = 'DUI',
-- --         -- --     action = 'open',
-- --         -- --     name = 'DUI'
-- --         -- -- }))

-- --         Wait(30000)

-- --         DeleteEntity(obj)
-- --         -- -- DestroyDui( duiObject )

-- --     end
RegisterCommand("naped", function()
	--RemoveReplaceTexture("ch3_rd2_billboard01", "ch3_rd2_billboard01")

	Wait(5000)

	local txd = CreateRuntimeTxd("meow")

	local duiUrl = "https://cfx-nui-" .. GetCurrentResourceName() .. "/base/static/ui/boskierp/index.html"

	local scale = 1.5
	local screenWidth = math.floor(1920 / scale)
	local screenHeight = math.floor(1080 / scale)

	local duiObject = CreateDui(duiUrl, screenWidth, screenHeight)

	local duiHandle = GetDuiHandle(duiObject)

	local runtimeTxt = CreateRuntimeTextureFromDuiHandle(txd, "meow", duiHandle)

	SendDuiMessage(
		duiObject,
		json.encode({
			show = true,
			type = "Scoreboard",
			action = "open",
			name = "bank",
		})
	)

	CommitRuntimeTexture(runtimeTxt)

	AddReplaceTexture("CommonMenu", "ArrowRight", "meow", "meow")

	CommitRuntimeTexture(runtimeTxt)

	RequestStreamedTextureDict("meow")
	while not HasStreamedTextureDictLoaded("meow") do
		print("x d")
		Wait(0)
	end

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			DrawMarker(
				4,
				DWB.PlayerData.Coords,
				0.0,
				0.0,
				0.0,
				0.0,
				180.0,
				0.0,
				2.0,
				2.0,
				2.0,
				255,
				128,
				0,
				50,
				false,
				true,
				4,
				false,
				"meow",
				"meow",
				false
			)
		end
	end)
	CommitRuntimeTexture(runtimeTxt)
	Wait(10000)

	SendDuiMessage(
		duiObject,
		json.encode({
			show = true,
			type = "Scoreboard",
			action = "open",
			name = "bank",
		})
	)

	Wait(30000)

	DestroyDui(duiObject)
end)

