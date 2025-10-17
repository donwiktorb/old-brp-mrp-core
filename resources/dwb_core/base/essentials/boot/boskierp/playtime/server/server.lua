
Event:Register('dwb:tick:minute', function(source, xPlayer)
    for k,v in pairs(DWB.Players) do
        local jo = v:GetJobByType('fraction')
        if jo then
            v:SetCharData('timeOnDuty', (v.char.data.timeOnDuty or 0) + 1)
        end
    end
end)