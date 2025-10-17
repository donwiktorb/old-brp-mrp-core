local types = Config.Chat.MessageTypes

local function checkDistance(coords, dist, cb)
    for k,v in pairs(DWB.Players) do
        local ped2 = GetPlayerPed(k)
        local coords2 = GetEntityCoords(ped2)
        local distance = #(coords-coords2)

        if distance <= dist then
            cb(k, v)
        end


    end
end

function User:SendMessage(type, target, ...)
    local obj = types[type] and types[type] or {style = type}



    Event:TriggerNet('dwb:chat:addMessage', target or self.source, {
        template = obj.style,
        args = {...}
    })
end

function User:SendArea(type, coords, dist, ...)
    local obj = types[type] and types[type] or {style = type}
    if not coords then coords = GetEntityCoords(GetPlayerPed(self.source)) end
    local args = {...}
    checkDistance(coords, dist, function(k ,v)
        Event:TriggerNet('dwb:chat:addMessage', k, {
            template = obj.style,
            args = args
        })
    end)
end
