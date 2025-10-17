Users = class()

function Users:GetAllBy(cb, format)
    local users = {}
    for k,v in pairs(DWB.Players) do
        if cb(k,v) then
            table.insert(users, format and format(k,v) or {xPlayer = v, source = k})
        end
    end
    return users
end



function Users:GetAllByElements(cb)
    local users = Users:GetAllBy(cb, function(k,v)
        return {
            label = v:GetCharName(),
            value = k
        }
    end)

    return users
end
