function User:TeleportToCoords(coords, heading)
    Event:TriggerNet('dwb:teleport:start', self.source, heading and {
        coords = coords,
        heading = heading
    } or coords)
end

function User:TeleportIntoVehicle(veh, seat)
    SetPedIntoVehicle(GetPlayerPed(self.source), veh, seat or -1)
end