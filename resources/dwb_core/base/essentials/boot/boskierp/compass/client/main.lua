Thread:Create(function()

    function convert(angle)
        return (angle + 360) % 360
    end

function calculate_heading(cameraRotation)
    -- Extract the yaw (Y-axis rotation) from the cameraRotation vector
    local yaw = cameraRotation.z

    -- Adjust the yaw angle to be in the range of 0 to 360 degrees


    local heading = yaw % 360
    return heading

end
      
    while true do
        Wait(tonumber(DWB.UISettings['compass-update']) or 100) -- 10 
        if DWB.UISettings['compass'] then
            -- local heading = (GetGameplayCamRelativeHeading())
            -- local ang = convert(heading)
            local heading = calculate_heading(-GetGameplayCamRot(0))


            -- -- SendNuiMessage(json.encode({
            -- --     type = 'Compass',

            -- --     action = 'open',
            -- --     data = {
            -- --         show = true,
            -- --         currentHeading = true
            -- --     },
            -- --     log = true
            -- -- }))
            UI:Action('Compass', 'compass', 'open', {
                show = true,
                currentHeading = heading
            })
        end
    end
end)

Event:Register('dwb:settings:changed', function(set)
    if set['compass'] then
        UI:Action('Compass', 'compass', 'open', {show = true, currentHeading = 0})
    else
        UI:Action('Compass', 'compass', 'close', {})
    end
end)