-- local seconds = 0
local minutes = 0 

-- Timer:Set(function()
--     seconds = seconds + 1
--     Event:Trigger('dwb:tick:second:15', seconds)
--     -- Event:TriggerNet('dwb:tick:second', -1, seconds)
-- end, 15*1000)

Timer:Set(function()
    minutes = minutes + 1
    Event:Trigger('dwb:tick:minute', minutes)
    -- Event:TriggerNet('dwb:tick:minute', -1, minutes)
end, 60*1000)