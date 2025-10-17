


-- -- local currentDetail = 1
-- -- local garageOpen = false
-- -- local vehiclePages = {
-- --     -- {
-- --     --     {

-- --     --     } -- pojazd
-- --     -- } -- strona
-- -- }
-- -- local currentPage = 1

-- -- local currentVeh = 1

-- -- local scaleform

-- -- local forceClosed = false

-- -- local function Initialize(scaleform4, title, msg)
-- --     local scaleform2 = RequestScaleformMovie(scaleform4)

-- --     while not HasScaleformMovieLoaded(scaleform2) do
-- --         Citizen.Wait(0)
-- --     end

-- --     BeginScaleformMovieMethod(scaleform2, "SHOW_SHARD_CENTERED_MP_MESSAGE_LARGE")
-- --     PushScaleformMovieFunctionParameterString(title)
-- --     PushScaleformMovieFunctionParameterString(msg)

-- --     EndScaleformMovieMethod()

-- --     return scaleform2
-- -- end

-- -- function changeDetails()
-- --     if vehiclePages[currentPage].vehicles and vehiclePages[currentPage].vehicles[currentVeh] then
-- --     local detail = vehiclePages[currentPage].vehicles[currentVeh].details[currentDetail]
-- --     BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_CENTERED_MP_MESSAGE_LARGE")
-- --     PushScaleformMovieFunctionParameterString(detail[1])
-- --     PushScaleformMovieFunctionParameterString(detail[2])

-- --     EndScaleformMovieMethod()
-- --     end
-- -- end

-- -- local function spawnNew(lastPage)
-- --     local vehObj = vehiclePages[currentPage].vehicleObj
-- --     DeleteEntity(vehObj)
-- --     local veh = vehiclePages[currentPage].vehicles[currentVeh]
-- --     local coords = vehiclePages[currentPage].coords
-- --     local modelHash = veh and veh.model or 0

-- --     if IsModelValid(modelHash) then
-- --         RequestModel(modelHash)
-- --         while not HasModelLoaded(modelHash) do
-- --             Wait(0)
-- --         end

-- --         local vehicleObj = CreateVehicle(modelHash, coords.spawnCoords, coords.heading, false, true)        

-- --         while not DoesEntityExist(vehicleObj) do
-- --             Wait(0)
-- --         end

-- --             FreezeEntityPosition(vehicleObj, true)
-- --             SetEntityCollision(vehicleObj, true, false)
-- --         Vehicle:SetProperties2(vehicleObj, veh.vehicleData)
-- --         vehiclePages[currentPage].vehicleObj = vehicleObj

-- --         currentDetail = 1
-- --         changeDetails()

-- --         SetModelAsNoLongerNeeded(modelHash)
-- --     end
-- -- end


-- -- local function startMe()
-- --     local pedCoords = DWB.PlayerData.Coords
-- --     while garageOpen and not DWB.PlayerData.InVehicle and #(DWB.PlayerData.Coords - pedCoords) <= 50.0 do
-- --         Wait(0)
-- --         local rot = GetGameplayCamRot()
-- --         local cCoords = vehiclePages[currentPage].coords.spawnCoords
-- --         local newCoords = vec3(cCoords.x, cCoords.y, cCoords.z+1.5)
-- --         DrawScaleformMovie_3dSolid(scaleform, newCoords, rot.x, rot.y, rot.z, 3.0, 3.0, 3.0, 5.0, 5.0, 5.0, true)
-- --         if vehiclePages[currentPage].vehicles and vehiclePages[currentPage].vehicles[currentVeh] then
-- --         SendNuiMessage(json.encode({
-- --             type = 'Notify2',
-- --             action = 'open',
-- --             data=  {
-- --                 show = true,
-- --                 content = string.format("Naciśnij <k>Q</k> oraz <k>E</k>, aby zmienić stronę (%s/%s), poruszaj się strzałkami <k>→</k> <k>←</k>, aby zmienić pojazd (%s/%s) oraz <k>↑</k>, <k>↓</k>, aby sprawdzić informacje (%s/%s). Naciśnij <k>G</k>, <span style='color:pink'>aby usunąć auto</span>.", currentPage, #vehiclePages, currentVeh, #vehiclePages[currentPage].vehicles, currentDetail, #vehiclePages[currentPage].vehicles[currentVeh].details)
-- --             }
-- --         }))
-- --     end
-- --         DisableControlAction(0, 44, true)
-- --         DisableControlAction(0, 38, true)
-- --         DisableControlAction(0, 172, true)
-- --         DisableControlAction(0, 173, true)
-- --         DisableControlAction(0, 47, true)
-- --         DisableControlAction(0, 174, true)
-- --         DisableControlAction(0, 175, true)
        
        

-- --         if IsDisabledControlJustPressed(0, 44) then
-- --             currentPage = currentPage - 1
-- --             if currentPage < 1 then
-- --                 currentPage = #vehiclePages
-- --             end
-- --             currentVeh = vehiclePages[currentPage].veh
-- --             spawnNew()
-- --         elseif IsDisabledControlJustPressed(0, 38) then
-- --             currentPage = currentPage + 1
-- --             if currentPage > #vehiclePages then
-- --                 currentPage = 1
-- --             end
-- --             currentVeh = vehiclePages[currentPage].veh
-- --             spawnNew()
-- --         elseif IsDisabledControlJustPressed(0, 174) then
-- --             currentVeh = vehiclePages[currentPage].veh-1
-- --             -- currentVeh = currentVeh - 1
-- --             if currentVeh <= 0 then
-- --                 currentVeh = #vehiclePages[currentPage].vehicles
-- --             end
-- --             vehiclePages[currentPage].veh = currentVeh
-- --             spawnNew()
-- --         elseif IsDisabledControlJustPressed(0, 175) then
-- --             currentVeh = vehiclePages[currentPage].veh+1
-- --             if currentVeh > #vehiclePages[currentPage].vehicles then
-- --                 currentVeh = 1
-- --             end
-- --             vehiclePages[currentPage].veh = currentVeh
-- --             spawnNew()
-- --         elseif IsDisabledControlJustPressed(0, 172) then
-- --             currentDetail = currentDetail + 1
-- --             if vehiclePages[currentPage].vehicles and vehiclePages[currentPage].vehicles[currentVeh] then
-- --                 if currentDetail > #vehiclePages[currentPage].vehicles[currentVeh].details then
-- --                     currentDetail = 1
-- --                 end
-- --             else
-- --                 currentDetail  = 1
-- --             end
-- --             changeDetails()
-- --         elseif IsDisabledControlJustPressed(0, 173) then
-- --             currentDetail = currentDetail - 1
-- --             if currentDetail <= 0 then
-- --                 if vehiclePages[currentPage].vehicles and vehiclePages[currentPage].vehicles[currentVeh] then
-- --                     currentDetail = #vehiclePages[currentPage].vehicles[currentVeh].details
-- --                 else
-- --                     currentDetail = 1
-- --                 end
-- --             end
-- --             changeDetails()
-- --         elseif IsDisabledControlJustPressed(0, 47) then
-- --             local currentVeh = vehiclePages[currentPage].vehicles[currentVeh]
-- --             if currentVeh then
-- --             UI:Open('Menu', {
-- --                 name = 'confirm',
-- --                 title = 'Czy napewno chcesz usunąć pojazd '..currentVeh.label..'?',
-- --                 align = 'center',
-- --                 elements = {
-- --                     {
-- --                         label = 'Tak',
-- --                         value = 'yes'
-- --                     },
-- --                     {
-- --                         label = 'Nie',
-- --                         value = 'no'
-- --                     }
-- --                 }
-- --             }, function(data,menu)
-- --                 menu.close()     
-- --                 if data.current.value == 'yes' then
-- --                     Event:TriggerNet('dwb:garage:delete', currentVeh.plate)    
-- --                 end
-- --             end)
-- --         end
-- --         end
-- --     end
-- --     local plate = GetVehicleNumberPlateText(DWB.PlayerData.Vehicle)
-- --     local spawnCoords = GetEntityCoords(DWB.PlayerData.Vehicle)
-- --     local heading = GetEntityHeading(DWB.PlayerData.Vehicle)
-- --         SendNuiMessage(json.encode({
-- --         show = true,
-- --         type = 'Notify2',
-- --         action = 'close',
-- --         content = string.format("Naciśnij <k>Q</k> oraz <k>E</k>, aby zmienić stronę (%s/%s) oraz poruszaj się strzałkami, aby zmienić pojazd (%s/%s).", currentPage, #vehiclePages, currentVeh, #vehiclePages[currentPage].vehicles)
-- --     }))
-- --    garageOpen = false
-- --    Wait(100) 
-- --    for i=1, #vehiclePages do
-- --         DeleteEntity(vehiclePages[i].vehicleObj)
-- --    end
-- --    vehiclePages = {}
-- --    currentPage = 1
-- --    currentVeh = 1
-- --    currentDetail = 1
-- --    if not forceClosed then
-- --     Event:TriggerNet('dwb:garage:spawn', plate, {
-- --         spawnCoords = spawnCoords,
-- --         heading = heading
-- --     })
    
-- -- end
-- -- forceClosed = false
-- -- end

-- -- Event:Register('dwb:garage:close2', function(vehicles, cData)
-- --     forceClosed = true
-- --    garageOpen = false
-- --    Wait(100) 
-- --    for i=1, #vehiclePages do
-- --         DeleteEntity(vehiclePages[i].vehicleObj)
-- --    end
-- --    vehiclePages = {}
-- --    currentPage = 1
-- --    currentVeh = 1
-- --    currentDetail = 1
-- -- end, true)

-- -- Event:Register('dwb:garage:open2', function(vehicles, cData)
-- --     if DWB.PlayerData.InVehicle then
-- --         return Notification:ShowCustom('info', 'Garaż', 'Nie możesz być w samochodzie')
-- --     end

-- --     garageOpen = true
-- --     local pages = #cData
-- --     local vehNum = #vehicles
-- --     local page = 1

-- --     for i=1, pages do
-- --         table.insert(vehiclePages, {
-- --             coords = cData[i],
-- --             veh = 1,
-- --             vehicles = {}
-- --         })
-- --     end

-- --     for i=1, vehNum do
-- --         local vehicle = vehicles[i]
-- --         if vehicle.state then
-- --             local veh = vehicle.vehicle
-- --             local label = GetDisplayNameFromVehicleModel(veh.model)
-- --             local engineh = veh.engineHealth or 1000
-- --             local caroh = veh.bodyHealth or 1000
-- --             local engineh = math.floor(engineh/10)
-- --             local caroh = math.floor(caroh/10)

-- --             table.insert(vehiclePages[page].vehicles, {
-- --                 label = label,
-- --                 plate = veh.plate,
-- --                 model = veh.model,
-- --                 vehicleData = veh,
-- --                 details = {
-- --                     {
-- --                         "Model",
-- --                         label 
-- --                     },
-- --                     {
-- --                         "Rejestracja",
-- --                         veh.plate
-- --                     },
-- --                     {
-- --                         "Stan silnika",
-- --                         engineh.."%"
-- --                     },
-- --                     {
-- --                         "Stan Karoserii",
-- --                         caroh.."%"
-- --                     }
-- --                 },
-- --                 data = {
-- --                     -- string.format("Rejestracja: %s",veh.plate),
-- --                     string.format("Stan Silnika: %s",engineh.."%"),
-- --                     string.format("Stan Karoserii: %s",caroh.."%")
-- --                 }
-- --             })
-- --             page = page + 1
-- --             if page > pages then
-- --                 page = 1
-- --             end
-- --         end
-- --     end

-- --    for i=1, #vehiclePages do
-- --         local veh = vehiclePages[i].vehicles[1]
-- --         local coords = vehiclePages[i].coords
-- --         local modelHash = veh and veh.model or 0

-- --         if IsModelValid(modelHash) then
-- --             RequestModel(modelHash)

-- --             while not HasModelLoaded(modelHash) do
-- --                 Wait(0)
-- --             end

-- --             local vehicleObj = CreateVehicle(modelHash, coords.spawnCoords, coords.heading, false, true)        

-- --             while not DoesEntityExist(vehicleObj) do
-- --                 Wait(0)
-- --             end
-- --             FreezeEntityPosition(vehicleObj, true)
-- --             SetEntityCollision(vehicleObj, true, false)

-- --             Vehicle:SetProperties2(vehicleObj, veh.vehicleData)

-- --             vehiclePages[i].vehicleObj = vehicleObj

-- --             SetModelAsNoLongerNeeded(modelHash)

-- --             Wait(100)       
-- --         end
-- --    end

-- --    local veh = vehiclePages[1] and vehiclePages[1].vehicles[1]

-- --    if veh then
-- --         scaleform = Initialize("MP_BIG_MESSAGE_FREEMODE", "Model", veh.label)
-- --    end

-- --    startMe()

-- --     -- -- local elements = {}
-- --     -- -- for k,v in pairs(vehicles) do
-- --     -- --     if v.state then
-- --     -- --         local veh = v.vehicle or {
-- --     -- --             model = 'not found',
-- --     -- --             plate =' not found'
-- --     -- --         }
-- --     -- --         local engineh = veh.engineHealth or 1000
-- --     -- --         local caroh = veh.bodyHealth or 1000
-- --     -- --         local engineh = math.floor(engineh/10)
-- --     -- --         local caroh = math.floor(caroh/10)
-- --     -- --         table.insert(elements, {
-- --     -- --             label = GetDisplayNameFromVehicleModel(veh.model),
-- --     -- --             value = veh.plate,
-- --     -- --             data = {
-- --     -- --                 string.format("Rejestracja: %s",veh.plate),
-- --     -- --                 string.format("Stan Silnika: %s",engineh.."%"),
-- --     -- --                 string.format("Stan Karoserii: %s",caroh.."%")
-- --     -- --             }
-- --     -- --         })
-- --     -- --     end
-- --     -- -- end

-- --     -- -- UI:Open('MenuGrid', {
-- --     -- --     name = 'garage',
-- --     -- --     title = 'Garaż',
-- --     -- --     align = 'center',
-- --     -- --     elements = elements
-- --     -- -- }, function(data, menu)
-- --     -- --     local found = false

-- --     -- --     for k,v in pairs(cData) do
-- --     -- --         if not IsAnyVehicleNearPoint(v.spawnCoords, 2.0) then
-- --     -- --             found = v   
-- --     -- --         end
-- --     -- --     end

-- --     -- --     if found then
-- --     -- --         menu.close()
-- --     -- --         Event:TriggerNet('dwb:garage:spawn', data.current.value, found)
-- --     -- --     else
-- --     -- --         Notification:ShowCustom('info', 'Parking', 'Brak wolnych miejsc')
-- --     -- --     end
-- --     -- -- end)
-- -- end, true)

-- -- Event:Register('dwb:garage:open', function(vehicles, cData)
-- --     local elements = {}
-- --     for k,v in pairs(vehicles) do
-- --         if v.state then
-- --             local veh = v.vehicle or {
-- --                 model = 'not found',
-- --                 plate =' not found'
-- --             }
-- --             local engineh = veh.engineHealth or 1000
-- --             local caroh = veh.bodyHealth or 1000
-- --             local engineh = math.floor(engineh/10)
-- --             local caroh = math.floor(caroh/10)
-- --             table.insert(elements, {
-- --                 label = GetDisplayNameFromVehicleModel(veh.model),
-- --                 value = veh.plate,
-- --                 data = {
-- --                     string.format("Rejestracja: %s",veh.plate),
-- --                     string.format("Stan Silnika: %s",engineh.."%"),
-- --                     string.format("Stan Karoserii: %s",caroh.."%")
-- --                 }
-- --             })
-- --         end
-- --     end

-- --     UI:Open('MenuGrid', {
-- --         name = 'garage',
-- --         title = 'Garaż',
-- --         align = 'center',
-- --         elements = elements
-- --     }, function(data, menu)
-- --         local found = false

-- --         for k,v in pairs(cData) do
-- --             if not IsAnyVehicleNearPoint(v.spawnCoords, 2.0) then
-- --                 found = v   
-- --             end
-- --         end

-- --         if found then
-- --             menu.close()
-- --             Event:TriggerNet('dwb:garage:spawn', data.current.value, found)
-- --         else
-- --             Notification:ShowCustom('info', 'Parking', 'Brak wolnych miejsc')
-- --         end
-- --     end)
-- -- end, true)

-- -- Event:Register('dwb:garage:spawn', function(vehicle, netId)
-- --     local veh = NetworkGetEntityFromNetworkId(netId)
-- --     Vehicle:SetProperties2(veh, vehicle)
-- --     SetRadioToStationIndex(0)
-- -- end, true)

-- -- Event:Register('dwb:garage:close', function()
-- --     local ped = PlayerPedId()
-- --     local veh = GetVehiclePedIsIn(ped, true)
-- --     if veh then
-- --         local properties = Vehicle:GetProperties2(veh)
-- --         Event:TriggerNet('dwb:garage:close', properties)
-- --     end
-- -- end, true)

-- -- local types = {
-- --     [5] = 40000
-- -- }

-- -- Event:Register('dwb:tow:open', function(vehicles, cData)
-- --     local elements = {}
-- --     for k,v in pairs(vehicles) do
-- --         if not v.state then
-- --             local veh = v.vehicle
-- --             local engineh = veh.engineHealth or 1000
-- --             local caroh = veh.bodyHealth or 1000
-- --             local engineh = math.floor(engineh/10)
-- --             local caroh = math.floor(caroh/10)
-- --             local price = types[veh.vehicleClass or 0] or 20000
-- --             table.insert(elements, {
-- --                 label = GetDisplayNameFromVehicleModel(veh.model),
-- --                 value = veh.plate,
-- --                 price = price,
-- --                 data = {
-- --                     string.format("Rejestracja: %s",veh.plate),
-- --                     string.format("Stan Silnika: %s",engineh.."%"),
-- --                     string.format("Stan Karoserii: %s",caroh.."%"),
-- --                     string.format("Cena: %s",price.."$")
-- --                 }
-- --             })
-- --         end
-- --     end

-- --     UI:Open('MenuGrid', {
-- --         name = 'tow',
-- --         title = 'Odholownik',
-- --         align = 'center',
-- --         elements = elements
-- --     }, function(data, menu)
-- --         menu.close()
-- --         Event:TriggerNet('dwb:tow:spawn', data.current.value, cData, data.current.price)
-- --     end)
-- -- end, true)