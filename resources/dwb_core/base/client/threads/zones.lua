-- local HasAlreadyEnteredMarker = false
-- local LastPart = {}
-- local currentZoneData
-- local currentPosData
-- local CurrentAction = {}

-- Thread:Create(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local playerCoords = GetEntityCoords(playerPed)
-- 		local isInMarker, hasExited, letSleep = false, false, true

-- 		for k,v in pairs(DWB.Zones) do
--             for i, z in pairs(v.coords) do
--                 if type(z) ~= 'table' then 
--                     local pos = z
--                     z = {pos = pos, index = i}
--                 end
--                 z.index = i
--                 local distance = #(playerCoords - z.pos)
--                 local drawDist = z.drawDist or v.settings.drawDist

--                 if distance < drawDist then
--                     local drawDistEnterCb = (z.functions and z.functions.onDrawDistEnter or v.functions.onDrawDistEnter)

--                     if drawDistEnterCb and not z.drawDistEnterCalled and not v.drawDistEnterCalled then
--                         z.drawDistEnterCalled = true
--                         z.drawDistExitCalled = nil
--                         drawDistEnterCb(v, z)
--                     end

--                     local drawMarker = v.settings.drawMarker
--                     local marker = z.marker or v.marker

--                     if drawMarker then
--                         DrawMarker(marker.type, z.pos, marker.direction.x, marker.direction.y, marker.direction.z, marker.rotation.x, marker.rotation.y, marker.rotation.z, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.animate, marker.faceCam, 2, true, false, false, false)
--                     end

--                     local closeDistCb = (z.functions and z.functions.onCloseDist or v.functions.onCloseDist)

--                     if closeDistCb then
--                         local waitTime = v.settings.closeDistWait 
--                         if waitTime then Wait(waitTime) end
--                         closeDistCb(v, z)
--                     end

--                     letSleep = false
--                     if marker and not marker.scale then
--                         marker.scale = {
--                             x = z.radius or v.settings.radius
--                         }
--                     end

--                     if distance < marker.scale.x then
--                         z.index = i
--                         isInMarker, currentZoneData, currentPosData  = true, v, z 
--                     end
--                 else
--                     if v.drawDistEnterCalled or z.drawDistEnterCalled then
--                         local drawDistExitCb = (z.functions and z.functions.onDrawDistExit or v.functions.onDrawDistExit)

--                         if drawDistExitCb then
--                             z.drawDistExitCalled = true
--                             z.drawDistEnterCalled = nil
--                             drawDistExitCb(v, z)
--                         end
--                     end
--                 end
--             end
-- 		end


-- 		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
-- 			HasAlreadyEnteredMarker = false
-- 			TriggerEvent('dwb:hasExitedMarker', LastPart)
-- 		end

--         if isInMarker and not HasAlreadyEnteredMarker then
--             HasAlreadyEnteredMarker = true

--             table.insert(LastPart, {
--                 zoneData = currentZoneData,
--                 posData = currentPosData
--             })

-- 			TriggerEvent('dwb:hasEnteredMarker', {
--                 zoneData = currentZoneData,
--                 posData = currentPosData
--             })
--         elseif isInMarker then
--             local found = false
            
--             for k,v in pairs(LastPart) do
--                 if v.zoneData.name == currentZoneData.name and v.posData.index == currentPosData.index then
--                     found = true                          
--                 end
--             end

--             if not found then
--                 HasAlreadyEnteredMarker = true

--                 table.insert(LastPart, {
--                     zoneData = currentZoneData,
--                     posData = currentPosData
--                 })

--                 TriggerEvent('dwb:hasEnteredMarker', {
--                     zoneData = currentZoneData,
--                     posData = currentPosData
--                 })
--             end
--         end

-- 		if letSleep then
-- 			Citizen.Wait(1000)
-- 		end
-- 	end
-- end)

-- AddEventHandler('dwb:hasEnteredMarker', function(data)
    
--     local zoneData, posData = data.zoneData, data.posData

--     local enterCb = (DWB.Zones[zoneData.name].coords[posData.index].functions and DWB.Zones[zoneData.name].coords[posData.index].functions.onEnterCb or DWB.Zones[zoneData.name].functions.onEnterCb)

--     if enterCb then
--         enterCb(zoneData, posData)
--     end

--     local ActionMSG = (DWB.Zones[zoneData.name].coords[posData.index].messages and DWB.Zones[zoneData.name].coords[posData.index].messages.onEnter or DWB.Zones[zoneData.name].messages.onEnter)

--     if type(ActionMSG) == 'function' then
--         ActionMSG = ActionMSG(zoneData, posData)
--     end

--     table.insert(CurrentAction, {
--         zoneName = zoneData.name,
--         posIndex = posData.index,
--         data = {
--             zoneData = zoneData,
--             posData = posData
--         },
--         message = ActionMSG 
--     })

-- end)

-- AddEventHandler('dwb:hasExitedMarker', function(data)
--     for k,v in pairs(data) do
--         local zoneData, posData = v.zoneData, v.posData

--         for k2,v2 in pairs(CurrentAction) do
--             if v2.zoneName == zoneData.name and v2.posIndex == posData.index then
--                 CurrentAction[k] = nil
--             end
--         end

--         if DWB.Zones[zoneData.name] then
--             local exitCb = (DWB.Zones[zoneData.name].coords[posData.index].functions and DWB.Zones[zoneData.name].coords[posData.index].functions.onExitCb or DWB.Zones[zoneData.name].functions.onExitCb)
--             if exitCb then
--                 exitCb(zoneData, posData)
--             end
--         end

--     end

--     LastPart = {}
-- end)

-- Key:onJustPressed("E", "Użyj", function()
--     for k,v in pairs(CurrentAction) do
--         local zoneData, posData = v.data.zoneData, v.data.posData
--         local clickCb = (DWB.Zones[zoneData.name].coords[posData.index].functions and DWB.Zones[zoneData.name].coords[posData.index].functions.onClickCb or DWB.Zones[zoneData.name].functions.onClickCb)
--         local ActionData = v 

--         if zoneData.settings.oneUse then
--             CurrentAction[k] = nil 
--         end
        
--         if clickCb then
--             clickCb(zoneData, posData, ActionData)
--         end
--     end
-- end)

-- Thread:Create(function()
--     local show = false
--     while true do
--         Citizen.Wait(0)
--         if #CurrentAction > 0 then
--             for k,v in pairs(CurrentAction) do
--                 if v.message then
--                     if not show then
--                         show = true
--                         SendNuiMessage(json.encode({
--                             type = 'Notify2',
--                             action = 'open',
--                             data=  {
--                                 show = true,
--                                 content = v.message
--                             }
--                         }))
--                         -- Notification:ShowHelp(v.message)
--                     end
--                 end
--             end
--         elseif show then
--             show = false
--             SendNuiMessage(json.encode({
--                 type = 'Notify2',
--                 action = 'close',
--             }))
--         else
--             Wait(1000)
--         end
--     end
-- end)