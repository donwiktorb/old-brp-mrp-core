


Admin = class()

function Admin:GetPermission(str, table)
    local keys = {}
    for key in string.gmatch(str, '([^%.]+)') do
        table.insert(keys, key)
    end
    local value = t
    for k, v in pairs(keys) do
        value = value[v]
    end
    return value
end


function Admin:Noclip()
    self.noclip = not self.noclip

    if self.noclip then
        Thread:Create(function()
            local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
            FreezeEntityPosition(ped, true)
            while noclip do
                Citizen.Wait(0)
                local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
                local coords = DWB.PlayerData.Coords
                local camRot = GetGameplayCamRot(2)
                local pitch = math.rad(camRot.x)
                local roll = camRot.y
                local yaw = math.rad(-camRot.z)

                local camCoords = GetGameplayCamCoord()

                local npos = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z
                }

                if IsControlPressed(1, 32) then
                    local forwardY = (math.cos(yaw) * math.cos(pitch))
                    local forwardX = (math.sin(yaw) * math.cos(pitch))
                    local forwardZ = math.sin(pitch)

                    npos.x = coords.x + (forwardX * speed)
                    npos.y = coords.y + (forwardY * speed)
                    npos.z = coords.z + (forwardZ * speed)
                end
                if IsControlPressed(1, 31) then
                    local forwardY = (math.cos(yaw) * math.cos(pitch))
                    local forwardX = (math.sin(yaw) * math.cos(pitch))
                    local forwardZ = math.sin(pitch)

                    npos.x = coords.x - (forwardX * speed)
                    npos.y = coords.y - (forwardY * speed)
                    npos.z = coords.z - (forwardZ * speed)
                end
                if IsControlPressed(1, 21) then
                    local forwardZ = 1.0

                    npos.z = coords.z - (forwardZ * speed)
                end
                if IsControlPressed(1, 22) then
                    local forwardZ = 1.0

                    npos.z = coords.z + (forwardZ * speed)
                end

                SetEntityCoordsNoOffset(ped, npos.x, npos.y, npos.z, true, true, true)
            end
            local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
            FreezeEntityPosition(ped, false)
        end)
    end
end

function Admin:TPM()
    local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        RequestCollisionAtCoord(waypointCoord)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], zPos)

                break
            end

            Citizen.Wait(4)
        end
    end
end

function Admin:INV()
    local ped = DWB.PlayerData.Ped
    if IsEntityVisible(ped) then
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false)
    else
        SetEntityInvincible(ped, false)



        SetEntityVisible(ped, true)
    end
end


function Admin:GetMenuElements()
    local perm = Config.Admin.Permissions[DWB.PlayerData.data.group]
    if perm and perm.menu then
        local elements = {}

        for k, v in pairs(Config.Admin.Categories) do
            if v.requires then
                local allowed = getPerm(v.requires, perm)
                if allowed then
                    table.insert(elements, v.element)
                end
            else
                table.insert(elements, v.element)
            end
        end
        return elements
    end
end

function Admin:OpenMenu(data)
    local elements = self:GetMenuElements()
    UI:Open('Menu', data or {
        name = 'admin',
        title = TR("admin_menu"),
        align = 'top-right',
        elements = elements
    }, function(data, menu)
        local current = data.current
        if current.value == 'players' then
            local players = Event:TriggerCbSync('dwb:admin:get:players')
            table.sort(players, function(a, b)
                return a.source < b.source
            end)
            local elements = {

            }
            for k, v in pairs(Config.Admin.Elements[current.value]) do
                table.insert(elements, v)
            end
            for k, v in pairs(players) do
                table.insert(elements, {
                    label = v.name .. ' ' .. v.source,
                    value = 'player',
                    source = v.source,
                    name = v.name
                })
            end

            UI:Open('Menu', {
                name = 'admin-players',
                title = TR("players", #elements),
                align = 'top-right',
                elements = elements
            }, function(data, menu)
                local player = data.current
                local actions = Config.Admin.Actions[player.value]
                local elements = {}
                for k, v in pairs(actions) do
                    if not v.requires or getPerm(v.requires, perm) then
                        table.insert(elements, v)
                    end
                end
                if player.value == 'player' then
                    UI:Open('Menu', {
                        name = 'admin-player',
                        title = player.name,
                        align = 'top-right',
                        elements = elements
                    }, function(data, menu)
                        Event:TriggerNet('dwb:admin:player:manage', data.current, player)
                    end)
                else
                    local players = Event:TriggerCbSync('dwb:admin:get:cache:players')
                    table.sort(players, function(a, b)
                        return a.source < b.source
                    end)
                    local elements = {}
                    for k, v in pairs(players) do
                        table.insert(elements, {
                            label = v.name .. ' ' .. v.source,
                            value = 'player',
                            source = v.source,
                            name = v.name
                        })
                    end

                    UI:Open('Menu', {
                        name = 'admin-players-cache',
                        title = TR("players", #elements),
                        align = 'top-right',
                        elements = elements
                    }, function(data, menu)
                    end)
                end
            end)
        elseif current.value == 'server' then
            local elements = {}
            for k, v in pairs(Config.Admin.Elements['server']) do
                if not v.requires or getPerm(v.requires, perm) then
                    table.insert(elements, v)
                end
            end
            UI:Open('Menu', {
                name = 'admin-server',
                title = 'Server',
                align = 'top-right',
                elements = elements
            }, function(data, menu)
                if data.current.value == 'unban_player' then
                    local players = Event:TriggerCbSync('dwb:admin:get:banned:players')
                    local elements = players
                    local pages2 = { {} }
                    local pageLabels = { 'x d' }
                    local count = 0
                    for k, v in pairs(players) do
                        table.insert(pages2[#pages2], v)
                        count = count + 1
                        if count >= 10 then
                            table.insert(pages2, {})
                            count = 0
                            table.insert(pageLabels, #pages2)
                        end
                    end
                    -- for k, v in pairs(players) do
                    --     table.insert(elements, {
                    --         label = v.name .. ' ' .. v.source,
                    --         value = 'player',
                    --         source = v.source,
                    --         name = v.name
                    --     })
                    -- end

                    local menu = UI:Open('MenuSide', {
                        show = true,
                        name = 'admin-menu-x d',
                        title = 'Stroje',
                        align = 'middle',
                        side = 'left',
                        main = 0,
                        pages = pages2,
                        pageLabels = pageLabels
                    }, function(data, menu)
                        menu.close()
                    end, function(data, menu)
                        menu.close()
                    end, function(data, menu)
                        local current = data.current
                        Event:TriggerNet('dwb:admin:unban:player', data)
                    end)
                end
            end)
        elseif current.value == 'options' then
            local elements = {}
            for k, v in pairs(Config.Admin.Elements['options']) do
                if not v.requires or getPerm(v.requires, perm) then
                    if v.valType then
                        v.value = speed
                    end
                    table.insert(elements, v)
                end
            end
            UI:Open('Menu', {
                name = 'admin-options',
                title = 'Opcie ',
                align = 'top-right',
                elements = elements
            }, function(data, menu)
                if data.current.value == 'noclip' then
                    noclipMe()
                elseif data.current.valType then
                    speed = data.current.value
                elseif data.current.value == 'tpm' then
                    tpm()
                elseif data.current.value == 'inv' then
                    inv()
                end
            end)
        end
    end)
end