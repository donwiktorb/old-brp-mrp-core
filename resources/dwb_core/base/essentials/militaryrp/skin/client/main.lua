local lastSkin, playerLoaded, cam, isCameraActive
local zoomOffset, camOffset, heading = 0.0, 0.0, 90.0

function OpenMenu(submitCb, cancelCb, restrict, only)
	local playerPed = PlayerPedId()

	TriggerEvent('dwb_skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	TriggerEvent('dwb_skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
            if only == nil then
                for i=1, #components, 1 do
                    _components[i] = components[i]
                end
            else
                for i=1, #components, 1 do
                    local found = false
                    for j=1, #only, 1 do
                        if components[i].name == only[j] then
                            found = true
                        end
                    end

                    if not found then
                        table.insert(_components, components[i])

                    end
                end
            end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				zoomOffset= _components[i].zoomOffset,
				camOffset = _components[i].camOffset,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end

		CreateSkinCam()
		zoomOffset = _components[1].zoomOffset
		camOffset = _components[1].camOffset

		UI:Open('Menu', {
            name = 'skin',
			title    = 'Menu skina',
			align    = 'right',
			elements = elements
		}, function(data, menu)
			TriggerEvent('dwb_skinchanger:getSkin', function(skin)
				lastSkin = skin
			end)

			submitCb(data, menu)
			DeleteSkinCam()

		end, function(data, menu)
			menu.close()
			DeleteSkinCam()
			TriggerEvent('dwb_skinchanger:loadSkin', lastSkin)

			if cancelCb ~= nil then
				cancelCb(data, menu)
			end
		end, function(data, menu)
			local skin, components, maxVals

			TriggerEvent('dwb_skinchanger:getSkin', function(getSkin)
				skin = getSkin
			end)

			zoomOffset = data.current.zoomOffset
			camOffset = data.current.camOffset

			if skin[data.current.name] ~= data.current.value then
				-- Change skin element
				TriggerEvent('dwb_skinchanger:change', data.current.name, data.current.value)

				-- Update max values
				TriggerEvent('dwb_skinchanger:getData', function(comp, max)
					components, maxVals = comp, max
				end)

				local newData = {}

				for i=1, #elements, 1 do
					newData = {}
					newData.max = maxVals[elements[i].name]

					if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
						newData.value = 0
					end

					menu.update('name', elements[i].name, newData)
				end

				-- menu.refresh()
			end
		end, function(data, menu)

			DeleteSkinCam()
		end)
	end)
end

function CreateSkinCam()
	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)

	isCameraActive = true
	SetCamRot(cam, 0.0, 0.0, 270.0, true)
	SetEntityHeading(playerPed, 90.0)
	startLoop()
end

function DeleteSkinCam()
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

function startLoop()
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCameraActive then
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local angle = heading * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffset * theta.x),
				y = coords.y + (zoomOffset * theta.y)
			}

			local angleToLook = heading - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffset * thetaToLook.x),
				y = coords.y + (zoomOffset * thetaToLook.y)
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

			Notification:ShowHelp(_U('use_rotate_view'))
		else
			return
		end
	end
end)

Citizen.CreateThread(function()
	local angle = 90

	while true do
		Citizen.Wait(0)

		if isCameraActive then
			if IsControlPressed(0, 32) then
				angle = angle - 1
			elseif IsControlPressed(0, 31) then
				angle = angle + 1
			elseif IsControlPressed(0, 34) then
				if camOffset < 0.80 then
					camOffset = camOffset + 0.10
				end
			elseif IsControlPressed(0, 35) then
				if camOffset > -0.80 then
					camOffset = camOffset - 0.10
				end
			end

			if angle > 360 then
				angle = angle - 360
			elseif angle < 0 then
				angle = angle + 360
			end

			heading = angle + 0.0
		else
			return
		end
	end
end)
end

function openCreateSkin(submitCb, cancelCb, restrict)
	TriggerEvent('dwb_skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('dwb_skinchanger:getSkin', function(skin)
			Event:TriggerNet('dwb:skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict, {'sex'})
end

function OpenSaveableMenu(submitCb, cancelCb, restrict)
	TriggerEvent('dwb_skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('dwb_skinchanger:getSkin', function(skin)
			TriggerServerEvent('dwb:skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

Event:Register('dwb:player:state:firstSpawn', function()
    Callback:Trigger('dwb:skin:getPlayerSkin', function(skin, sex)
        if not skin then
            TriggerEvent('dwb_skinchanger:loadSkin', {sex = sex == 'm' and 0 or 1}, openCreateSkin)
        else
            TriggerEvent('dwb_skinchanger:loadSkin', skin)
        end
	end)
end, false)

RegisterNetEvent('dwb:skin:openMenu')
AddEventHandler('dwb:skin:openMenu', function()
   openCreateSkin()     
end)