
local handcuffed = false
local propId
local drag = {
    state = false,
    entity = nil,
    isDragged = false
}






Event:Register('dwb:player:vehicle:entering', function(veh, seat)
    if handcuffed and seat == -1 then
        ClearPedTasks(PlayerPedId())
    end

end)

function cuffPed(ped)
    NetworkRequestControlOfEntity(ped)
    Entity(ped).state.cuff = not Entity(ped).state.cuff
    if Entity(ped).state.cuff then
        FreezeEntityPosition(ped, true)
        ClearPedTasks(ped)
        SetEnableHandcuffs(ped, true)
        DisablePlayerFiring(ped, true)
        -- -- SetEnableBoundAnkles(ped, true)
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        SetPedCanPlayGestureAnims(ped, false)
    else
        FreezeEntityPosition(ped, false)
        SetEnableHandcuffs(ped, false)
        DisablePlayerFiring(ped, false)
        SetEnableBoundAnkles(ped, false)
        SetPedCanPlayGestureAnims(ped, true)
        ClearPedTasks(ped)
    end
end

function dragPed(ped)
    drag.state = not drag.state
    if drag.state then
        if DoesEntityExist(ped) then
            drag.entity = ped
            AttachEntityToEntity(ped, PlayerPedId(), 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
            drag.state = false
        end
    else
        DetachEntity(drag.entity)
    end
end

local function OpenMenu()


    UI:CloseAll()
    UI:Open('Menu', {
        name = 'handcuffs',
        title = 'Kajdanki',
        align = 'right',
        elements = {{label = 'Zakuj/Odk', value='cuff'},{label = 'Przenieś', value='drag'}, 
        {label = 'Przeszuka', value = 'search'}, 
        {label = 'Wsadź do auta', value='incar'}, {label = 'Wysadz z auta', value='outcar'}}
    }, function(data, menu)    
        local playerId, dist = User:GetClosest()
        local entHit = GetPlayerPed(playerId)
        if playerId and dist ~= -1 and dist <= 3.0 then
            local playerId = GetPlayerServerId(playerId)
            if data.current.value == 'cuff' then
                local IsPlayingAnim = IsEntityPlayingAnim(entHit, "mp_arresting", "idle", 3) == 1 or IsEntityPlayingAnim(entHit, "random@mugging3", "handsup_standing_base", 3) == 1
                local handcuffAnim = IsEntityPlayingAnim(entHit, "mp_arresting", "idle", 3 ) == 1
                local isInBw = IsEntityPlayingAnim(entHit, "combat@damage@writhe", "writhe_loop", 3) == 1 or IsEntityPlayingAnim(entHit, "random@crash_rescue@car_death@low_car", "loop", 3) == 1
                if IsPlayingAnim or handcuffAnim or User:GetJob('police') or isInBw then
                    Animation:Play(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, 8.0, 2000, 18, 0)
                    Sound:Play('Kajdanki', 0.9)
                    drag.state = false
                    Event:TriggerNet('dwb:handcuffs:state', playerId)
                end
            elseif data.current.value == 'drag' then
                Event:TriggerNet('dwb:handcuffs:drag', playerId)
            elseif data.current.value == 'search' then
                    Animation:Play(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, 8.0, -1, 49, 1.0)
                Event:TriggerNet('dwb:handcuffs:search:start', playerId)    
            elseif data.current.value == 'incar' then
                local veh = Vehicle:GetInDirection()
                local freeSeat = false

                if not veh then
                    local veh2, vehDist = Vehicle:GetClosest()
                    if vehDist <= 5.0 then
                        veh = veh2
                    end
                end

                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

                for i=1, maxSeats, 1 do
                    if IsVehicleSeatFree(veh, i) then
                        freeSeat = i
                        break
                    end
                end




                if freeSeat then            
                    drag.state = false
                Event:TriggerNet('dwb:handcuffs:person:veh', playerId, NetworkGetNetworkIdFromEntity(veh), freeSeat)    
                end
            else
                local veh = Vehicle:GetInDirection()
                local freeSeat = false

                if not veh then
                    local veh2, vehDist = Vehicle:GetClosest()
                    if vehDist <= 5.0 then
                        veh = veh2
                    end
                end

                Event:TriggerNet('dwb:handcuffs:person:out:veh', playerId, NetworkGetNetworkIdFromEntity(veh))    
            end
        end

    end)
end



RegisterCommand('anim', function(s, a)
    Animation:Play(PlayerPedId(), a[1], a[2], 3.0, 3.0, -1, tonumber(a[3]), 1.0)

    
end)
Event:Register('dwb:handcuffs:use', function()
    OpenMenu()
 
    -- -- -- -- local player, dist = User:GetClosest()
    -- -- -- -- local entHit = GetPlayerPed(player)

    -- -- -- -- if player and dist ~= -1 and dist <= 3.0 then
    -- -- -- --     local IsPlayingAnim = IsEntityPlayingAnim(entHit, "mp_arresting", "idle", 3) == 1 or IsEntityPlayingAnim(entHit, "random@mugging3", "handsup_standing_base", 3) == 1
    -- -- -- --     local handcuffAnim = IsEntityPlayingAnim(entHit, "mp_arresting", "idle", 3 ) == 1
    -- -- -- --     local playerId = GetPlayerServerId(player)
    -- -- -- -- else
    -- -- -- --     local ret, rayCat, endCoords, sNormal, entHit, player = User:GetPedInDirection()
    -- -- -- --     if ret then
    -- -- -- --         OpenMenu(playerId, entHit, true)
    -- -- -- --     end
    -- -- -- -- end
end, true)

local function startThis()
    UI:CloseAll()
    UI:SetCanOpen(false)
    Controls:Disable(
        24, 25, 257 ,21, 75, 45, 263, 140
    )
    while handcuffed do
        Wait(0)
        if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 49) then
            Animation.forced:Play(PlayerPedId(), "mp_arresting", "idle", 8.0, 8.0, -1, 49, 1.0)
            Wait(100)
        end
        if drag.state then
            if not drag.isDragged and drag.entity then
                AttachEntityToEntity(PlayerPedId(), drag.entity, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                drag.isDragged = true
            end
        elseif drag.isDragged then
            DetachEntity(PlayerPedId())
            drag.isDragged = false
        end
    end
    ClearPedTasks(PlayerPedId())
    UI:CloseAll()
    UI:RestoreCanOpen()
    Controls:RemoveDisable()
    Event:TriggerNet('dwb:handcuffs:delete', propId)
end

Event:Register('dwb:handcuffs:cuff', function(netId)
    if not handcuffed then
        propId = netId
        ClearPedTasks(PlayerPedId())
        local prop = NetworkGetEntityFromNetworkId(netId)
        AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.02, 0.06, 0.04, 0.0, 100.0, 110.0, true, true, false, true, 1, true)
        local ped = PlayerPedId()
        SetEnableHandcuffs(ped, true)
        DisablePlayerFiring(ped, true)
        -- -- SetEnableBoundAnkles(ped, true)
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        SetPedCanPlayGestureAnims(ped, false)
        handcuffed = true
        startThis()
    end
end, true)

Event:Register('dwb:handcuffs:uncuff', function()
    handcuffed = false
    drag.state = false
    local ped = PlayerPedId()
    SetEnableHandcuffs(ped, false)
    DisablePlayerFiring(ped, false)
    SetEnableBoundAnkles(ped, false)
    SetPedCanPlayGestureAnims(ped, true)
    ClearPedTasks(ped)
end, true)

Event:Register('dwb:handcuffs:drag', function(state, player)
    drag.state = not drag.state
    if drag.state then
        local ped = GetPlayerPed(GetPlayerFromServerId(player))
        if DoesEntityExist(ped) then
            drag.entity = ped
        else
            drag.state = false
        end
    end
end, true)
