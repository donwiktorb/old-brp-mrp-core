


Key:onJustPressed('F6', 'Menu frakcji', function()
    local job = User:GetJobByType('fraction')
    if job then
        UI:Open('Menu', {
            name = 'fraction-menu',
            title = "Akcje Frakcji",
            align = 'right',
            elements = Config.Fraction.Menu[job.name]
        }, function(data, menu)
            local data5
            if data.current.cb then
                data5 = Config.Fraction.Functions[data.current.cb]()
            end
            if data.current.elements then
                UI:Open('Menu', {
                    name = 'fraction-menu-2',
                    title = data.current.label,
                    align = 'right',
                    elements = data.current.elements
                }, function(data2, menu2)
                    if data2.current.value then
                        local cb = data2.current.clientFn or data.current.clientFn
                        if cb then
                            Config.Fraction.Functions[cb](data.current, data2.current)
                        else
                            Event:TriggerNet('dwb:fraction:menu:action', data.current, data2.current, data5)
                        end
                    end
                end)
            else
                Event:TriggerNet('dwb:fraction:menu:action', data.current, false, data5)
            end
        end)
    end
end)
Event:Register('dwb:fraction:cloakroom:open', function(posData)
    local data = posData.data
    local clothes = {
        {
            label = 'Cywilne',
            value = 'civil'
        },
        {
            label = 'Stwórz własny',
            value = 'skin'
        }
    }
    local job = User:GetJob(data.jobs)
    if job then
        local clothesObj = Config.Clothes.Fractions[job.name]
        if clothesObj and clothesObj['shared'] then
            for k, v in pairs(clothesObj.shared) do
                local add = true
                if v.license then
                    add = User:HasLicense(v.licenses)
                end

                if add then
                    table.insert(clothes, v)
                end
            end
        end

        if clothesObj and clothesObj[job.grade_name] then
            for k, v in pairs(clothesObj[job.grade_name]) do
                local add = true

                if v.license then
                    add = User:HasLicense(v.licenses)
                end

                if add then
                    table.insert(clothes, v)
                end
            end
        end
    end
    UI:Open('Menu', {
        name = 'cloakroom',
        title = "Przebieralnia",
        align = 'right',
        elements = clothes
    }, function(data2, menu)
        local current = data2.current
        if current.value and current.value == 'civil' then
            Skinchanger:RestoreSkin()
        elseif current.value and current.value == 'skin' then
            menu.close()
            OpenSkin()
        else
            if not Skinchanger.RecentSaved then
                Skinchanger:SaveSkin()
            end
            if current.armor then
                SetPedArmour(PlayerPedId(), current.armor)
            end
            local skin = Skinchanger:GetData()
            Skinchanger:Apply(false, current.clothes[skin.sex == 1 and 'female' or 'male'])
        end
    end)
end, true)

Event:Register('dwb:fraction:garage:open', function(posData)
    local data = posData.data
    local clothes = {}
    local job = User:GetJob(data.jobs)
    if job then
        local clothesObj = Config.Vehicles.Jobs[job.name]
        if clothesObj and clothesObj['shared'] then
            for k, v in pairs(clothesObj.shared) do
                v.label = v.label or GetDisplayNameFromVehicleModel(v.model)

                local add = true
                if v.license then
                    add = User:HasLicense(v.license or v.licenses)
                end
                if add then
                    table.insert(clothes, v)
                end
            end
        end
        if clothesObj and clothesObj[job.grade_name] then
            for k, v in pairs(clothesObj[job.grade_name]) do
                v.label = v.label or GetDisplayNameFromVehicleModel(v.model)

                local add = true

                if v.license then
                    add = User:HasLicense(v.license or v.licenses)
                end

                if add then
                    table.insert(clothes, v)
                end
            end
        end
    end
    UI:Open('Menu', {
        name = 'cloakroom',
        align = 'right',
        title = "Garaż",
        elements = clothes
    }, function(data2, menu)
        local current = data2.current
        local found = nil
        if posData.spawns then
            for k, v in pairs(posData.spawns) do
                if not IsAnyVehicleNearPoint(v.coords, 2.0) then
                    found = v
                end
            end
        else
            found = {
                coords = posData.pos,
                heading = posData.heading or 444.44
            }
        end

        Event:TriggerNet('dwb:fraction:garage:spawn', current, found)
    end)
end, true)

local build = false
local buildObj

Event:Register('dwb:fraction:place:object', function(item)
    build = not build
    if build then
        SendNuiMessage(json.encode({
            show = true,
            type = 'Notify2',
            action = 'open',
            data = {
                show = true,
                content = string.format("Naciśnij <k>E</k> aby postawić, <k>G</k> aby anulować, <k>[</k> By Obrócić")
            }
        }))

        local modelHash = item.value

        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do Wait(0) end

        local minimum --[[ vector3 ]], maximum --[[ vector3 ]] = GetModelDimensions( modelHash --[[ Hash ]])

        local forward = GetEntityForwardVector(PlayerPedId()) + GetEntityCoords(PlayerPedId()) - vector3(0, 0, 0.5)

        local retv, z = GetGroundZFor_3dCoord(forward.x, forward.y, forward.z, true)

        if retv then
            forward = vec3(forward.x, forward.y, z)
        end

        buildObj = CreateObject(modelHash, forward, false, true, false)

        while not DoesEntityExist(buildObj) do Wait(0) end

        SetEntityAlpha(buildObj, 240, false)

        local rot = 180.0
        local scroll = 2.0
        while build do
            Wait(0)
            forward = (GetEntityForwardVector(PlayerPedId()) * scroll) + GetEntityCoords(PlayerPedId()) -
            vector3(0, 0, 1.0)

            local retv, z = GetGroundZFor_3dCoord(forward.x, forward.y, forward.z, true)

            -- if retv then
            --     print(retv, z)
            --     forward = vec3(forward.x, forward.y, z)
            -- end

            SetEntityCoords(buildObj, forward)
            SetEntityHeading(buildObj, rot)
            PlaceObjectOnGroundProperly(buildObj)
            if IsControlPressed(0, 38) then
                build = nil
                forward = GetEntityCoords(buildObj)
                Event:TriggerNet('dwb:fraction:place:object', item, forward, rot)
            end

            if IsControlPressed(0, 39) then
                rot = rot - 1.0
            end

            if IsControlPressed(0, 14) then
                scroll = scroll - 0.1
                if scroll < -10 then
                    scroll = -10.0
                end
            end

            if IsControlPressed(0, 15) then
                scroll = scroll + 0.1
                if scroll > 10 then
                    scroll = 10.0
                end
            end

            if IsControlPressed(0, 46) then
                rot = rot + 1.0
            end

            if IsControlJustPressed(0, 47) then
                build = nil
            end
        end

        SetModelAsNoLongerNeeded(modelHash)
        DeleteEntity(buildObj)
        SendNuiMessage(json.encode({
            show = false,
            type = 'Notify2',
            action = 'close',
            content = string.format(
            "%s prosi o wejście. Naciśnij <k>G</k> aby zaakceptować albo <k>X</k>, aby odrzucić..", asker)
        }))
    end
end, true)
Thread:Create(function()
    while true do
        Wait(0)
        for k,v in pairs(DWB.PlayerData.ClosestObjects) do
            local m = Config.Fraction.ObjectsTouch[GetEntityModel(v.obj)]
            if m then
                if m.inVehicle and DWB.PlayerData.InVehicle then
                    if IsEntityTouchingEntity(DWB.PlayerData.Vehicle, v.obj) then
                        m.fn()
                    end
                end
            end
        end
    end
end)