

function startFaceExpression(anim)
    SetFacialIdleAnimOverride(PlayerPedId(), anim)
end

function startAnimAngle(angle, lib, anim, loop, car)
    local ped = PlayerPedId()
    local co = GetEntityCoords(ped)
    local he = GetEntityHeading(ped)
    if not IsPedInAnyVehicle(ped, true) then
        Stream:RequestAnimDict(lib, function()
            TaskPlayAnimAdvanced(ped, lib, anim, co.x, co.y, co.z, 0, 0, he-angle, 8.0, 3.0, -1, loop, 0.0, 0, 0)
        end)
    end
end

local asking = false

Event:Register('dwb:animations:accept', function(p, heading, coords2,offset, data)
    local ped =GetPlayerPed( GetPlayerFromServerId(p))
    SetEntityHeading(PlayerPedId(), heading)
    local coords = coords2 or GetOffsetFromEntityInWorldCoords(ped, 0.0, offset, 0.0)
    SetEntityCoordsNoOffset(PlayerPedId(), coords)
    Animation:Play(PlayerPedId(), data.lib, data.anim, 8.0, 8.0, -1, 0, 0)
end, true)

-- -- Thread:Create(function()
-- --     local normal = 642383383
-- --     local normal2 = 1113513977
-- --     local last
-- --     while true do
-- --         Wait(0)
-- --         local  mov = GetPedMovementClipset(PlayerPedId())
-- --         if mov ~= normal and mov ~= normal2 then
-- --             last = mov
-- --         elseif last then
-- --             SetPedMovementClipset()
-- --         end
-- --     end
-- -- end)

RegisterCommand('e', function(s,a)
    for k,v in pairs(Config.Animations.Animations) do
        for k2,v2 in pairs(v.elements) do
            if v2.data.e and v2.data.e == a[1] then
            local anim = v2
            local type, prop, angle, lib, anim, loop, car, offset, data2, onlyCar = anim.type, anim.prop, anim.angle, anim.data.lib, anim.data.anim, anim.data.loop, anim.data.car, anim.data.offset, anim.data2, anim.onlyCar
            if not onlyCar or DWB.PlayerData.InVehicle then
                if type == 'scenario' then
                    startScenario(anim, loop)
                elseif type == 'walkstyle' then
                    startAttitude(lib, anim)
                elseif type == 'faceexpression' then
                    startFaceExpression(anim)
                elseif type == 'anim' then
                    startAnim(lib, anim, loop, car, prop)
                elseif type == 'syncAnim' then
                    startSyncAnim(lib, anim, loop, car, prop, offset or 0.0, data2)
                elseif type == 'animangle' then
                    startAnimAngle(angle, lib, anim, loop, car, prop)
                end
            end
            end
        end
    end
end)

Event:Register('dwb:animations:ask', function(src, coords,heading, asker, offset,data,data2)
    local coords = coords
    local heading = heading
    if asking then return end
    asking = true
    SendNuiMessage(json.encode({
        show = true,
        type = 'Notify2',
        action = 'open',
        data = {
            show = true,
            content = string.format("%s prosi o wspolna animacje. Naciśnij <k>G</k> aby zaakceptować albo <k>X</k>, aby odrzucić..", asker)
        }
    }))
    local timeout = 10000
    while timeout > 0 do
        Wait(0)
        timeout = timeout - 1
        if IsControlJustPressed(0, 47)  then
            timeout = 0
            local heading = GetEntityHeading(PlayerPedId())
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0,-offset, 0.0)
            Event:TriggerNet('dwb:animations:accept', src, heading, coords, offset,data,data2)
        elseif IsControlJustPressed(0, 73) then
            timeout = 0
        end
    end
    SendNuiMessage(json.encode({
        show = true,
        type = 'Notify2',
        action = 'close',
        content = string.format("%s prosi o wejście. Naciśnij <k>G</k> aby zaakceptować albo <k>X</k>, aby odrzucić..", asker)
    }))
    asking = false
end, true)

function startSyncAnim(lib, anim, loop, car, prop, offset, data2)
    local ret, rayCat, coords, sNoraml, entHit, player = User:GetInDirection()

    if ret and player then
        local servId = GetPlayerServerId(player)
        local heading = GetEntityHeading(PlayerPedId())
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, offset, 0.0)
        Event:TriggerNet('dwb:animations:ask', servId, coords, heading, offset, {
            anim = anim,
            lib = lib
        },data2)
    end
    -- -- -- -- local closestPlayer, closestPlayerDist = Player:GetClosest()
    -- -- -- -- if closestPlayer and closestPlayerDist <= 2 then
    -- -- -- --     Callback:Trigger('dwb_animations:startAnim', function(data)
            
    -- -- -- --     end, GetPlayerServerId(closestPlayer) ,lib, anim, offset)
    -- -- -- -- end
end

function startAttitude(lib, anim)
    DWB.PlayerData.AnimSet = {lib, anim}
	Stream:RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim, loop, car, prop, blendIn, blendOut, duration)
    Animation:Play(PlayerPedId(), lib, anim, blendIn or 8.0, blendOut or 3.0, duration or -1, loop, 1, false, false, false)
    if prop then
        prop()
    end
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function OpenAnimationList(all)
    local elements = {}
    for k,v in pairs(Config.Animations.Animations) do
        table.insert(elements, {
            label = v.label,
            name = v.name,
            value = k
        })  
    end
    UI:Open('Menu', {
        show = true,
        name = 'anims',
        align = 'right',
        title = 'Animacje',
        elements = elements,
        side = "right",
        main = 0,
    -- --     messages = {
    -- --         {
    -- --             type = 'info',
    -- --             label = 'Aktualna Cena',
    -- --             content = 0
    -- --         }
    -- -- }
    }, function(data,menu)
        local elements2 = {}
        for k,v in pairs(Config.Animations.Animations[data.current.value].elements) do
            if v.data and v.data.e and v.data.e ~= "" then
                table.insert(elements2, {
                    cat = data.current.value,
                    label = v.label.."(/e "..v.data.e..")",
                    value = k
                })
            else
                table.insert(elements2, {
                    cat = data.current.value,
                    label = v.label,
                    value = k
                })
            end
        end
        UI:Open('Menu', {
            show = true,
            name = 'anims-cat',
            align = 'right',
            title = 'Animacje',
            elements = elements2,
            side = "right",
            main = 0,
        -- --     messages = {
        -- --         {
        -- --             type = 'info',
        -- --             label = 'Aktualna Cena',
        -- --             content = 0
        -- -- }
        }, function(data2,menu2)
            local anim = Config.Animations.Animations[data.current.value].elements[data2.current.value]
            local type, prop, angle, lib, anim, loop, car, offset, data2, onlyCar = anim.type, anim.prop, anim.angle, anim.data.lib, anim.data.anim, anim.data.loop, anim.data.car, anim.data.offset, anim.data2, anim.onlyCar
            if not onlyCar or DWB.PlayerData.InVehicle then
                if type == 'scenario' then
                    startScenario(anim, loop)
                elseif type == 'walkstyle' then
                    startAttitude(lib, anim)
                elseif type == 'faceexpression' then
                    startFaceExpression(anim)
                elseif type == 'anim' then
                    startAnim(lib, anim, loop, car, prop)
                elseif type == 'syncAnim' then
                    startSyncAnim(lib, anim, loop, car, prop, offset or 0.0, data2)
                elseif type == 'animangle' then
                    startAnimAngle(angle, lib, anim, loop, car, prop)
                end
            end
        end)
    end)
end

Key:onJustPressed("F3", "Animacje", function()
    OpenAnimationList()
end)
Key:onJustPressedAndReleased('X', 'Podnoszenie rąk (X)' ,function()

    for k,v in pairs(Config.Animations.Props) do
        DeleteEntity(v)
    end
    local ped = PlayerPedId()
    Animation:Play(PlayerPedId(), "random@mugging3", "handsup_standing_base", 2.0, 2.0, -1, 49, 1.0)
end, function()
    if UI.CanOpen then
    ClearPedTasks(PlayerPedId())
    end
end)

Event:Register('dwb:animations:play', function(lib, anim, data)
    startAnim(lib, anim, data.loop, data.car, data.prop, data.blendIn, data.blendOut, data.duration)
end, true)

Event:Register('dwb:animations:play:task', function(lib, anim, data)
    startScenario(lib)
end, true)

Event:Register('dwb:animations:is:playing', function(netId, lib, anim, id)
    local IsPlayingAnim = IsEntityPlayingAnim(NetworkGetEntityFromNetworkId(netId), lib, anim, 3) == 1
    Event:TriggerNet('dw')
end, true)