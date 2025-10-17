local play = false
local ball
local map4 = {
    vec3(792.3, -266.45, 66.1), -- A
    vec3(732.5, -235.93, 66.1), -- B

    vec3(749.3 , -201.7 , 66.1), -- C

    vec3(810.3 , -232.3 , 66.1), -- D
}
local map2 = {
    vec3(749.24, -201.77, 66.1), -- A
    vec3(792.47, -266.6, 66.0) -- D
}

local map = {
    vec3(810.2, -323.1, 66.1),
    vec3(792.47, -266.63, 66.0),

    vec3(792.47, -266.63, 66.0),
    vec3(749.25, -201.48, 66.1),

    vec3(749.25, -201.48, 66.1),
    vec3(732.43, -235.9, 66.1),

    vec3(732.43, -235.9, 66.1),
    vec3(810.2, -323.1, 66.1)
}

local goals = {
    {
        vec3(803.24, -245.42, 73.3), -- D
        vec3(808.3,-247.9,65.9), -- C
        vec3(804.7, -254.32, 65.9), --B
        vec3(800.0, -251.87, 73.3), -- A
    },
    {
        vec3(739.33,-222.07, 70.3), -- a
        vec3(735.37,-220.07,66.1), --b
        vec3(737.3,-213.3,66.1), --c
        vec3(742.5,-215.4,70.3) --d
    },
}

function isBetweenPoints(c, points)
    local state = true
    for k,a in pairs(points) do
        local b = points[k+1]
        if not b then
            b = points[1]
        end

        local xd = ((b.x - a.x)*(c.y - a.y)) - ((b.y - a.y)*(c.x - a.x)) - ((b.z - a.z)*(c.z-a.z))

        print(xd)

        if xd > 0 then
            state = false
        end
    end
    return state

end

Event:Register('dwb:soccer:play', function(netId)
    ball = NetworkGetEntityFromNetworkId(netId)
    play = not play
    if play then
        Thread:Create('soccer', function()
            while play do
                Wait(0)
                local coords = DWB.PlayerData.Coords
                print('---------------')
                -- print(isBetweenPoints(coords, map4))
                print(isBetweenPoints(coords, goals[2]))
            end
        end)
    else
        Thread:Remove('soccer')
    end
end, true)