

-- Key:onJustPressed('F3', 'Menu animacji (F3)' ,function()
--     openMenu()
-- end)

-- _menuPool = NativeUI.CreatePool()

-- function handleOrientation(orientation)
-- 	if orientation == "right" then
-- 		return 1320
-- 	elseif orientation == "middle" then
-- 		return 730
-- 	elseif orientation == "left" then
-- 		return 0
-- 	end
-- end

-- Citizen.CreateThread(function()
-- 	if not GetResourceKvpString("ea_menuorientation") then
-- 		SetResourceKvp("ea_menuorientation", "right")
-- 		SetResourceKvpInt("ea_menuwidth", 0)
-- 		menuWidth = 0
-- 		menuOrientation = handleOrientation("right")
-- 	else
-- 		menuWidth = GetResourceKvpInt("ea_menuwidth")
-- 		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
-- 	end 
-- 	mainMenu = NativeUI.CreateMenu("dwb", "~b~Opcje", menuOrientation, 0)
-- 	_menuPool:Add(mainMenu)

-- 	mainMenu:SetMenuWidthOffset(menuWidth)	
-- 	_menuPool:ControlDisablingEnabled(false)
-- 	_menuPool:MouseControlsEnabled(false)
	
		
-- 	while true do
-- 		if _menuPool then
-- 			_menuPool:ProcessMenus()
-- 		end
-- 		if (IsControlJustReleased(0, 170) and GetLastInputMethod( 0 ) )  then --M by default
-- 			-- clear and re-create incase of permission change+player count change
--             if mainMenu:Visible() then
--                 mainMenu:Visible(false)
--                 _menuPool:Remove()
--                 collectgarbage()
--             else
--                 GenerateMenu()
--                 mainMenu:Visible(true)
--             end
-- 		end
		
-- 		Citizen.Wait(1)
-- 	end
-- end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(60)
	end
end

Key:onJustPressed('X', 'Podnoszenie rąk (X)' ,function()
    local ped = PlayerPedId()
    if ( not IsEntityDead( ped ) ) then
        loadAnimDict("random@mugging3")

        if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
            ClearPedSecondaryTask(ped)
        else
            TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
        end
    end
end)

function deleteAllProps()
    for k,v in pairs(Config.Props) do
        DeleteEntity(v)
    end
    Config.Props = {}
end

function startFaceExpression(anim)
    SetFacialIdleAnimOverride(PlayerPedId(), anim)
end

function startAnimAngle(angle, lib, anim, loop, car)
    if car == 0 and IsPedInAnyVehicle(PlayerPedId()) then return end

    local ped = PlayerPedId()
    local co = GetEntityCoords(ped)
    local he = GetEntityHeading(ped)
    if not IsPedInAnyVehicle(ped, true) then
        Stream:RequestAnimDict(lib, function()
            TaskPlayAnimAdvanced(ped, lib, anim, co.x, co.y, co.z, 0, 0, he-angle, 8.0, 3.0, -1, loop, 0.0, 0, 0)
        end)
    end
end

RegisterCommand("unbindanim", function(source, args, rawCommand)
    if not args[1] then Notification:Show("Niepoprawne użycie (np /unbindanim klawisz) ") return end
    ExecuteCommand('unbind keyboard '..args[1])
    Notification:Show("Odbindowano klawisz "..args[1])

end, false)

RegisterCommand("bindanim", function(source, args, rawCommand)
    if not args[1] or not args[2] then Notification:Show("Niepoprawne użycie (np /bindanim nazwa klawisz) ") return end
    for k,v in pairs(Config.Animations) do
        for i=1, #v.items, 1 do
            if v.items[i].data.e == args[1] then
                RegisterKeyMapping('e '..args[1], v.label, 'keyboard', args[2])
                Notification:Show("Zbindowano klawisz "..args[2].." pod animację "..args[1])

                return
            end
        end
    end
    Notification:Show("Nie znaleziono animacji o takiej nazwie (/e "..args[1]..")")

end, false)

RegisterNetEvent('dwb_animations:startAnimForce')
AddEventHandler('dwb_animations:startAnimForce', function(lib, anim, heading, coords)
    Stream:RequestAnimDict(lib, function()
        if coords then
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        end
        SetEntityHeading(PlayerPedId(), heading)
        TaskPlayAnim(PlayerPedId(), lib, anim, -8.0, 8.0, -1, 0, 0, false, false, false)
    end)
end)

RegisterNetEvent('dwb_animations:startAnim')
AddEventHandler('dwb_animations:startAnim', function(player, lib, anim, offset)
    local timer = 6000
    while timer > 0 do
        timer = timer - 1
        Notification:ShowHelp("Zaproszenie do wspólnej animacji od "..player.." naciśnij ~INPUT_MP_TEXT_CHAT_TEAM~, aby zaakceptować")
        if IsControlJustReleased(1,  246) then
            local pped = GetPlayerPed(player)
            local heading = GetEntityHeading(PlayerPedId())
            local pheading = GetEntityHeading(GetPlayerPed(player))
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, offset, 0.0)

            Callback:Trigger('dwb_animations:startAnimForce', function(data)
            
            end, player ,lib, anim, heading, pheading, coords)


            return
        end
        Wait(0)
    end
end)

function startSyncAnim(lib, anim, loop, car, prop, offset)
    if car == 0 and IsPedInAnyVehicle(PlayerPedId()) then return end
    local closestPlayer, closestPlayerDist = Player:GetClosest()
    if closestPlayer and closestPlayerDist <= 2 then
        Callback:Trigger('dwb_animations:startAnim', function(data)
            
        end, GetPlayerServerId(closestPlayer) ,lib, anim, offset)
    end
end

RegisterCommand("e", function(source, args, rawCommand)
    if args[1] then
        for k,v in pairs(Config.Animations) do
            for i=1, #v.items, 1 do
                if v.items[i].data.e == args[1] then
                    local type, prop, angle, lib, anim, loop, car = v.items[i].type, v.items[i].prop, v.items[i].angle, v.items[i].data.lib, v.items[i].data.anim, v.items[i].data.loop, v.items[i].data.car

                    if type == 'scenario' then
                        startScenario(anim, loop)
                    elseif type == 'walkstyle' then
                        startAttitude(lib, anim)
                    elseif type == 'faceexpression' then
                        startFaceExpression(anim)
                    elseif type == 'anim' then
                        startAnim(lib, anim, loop, car, prop)
                    elseif type == 'animangle' then
                        startAnimAngle(angle, lib, anim, loop, car, prop)
                    end
                end
            end
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end, false)

function startAttitude(lib, anim)
	Stream:RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim, loop, car, prop)
    if car == 0 and IsPedInAnyVehicle(PlayerPedId()) then return end
    Stream:RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 3.0, -1, loop, 1, false, false, false)
        -- if prop then prop() end
        -- deleteAllProps()
    end)
end

function startScenario(anim)
    if car == 0 and IsPedInAnyVehicle(PlayerPedId()) then return end

	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

local elements = {}

for k,v in pairs(Config.Animations) do
    table.insert(elements, {label = v.label, value = k})

end

function openMenu()
    -- UI:Open('Menu',
    -- {
    --     name=  'animations',
    --     title    = "Animacje",
    --     align    = 'right',
    --     elements = elements
    -- }, function(data, menu)
    --     -- menu.close()        
    --     local elements8 = {}
    --     for k,v in pairs(Config.Animations[data.current.value].items) do
    --         if v.data.e then
    --             table.insert(elements8, {label = v.label..'('..v.data.e..')', type = v.type, data = v})
    --         else
    --             table.insert(elements8, {label = v.label, type = v.type, data = v})
    --         end
    --     end

    -- UI:Open('Menu',
    --     {
    --         name = 'animations2',
    --         title    = "Animacje",
    --         align    = 'right',
    --         elements = elements8
    --     }, function(data8, menu8)
    --         -- menu8.close()        
    --         local v = data8.current.data
    --         local type, prop, angle, lib, anim, loop, car, offset = v.type, v.prop, v.angle, v.data.lib, v.data.anim, v.data.loop, v.data.car, v.data.offset
    --         if type == 'scenario' then
    --             startScenario(anim, loop)
    --         elseif type == 'walkstyle' then
    --             startAttitude(lib, anim)
    --         elseif type == 'faceexpression' then
    --             startFaceExpression(anim)
    --         elseif type == 'anim' then
    --             startAnim(lib, anim, loop, car, prop)
    --         elseif type == 'syncAnim' then
    --             startSyncAnim(lib, anim, loop, car, prop, offset or 0.0)
    --         elseif type == 'animangle' then
    --             startAnimAngle(angle, lib, anim, loop, car, prop)
    --         end
    --     end, function(data8, menu8)
    --         menu8.close()
    --     end)
    -- end, function(data, menu)
    --     menu.close()
    -- end)
end

-- function GenerateMenu() -- this is a big ass function
-- 	_menuPool:Remove()
-- 	_menuPool = NativeUI.CreatePool()
-- 	collectgarbage()
-- 	if not GetResourceKvpString("ea_menuorientation") then
-- 		SetResourceKvp("ea_menuorientation", "right")
-- 		SetResourceKvpInt("ea_menuwidth", 0)
-- 		menuWidth = 0
-- 		menuOrientation = handleOrientation("right")
-- 	else
-- 		menuWidth = GetResourceKvpInt("ea_menuwidth")
-- 		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
-- 	end 
	
-- 	mainMenu = NativeUI.CreateMenu("Animacje", "~g~Animacje", menuOrientation, 0)
-- 	_menuPool:Add(mainMenu)
	
-- 	mainMenu:SetMenuWidthOffset(menuWidth)	
-- 	_menuPool:ControlDisablingEnabled(false)
-- 	_menuPool:MouseControlsEnabled(false)
	
-- 	mainMenu:SetMenuWidthOffset(menuWidth)	

-- 	-- util stuff
-- 	players = {}
-- 	local localplayers = {}
-- 	for _, i in ipairs(Config.Animations) do
-- 		table.insert( localplayers, _ )
-- 	end

-- 	table.sort(localplayers)

-- 	for i,thePlayer in ipairs(localplayers) do
-- 		table.insert(players,thePlayer)
-- 	end

-- 	for i,thePlayer in ipairs(players) do
-- 		thisPlayer = _menuPool:AddSubMenu(mainMenu, Config.Animations[thePlayer].label ,"",true)
-- 		thisPlayer:SetMenuWidthOffset(menuWidth)
-- 		-- generate specific menu stuff, dirty but it works for now
--         for k,v in ipairs(Config.Animations[thePlayer].items) do
--             local type, prop, angle, lib, anim, loop, car, offset = v.type, v.prop, v.angle, v.data.lib, v.data.anim, v.data.loop, v.data.car, v.data.offset
--             local e = ''
--             if v.data.e then
--                 e = '/e '..v.data.e
--             end
-- 			local thisItem = NativeUI.CreateItem(v.label, e)
-- 			thisPlayer:AddItem(thisItem)
--             thisItem.Activated = function(ParentMenu,SelectedItem)
--                 if type == 'scenario' then
--                     startScenario(anim, loop)
--                 elseif type == 'walkstyle' then
--                     startAttitude(lib, anim)
--                 elseif type == 'faceexpression' then
--                     startFaceExpression(anim)
--                 elseif type == 'anim' then
--                     startAnim(lib, anim, loop, car, prop)
--                 elseif type == 'syncAnim' then
--                     startSyncAnim(lib, anim, loop, car, prop, offset or 0.0)
--                 elseif type == 'animangle' then
--                     startAnimAngle(angle, lib, anim, loop, car, prop)
--                 end
--             end
--         end
		
-- 		_menuPool:ControlDisablingEnabled(false)
-- 		_menuPool:MouseControlsEnabled(false)
-- 	end
	
-- 	_menuPool:ControlDisablingEnabled(false)
-- 	_menuPool:MouseControlsEnabled(false)
	
-- 	_menuPool:RefreshIndex() -- refresh indexes
-- end

-- Key:onJustReleased('X', 'Anulowanie animacji (X)' ,function()
--     local ped = PlayerPedId()
--     if IsInputDisabled(0) 
--         and not isDead 
--         and not IsAimCamActive() 
--         and not IsFirstPersonAimCamActive() 
--     then
--         ClearPedTasks(ped)
--         deleteAllProps()
--     end
-- end)

-- Key:onJustPressed('X', 'Anulowanie animacji (X) (2)' ,function()
--     local ped = PlayerPedId()
--     if IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_BAR") 
--         or IsPedUsingScenario(ped, "WORLD_HUMAN_PICNIC") 
--     then
--         ClearPedTasksImmediately(ped)
--         deleteAllProps()
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5)
--         local ped = PlayerPedId()
--         if IsControlJustReleased(0, 73) 
--             and IsInputDisabled(0) 
--             and not isDead 
--             and not IsAimCamActive() 
--             and not IsFirstPersonAimCamActive() 
--         then
--             ClearPedTasks(ped)
--             deleteAllProps()
--         elseif IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_BAR") 
--             or IsPedUsingScenario(ped, "WORLD_HUMAN_PICNIC") 
--         then
--             if IsControlJustPressed(0, 73) then
--                 ClearPedTasksImmediately(ped)
--                 deleteAllProps()
--             end
--         end
--     end
-- end)

Key:onJustPressed('X', 'Podnoszenie rąk (X)' ,function()
    local ped = PlayerPedId()
    if ( not IsEntityDead( ped ) ) then

        Stream:RequestAnimDict("random@muggin3", function()
            if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
                ClearPedSecondaryTask(ped)
            else
                TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
            end
        end)

    end
end)