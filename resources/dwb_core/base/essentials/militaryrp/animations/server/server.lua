

Callback:Register('dwb_animations:startAnim', function(source, cb, player, lib, anim, offset)
    if player then
        TriggerClientEvent('dwb_animations:startAnim', player, source, lib, anim, offset)
    end
    cb(true)

end)

Callback:Register('dwb_animations:startAnimForce', function(source, cb, player, lib, anim, heading, pheading, coords)
    local heading = heading - pheading
    TriggerClientEvent('dwb_animations:startAnimForce', player, lib, anim, heading-180, coords)
    TriggerClientEvent('dwb_animations:startAnimForce', source, lib, anim, heading)

    cb(true)

end)