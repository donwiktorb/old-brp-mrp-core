Event:Register('dwb:skills:update', function(source, xPlayer,name, value)
    xPlayer:UpdateSkill(name, value)
end, true)