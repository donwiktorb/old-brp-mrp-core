
Event:Register('dwb:team:chosen', function()
    Marker:Add('greenzones', {
        messages = {},
        marker = {
            -- type = 28,
            -- color = {
            --     r = 20,
            --     g = 222,
            --     b = 222,
            --     a = 222
            -- },
            -- animate = true
        },
        settings =  {
            drawDist = 200,
            radius = 200,
            overrideCoords = true,
            drawMarker = false
        },
        coords = GreenZones.Zones,
        functions = {
            onEnterCb = function(zone, pos)
                print('entered')
				NetworkSetFriendlyFireOption(false)
            end,
            onExitCb = function(zone, pos)
                print('exit')
				NetworkSetFriendlyFireOption(true)
            end
        }

    })

end, true)

