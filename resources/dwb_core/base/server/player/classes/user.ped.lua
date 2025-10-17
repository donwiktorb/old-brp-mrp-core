


function User:GetPedCoords()
    return GetEntityCoords(GetPlayerPed(self.source))
end
function User:GetClosestPlayer(minDist)
    local player, dist = Core:GetClosestPlayer(self:GetPedCoords(), minDist)
    return player, dist
end