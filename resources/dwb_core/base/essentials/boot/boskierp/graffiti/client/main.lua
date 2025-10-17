
local scaleforms = {}
local drawing = false
local pos = {0.0, 0.0, 0.0}
local rot = {0.2, 0.0, 0.0}
local scale = {1.0, 1.0, 1.0}
local color = {255, 255, 255}
local text = nil
local fixCoords = vec3(0,0,0)
local fixRot = vec3(0,0,0)
local fixScale = vec3(0,0,0)
local drawScaleform = nil

function Initialize(scaleform, text, color2)
    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SET_SPLASH_TEXT")

    PushScaleformMovieFunctionParameterString("x d")

    ScaleformMovieMethodAddParamInt(5000)

    ScaleformMovieMethodAddParamInt(255)

    ScaleformMovieMethodAddParamInt(255)
    ScaleformMovieMethodAddParamInt(255)
    ScaleformMovieMethodAddParamInt(255)
    EndScaleformMovieMethod()


    BeginScaleformMovieMethod(scaleform, "SPLASH_TEXT_LABEL")

    ScaleformMovieMethodAddParamTextureNameString(text)
    ScaleformMovieMethodAddParamInt(255)
    ScaleformMovieMethodAddParamInt(255)

    ScaleformMovieMethodAddParamInt(255)
    ScaleformMovieMethodAddParamInt(255)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SPLASH_TEXT_COLOR")
    ScaleformMovieMethodAddParamInt(color2 and color2[1] or 255)
    ScaleformMovieMethodAddParamInt(color2 and color2[2] or 2255)
    ScaleformMovieMethodAddParamInt(color2 and color2[3] or 255)
    ScaleformMovieMethodAddParamInt(255)

    EndScaleformMovieMethod()
    return scaleform
end

Event:Register('dwb:graffiti:sync', function(data)
    scaleforms = data
end, true)

Thread:Create(function()
    while true do
        local sleep = 500
        if drawScaleform then
            sleep = 0
            local sc = drawScaleform.sc
            local coords = drawScaleform.coords
            local rot2 = drawScaleform.rot
            local scale2=drawScaleform.scale
            DrawScaleformMovie_3dSolid(sc, coords, rot2, 3.0, 3.0, 3.0, scale2, true)
        end
        Wait(sleep)
    end
end)

Thread:Create(function()
    while true do
        local sleep = 500
        if not drawScaleform then
            for k,v in pairs(scaleforms) do
                local dist = #(DWB.PlayerData.Coords-v.coords)
                if dist <= 10.0 then
                    local sc = Initialize("SPLASH_TEXT", tostring(v.text), v.color)
                    v.sc = sc
                    drawScaleform = v                                
                end
            end
        else
            local dist = #(DWB.PlayerData.Coords-drawScaleform.coords)
            if dist > 10.0 then
                drawScaleform = nil
            end
        end
        Wait(sleep)
    end
end)

function startDraw(value, coord)
    local sc = Initialize("SPLASH_TEXT", tostring(value))
    local heading = GetEntityHeading(PlayerPedId())
    drawing = true
    text = value
    Thread:Create(function()
        while drawing do
            Wait(0)
            local coords = vec3(coord.x+pos[1], coord.y+pos[2], coord.z+pos[3])
            fixCoords = coords
            local rot2 = vec3(rot[1], rot[2], heading+rot[3])
            fixRot = rot2
            local scale2 = vec3(scale[1], scale[2], scale[3])
            fixScale = scale2
            BeginScaleformMovieMethod(sc, "SPLASH_TEXT_COLOR")
            ScaleformMovieMethodAddParamInt(color[1])
            ScaleformMovieMethodAddParamInt(color[2])
            ScaleformMovieMethodAddParamInt(color[3])
            ScaleformMovieMethodAddParamInt(255)

            EndScaleformMovieMethod()
            DrawScaleformMovie_3dSolid(sc, coords, rot2, 3.0, 3.0, 3.0, scale2, true)
        end
        ClearPedTasks(PlayerPedId())
    end)
end

Event:Register('dwb:graffiti:draw', function()
    if drawScaleform then
        return Notification:ShowCustom('info', 'Grafiti', 'W poblizu jest jakies')
    end

    local r, cat, coords, normal, entHit = Object:GetInDirection(-1, 0)
    if cat then
        UI:CloseAll()
        UI:Open('MenuDialog', {
            name = 'graffiti',
            title = 'Wpisz tekst'
        }, function(data, menu)
            menu.close()
            local value = data.current.value
            startDraw(value, coords)
            local ad = 'anim@mp_player_intupperwave'
            local anim = 'idle_a'
            
            Animation:Play(PlayerPedId(), ad, anim, 3.0, 3.0, -1, 49, 1.0)
            UI:Open('MenuExtra', {
                name = 'graffiti',
                title    = 'Ustawienia',
                align    = 'right',
                extraElements = {
                    {
                        value = 0.4,
                        min = -1.5,
                        max = 1.5,
                        step = 0.1,
                        name = 'cam3',
                        disableNumber = true,
                        type = 'slider',
                        lable = 'Obracanie kamery 2'
                    }
                },
                elements = {
                    {
                        min = -10.0,
                        max = 10.0,
                        value = 0.0,
                        step = 0.5,
                        name = 'pos',
                        type = 'slider',
                        pos = 1,
                        label = 'Pozycja X'
                    },                
                    {
                        min = -10.0,
                        max = 10.0,
                        type = 'slider',
                        value = 0.0,
                        step = 0.5,
                        name = 'pos',
                        pos = 2,
                        label = 'Pozycja Y'
                    },
                    {
                        min = -10.0,
                        max = 10.0,
                        value = 0.0,
                        type = 'slider',
                        
                        step = 0.5,
                        name = 'pos',
                        pos = 3,
                        label = 'Pozycja Z'
                    },
                    {
                        min = -10.0,
                        max = 10.0,
                        value = 0.2,
                        step = 0.5,
                        name = 'rot',
                        type = 'slider',
                        pos = 1,
                        label = 'Rotacja X'
                    },
                    {
                        min = -10.0,
                        type = 'slider',
                        max = 10.0,
                        value = 0.0,
                        step = 0.5,
                        name = 'rot',
                        pos = 2,
                        label = 'Rotacja Y'
                    },
                    {
                        min = -10.0,
                        max = 10.0,
                        type = 'slider',
                        value = 0.0,
                        step = 0.5,
                        name = 'rot',
                        pos = 3,
                        label = 'Rotacja Z'
                    },
                    {
                        min = 0,
                        max = 255,
                        value = 255,
                        type = 'slider',
                        step = 1,
                        name = 'color',
                        pos = 1,
                        label = 'R'
                    },
                    {
                        min = 0,
                        max = 255,
                        type = 'slider',
                        value = 255,
                        step = 1,
                        name = 'color',
                        pos = 2,
                        label = 'G'
                    },
                    {
                        min = 0,
                        max = 255,
                        value = 255,
                        type = 'slider',
                        step = 1,
                        name = 'color',
                        pos = 3,
                        label = 'B'
                    },
                    {
                        min = 1.0,
                        max = 10.0,
                        value = 1.0,
                        type = 'slider',
                        step = 0.5,
                        name = 'scale',
                        pos = 1,
                        label = 'Skala X'
                    },
                    {
                        min = 1.0,
                        max = 10.0,
                        type = 'slider',
                        value = 1.0,
                        step = 0.5,
                        name = 'scale',
                        pos = 2,
                        label = 'Skala Y'
                    },
                    {
                        min = 1.0,
                        max = 10.0,
                        value = 1.0,
                        type = 'slider',
                        step = 0.5,
                        name = 'scale',
                        pos = 3,
                        label = 'Skala Z'
                    }                
                }
            }, function(data, menu)
                menu.close()
                drawing = false
                Event:TriggerNet('dwb:graffiti:new', fixCoords, fixScale, text, color, fixRot)
            end, function(data, menu)
                menu.close()
                drawing = false
            end, function(data,menu)
                if data.current.name == 'pos' then
                    pos[data.current.pos] = data.current.value
                elseif data.current.name == 'rot' then
                    rot[data.current.pos] = data.current.value
                elseif data.current.name == 'color' then
                    color[data.current.pos] = data.current.value
                elseif data.current.name == 'scale' then
                    scale[data.current.pos] = data.current.value
                end
            end)
        end)
    end
end, true)