function convertMinutesToHours(minutes)
    local hours = math.floor(minutes/60)
    local minutes = minutes-(hours*60) 
    return hours, minutes
end

Event:Register('dwb:tick:minute', function(minutes)
    local hour,minute = convertMinutesToHours(minutes)
    -- local hour3 = tonumber(GetConvar('uptimeHour', '0'))
    -- local minute3 = tonumber(GetConvar('uptimeHour', '0'))
    -- if hour4 and hour4 > 0 then
    --     hour = hour + hour
    -- end
    -- if minute4 and minute4 > 0 then
    --     minute = minute + minute4
    -- end
    SetConvarReplicated('uptimeHour', tostring(hour))
    SetConvarReplicated('uptimeMinute', tostring(minute))
    -- hour = #tostring(hour) == 1 and '0'..hour or hour
    -- minute = #tostring(minute) == 1 and '0'..minute or minute
    -- local time = hour..':'..minute
    -- SetConvarReplicated('uptime', time)
end)