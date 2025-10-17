
Event:Register('dwb:vehsync:toggle', function(source, xPlayer,netId, key)
    local veh = NetworkGetEntityFromNetworkId(netId)
    Entity(veh).state.manage = true
    Entity(veh).state[key] = not Entity(veh).state[key]
end ,true)

Event:Register('dwb:vehsync:state', function(source, xPlayer,netId, key)
    local veh = NetworkGetEntityFromNetworkId(netId)
    Entity(veh).state.manage = true
    local state = Entity(veh).state.state or 0
    if state >= 2 then
        Entity(veh).state.state = 0
    else
        Entity(veh).state.state = state+1
    end
end ,true)

Event:Register('dwb:vehsync:horn', function(source, xPlayer,netId, key)
    local veh = NetworkGetEntityFromNetworkId(netId)
    Entity(veh).state.manage = true
    Entity(veh).state.horn = key
    if key then
        Entity(veh).state.lastToggle = Entity(veh).state.toggle
        Entity(veh).state.toggle = true
        Entity(veh).state.lastState = Entity(veh).state.state
        Entity(veh).state.state = 3
    else
        Entity(veh).state.state = 0
        Entity(veh).state.toggle = false
    end
end ,true)