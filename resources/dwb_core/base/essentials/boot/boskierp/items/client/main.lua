
local show = false

local function startShow()
    local scaleform = Scaleform:Request('BINOCULARS') 
    BeginScaleformMovieMethod(scaleform, "SET_CAM_LOGO")
    ScaleformMovieMethodAddParamInt(0) -- 0 for nothing, 1 for LSPD logo
    EndScaleformMovieMethod()
    Cam:CreateEntity('showBin', false, true, PlayerPedId(), {
        fovMin = 5.0,
        fovMax = 80.0,
        speedLR = 4.0,
        speedUD = 4.0,
        zoomSpeed=  3.0,
        offsetZ = 1.0,
        rotatePed = true
    })
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
    while show do
        Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
    end
end

local shield = false


local function startMeeee()
    while shield do
        Wait(0)
        if not IsEntityPlayingAnim(PlayerPedId(), 'combat@gestures@gang@pistol_1h@beckon', '0', 50) then
            Animation:Play(PlayerPedId(), 'combat@gestures@gang@pistol_1h@beckon', '0', 8.0, 8.0, -1, 50, 0.0)
            Wait(5000)
        end
    end
end

Event:Register('dwb:shield2', function()
        ClearPedTasks(PlayerPedId())
        shield = false
         SetWeaponAnimationOverride(PlayerPedId(), GetHashKey("Default"))
end, true)
Event:Register('dwb:shield', function(objId)
    shield = true
    local obj = NetworkGetEntityFromNetworkId(objId)
    AttachEntityToEntity(obj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(PlayerPedId(), GetHashKey("Gang1H"))
    Animation:Play(PlayerPedId(), 'combat@gestures@gang@pistol_1h@beckon', '0', 8.0, 8.0, -1, 50, 0.0)
    startMeeee()
end, true)


Event:Register('dwb:ballistic2', function(objId)
    UI:CloseAll()
    local objId = objId 
    Animation:Play(PlayerPedId(), objId.anim.lib, objId.anim.anim, 8.0, 8.0, -1, 50, 0.0)
    UI:Open('Bar', {
        name = 'proof',
        time = tonumber(objId.time),
        show = true,
        task = 'Zakladasz kamizelke'
    }, function(data,menu)
        ClearPedTasks(PlayerPedId())
        AddArmourToPed(PlayerPedId(), objId.armor)
        menu.close()
    end)
    
end, true)

Event:Register('dwb:binoculars:show', function()
    show  = not show
    if show then
        startShow()
    else
        Cam:Destroy('showBin')
        ClearPedTasks(PlayerPedId())
    end
end, true)

Thread:Create(function()
    if IsWeaponValid(4221696920) then
        AddTextEntry("WT_GNADE_FLSH", "Flashbang")
    end

    while true do
        Wait(0)
        local shootin = IsPedShooting(PlayerPedId())
        if DWB.PlayerData.Weapon == GetHashKey('WEAPON_FLASHBANG') and shootin then
            RemoveAllPedWeapons(PlayerPedId(), p1)
            local obj = GetClosestObjectOfType(DWB.PlayerData.Coords, 50.0, GetHashKey('w_ex_flashbang'), false, false, false)
            if obj then
                Wait(2000)
                local coords=  GetEntityCoords(obj)
                DeleteEntity(obj)
                Event:TriggerNet('dwb:items:flash', coords, obj)
            end
        end
    end
end)
Event:Register('dwb:items:flash', function(coords, netId)
    local dist = #(DWB.PlayerData.Coords-coords)
    if dist <= 10.0 then
        while not NetworkDoesNetworkIdExist(netId) do
            Wait(0)
        end
        local ent = NetworkGetEntityFromNetworkId(netId)
        if ent and HasEntityClearLosToEntity(PlayerPedId(), ent, 17) and IsEntityOnScreen(ent) then
            Sound:Play('flashbang', 0.9)
            AnimpostfxPlay('Dont_tazeme_bro', 0, true)
            ShakeGameplayCam('HAND_SHAKE', 8.0)
            Animation:Play(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_intro', 8.0, 8.0, -1, 50)
            Particles:StartLoopCoord('core', 'ent_anim_paparazzi_flash', coords, false, 4000, 25.0)
            local timer = 400
            while timer > 0 do
                timer = timer - 1
                DisablePlayerFiring(PlayerId(), true)
                Wait(0)
            end
            ClearPedTasks(PlayerPedId())
            AnimpostfxStop('Dont_tazeme_bro')
            StopGameplayCamShaking(true)
        end
    end
end ,true)

function afterTimer(name, task, time, cb)
    UI:Open('Bar', {
        name = name,
        time = tonumber(time),
        show = true,
        task = task
    }, function(data,menu)
        menu.close()
        if cb then
            cb()
        end
    end)
end

Event:Register('dwb:items:usage', function(key, key2, data)
    local obj5 = Config.Items.Usable[key]
    local obj = obj5.items[key2]
    obj.used = not obj.used
    local cb = obj5.cb or obj.cb
    local animation = obj.animations or obj5.animations
    if not cb or cb() then
        local task = "Używasz przedmiotu"
        print('x d')
        local clothes = obj.clothes or obj5.clothes
        if obj.used then
            if animation then 
                local anim = animation.putOn
                Animation:Play(PlayerPedId(), anim.lib, anim.anim, 3.0, 3.0, -1, anim.flag)
            end
            local messages = obj.messages or obj5.messages
            if messages then
                if messages.putOn then
                    task = messages.putOn
                end
            end
            if clothes and clothes.putOn then
                Skinchanger:LoadSexClothes(clothes.putOn)
            end
        else
            if animation then 
                local anim = animation.putOff
                Animation:Play(PlayerPedId(), anim.lib, anim.anim, 3.0, 3.0, -1, anim.flag)
                local messages = obj.messages or obj5.messages
                if messages then
                    if messages.putOff then
                        task = messages.putOff
                    end
                end
            end

            if clothes and clothes.putOff then
                Skinchanger:RestoreSkinOnly(clothes.putOff)
            end
        end

        print('x d')
        
        local timer = obj.timer or obj5.timer

        if timer then
            afterTimer(obj.name, task, timer, function()
                ClearPedTasks(PlayerPedId())
            end)
        end

        local clientFunction = obj5.clientFunction or obj.clientFunction
        print(clientFunction)
        if clientFunction then
            clientFunction(data, obj)
        end
    end
end, true)

function V3Div(self,d)
  self = vector3(self.x / d,self.y / d,self.z / d)
  
  return self
end

function V3MulQuat(self,quat)    
  local num   = quat.x * 2
  local num2  = quat.y * 2
  local num3  = quat.z * 2
  local num4  = quat.x * num
  local num5  = quat.y * num2
  local num6  = quat.z * num3
  local num7  = quat.x * num2
  local num8  = quat.x * num3
  local num9  = quat.y * num3
  local num10 = quat.w * num
  local num11 = quat.w * num2
  local num12 = quat.w * num3
  
  local x = (((1 - (num5 + num6)) * self.x) + ((num7 - num12) * self.y)) + ((num8 + num11) * self.z)
  local y = (((num7 + num12) * self.x) + ((1 - (num4 + num6)) * self.y)) + ((num9 - num10) * self.z)
  local z = (((num8 - num11) * self.x) + ((num9 + num10) * self.y)) + ((1 - (num4 + num5)) * self.z)
  
  self = vector3(x, y, z) 
  return self
end

function V3SqrMagnitude(self)
  return self.x * self.x + self.y * self.y + self.z * self.z
end

function V3ClampMagnitude(self,max)
  if V3SqrMagnitude(self) > (max * max) then
    self = V3SetNormalize(self)
    self = V3Mul(self,max)
  end
  return self
end

function V3SetNormalize(self)
  local num = V3Magnitude(self)
  if num == 1 then
    return self
  elseif num > 1e-5 then
    self = V3Div(self,num)
  else
    self = vector3(0.0,0.0,0.0)
  end
  return self
end

function V3Mul(self,q)
  if type(q) == "number" then
    self = self * q
  else
    self = V3MulQuat(self,q)
  end
  return self
end

function V3Magnitude(self)
  return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

local drone

local cam
local soundId


local scaleformFunctions = {
    {
        name = 'SET_EMP_METER_IS_VISIBLE',
        value = 0,
        type = 'bool'
    },
    {
        name = 'SET_ZOOM',
        value = 0,
        type = 'int'
    },
    {
        name = 'SET_ZOOM',
        value = 0,
        type = 'int'
    }
}

function ScaleformInit()

    local sc = Scaleform:Request('DRONE_CAM')
    for k,v in pairs(scaleformFunctions) do
        if v.type == 'bool' then
            Scaleform:Bool(sc, v.name, v.value)
        elseif v.type == 'int' then
            Scaleform:Int(sc, v.name, v.value)
        end
    end
    return sc
end

Event:Register('dwb:items:drone', function(netId, explode)
    -- -- while not NetworkDoesNetworkIdExist(netId) do
    -- --     Wait(0)
    -- --     Log:Info('no net')
    -- -- end
    -- SetPlayerControl(PlayerId(), false)

    -- -- local sc = Scaleform:Request('DRONE_CAM')
    local sc = ScaleformInit()
    Animation:Play(PlayerPedId(), 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0)

    drone = NetworkGetEntityFromNetworkId(netId)
    NetworkRequestControlOfEntity(drone)
    while not NetworkHasControlOfEntity(drone) do
        NetworkRequestControlOfEntity(drone)
        Wait(0)
    end
    SetEntityAsMissionEntity(drone, true, true)
    SetObjectPhysicsParams(drone, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
    local min,max = GetModelDimensions(GetEntityModel(drone))
    cam = Cam:CreateEntity('drone', nil, true, drone, {
        offsetZ = -max.z/2,
        fovMin = 0.0,
        fovMax = 360.0,
        zoomSpeed = 20.0,
        rotateEntity = true,
        speedLR = 30.0,
        speedUD = 30.0,

    })    
    SetFocusEntity(drone, true)
    soundId = GetSoundId()    
    PlaySoundFromEntity(soundId, "Flight_Loop", drone, "DLC_BTL_Drone_Sounds", true, 0) 
    SendNuiMessage(json.encode({
        show = true,
        type = 'Notify2',
        action = 'open',
        data = {
            show = true,
            content = string.format("Naciśnij <k>SPACJA</k>, <k>SHIFT</k> aby lecieć w dół/góre. %s", 'Naciśnij <k>G</k>, aby go schowac.' or '')
            -- content = string.format("Naciśnij <k>SPACJA</k>, <k>SHIFT</k> aby lecieć w góre/dół lub <k>G</k>, aby schować drona. %s", explode and 'Naciśnij <k>H</k>, aby go wysadzić.' or '')
        }
    }))
    local droneObj = NetworkGetEntityFromNetworkId(netId)
    local x,y,z = 0,0,20.0
    local offX, offY, offZ = 0,0,0
    local movement_momentum = vector3(0.0, 0.0, 0.0)
    local agility = 20.0
    local max_boost = 50.0
    FreezeEntityPosition(PlayerPedId(), true)
    while drone do
        Wait(0)
        local moved = false
        if GetEntityHealth(drone) <= 999.9 then
            -- AddExplosion(GetEntityCoords(drone), 69, 0.5, true, false, 0.5)
            drone = nil
        end
        if DWB.PlayerData.IsDead then
            drone = nil
        end
        local forward,right,up,p = GetEntityMatrix(drone)
        local did_move = false
        -- if IsControlJustPressed(0, 47) then
        --     drone = nil
        -- end
        if IsControlPressed(0, 22) then
            -- z = z + 10.0
            movement_momentum = V3ClampMagnitude(movement_momentum - (up * agility),max_boost)
            did_move = true
        end
        if IsControlPressed(0, 21) then
            -- z = z - 10.0
            movement_momentum = V3ClampMagnitude(movement_momentum + (up * agility),max_boost)
            did_move = true

        end
        if IsControlPressed(0, 32) then
            -- x = x + 10.0 w
            movement_momentum = V3ClampMagnitude(movement_momentum + (forward * agility),max_boost)
            did_move = true

        end
        if IsControlPressed(0, 33) then
            -- x = x - 10.0 s
            movement_momentum = V3ClampMagnitude(movement_momentum - (forward * agility),max_boost)
            did_move = true

        end
        if IsControlPressed(0, 34) then
            -- y = y + 10.0 a
            movement_momentum = V3ClampMagnitude(movement_momentum - (right * agility),max_boost)
            did_move = true

        end
        if IsControlPressed(0, 35) then
            -- y = y - 10.0 d
            movement_momentum = V3ClampMagnitude(movement_momentum + (right * agility),max_boost)
            did_move = true

        end

        if IsControlJustPressed(0, 47) then
            drone = nil
            Event:TriggerNet('dwb:items:drone:back')
        end

          if not did_move then
            if V3Magnitude(movement_momentum) > 0.0 then
                movement_momentum = movement_momentum - ((movement_momentum / 10.0) * agility)
            end
        end
        DrawScaleformMovieFullscreen(sc, 255, 255, 255, 255, 255)
        if drone then
        ApplyForceToEntity(drone, 0, movement_momentum.x,movement_momentum.y,20.0 + movement_momentum.z, offX, offY, offZ, 0, false, true, true, false, true)       
        end
    end
    FreezeEntityPosition(PlayerPedId(), false)
    SetScaleformMovieAsNoLongerNeeded(sc)
    SendNuiMessage(json.encode({
        show = false,
        type = 'Notify2',
        action = 'close',
        content = string.format("%s prosi o wejście. Naciśnij <k>G</k> aby zaakceptować albo <k>X</k>, aby odrzucić..", asker)
    }))

    ClearPedTasks(PlayerPedId())
    StopSound(soundId)
    ReleaseSoundId(soundId)
    -- SetPlayerControl(PlayerId(), false)
    Cam:Destroy('drone')
    DeleteEntity(droneObj)
    SetFocusEntity(PlayerPedId(), true)
end, true)

Event:Register('dwb:lockpick:use', function()
    local veh = Vehicle:GetInDirection()

    if veh then
        Animation:Play(PlayerPedId(), 'rcmpaparazzo_2', 'shag_loop_poppy', 3.0, 3.0, -1, 54)
        UI:Open('Bar', {
            name = 'bar',
            task = 'Otwierasz pojazd',
            time = 15,
            autoClose = true
        }, function(data,menu)
            Event:TriggerNet('dwb:lockpick:use', NetworkGetNetworkIdFromEntity(veh))

            menu.close()
            ClearPedTasks(PlayerPedId())
        end)
    end
end, true)

Event:Register('dwb:items:drone:start', function(netId)
    local did_move
    
    while not NetworkDoesEntityExistWithNetworkId(netId) do Wait(0)
end
    local drone = NetworkGetEntityFromNetworkId(netId)
    NetworkRequestControlOfEntity(drone)

    while not NetworkHasControlOfEntity(drone) do
        NetworkRequestControlOfEntity(drone)
        Wait(0)
    end

    SetEntityAsMissionEntity(drone, true, true)
    SetObjectPhysicsParams(drone, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)

    local min,max = GetModelDimensions(GetEntityModel(drone))

    cam = Cam:CreateEntity('drone', nil, true, drone, {
        offsetZ = -max.z/2,
        fovMin = 0.0,
        fovMax = 360.0,
        zoomSpeed = 20.0,
        rotateEntity = true,
        speedLR = 30.0,
        speedUD = 30.0,

    })    

    SetFocusEntity(drone, true)

    while drone do
        Wait(0)
        local moved = false

        if GetEntityHealth(drone) <= 999.9 then
            drone = nil
        end

        local forward,right,up,pos = GetEntityMatrix(drone)
        local did_move = false


        if IsControlPressed(0, 22) then
            did_move = true
        end
        if IsControlPressed(0, 21) then
            did_move = true

        end
        if IsControlPressed(0, 32) then -- w
            did_move = true

        end
        if IsControlPressed(0, 33) then -- s
            did_move = true

        end
        if IsControlPressed(0, 34) then -- a
            did_move = true

        end
        if IsControlPressed(0, 35) then
            did_move = true

        end

        if IsControlJustPressed(0, 47) then
            drone = nil
        end
        if not did_move then
        end

        DrawScaleformMovieFullscreen(sc, 255, 255, 255, 255, 255)
        if drone then
            ApplyForceToEntity(drone, 0, v.x, v.y, v.z, 0.0, 0, 0, 0, false, true, true, false, true)     
        end
    end
end, true)
