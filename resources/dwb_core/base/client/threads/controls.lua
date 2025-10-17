Thread:Create(function()
    while true do 
        local sleep = 0
        if Controls:GetDisabledAll() then
            DisableAllControlActions(0)
            for k,v in pairs(Controls:GetEnabled()) do
                EnableControlAction(0, v, true)
            end
        else
            local disabled = Controls:GetDisabled()
            if #disabled > 0 then
                for k,v in pairs(disabled) do
                    DisableControlAction(0, v, true)
                end
            else
                sleep = 500
            end
        end
        Wait(sleep)
    end
end)