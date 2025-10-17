Core = class()

function Core:Teleport(entity, coords, cb)
	RequestCollisionAtCoord(coords.x, coords.y, coords.z)

	while not HasCollisionLoadedAroundEntity(entity) do
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		Citizen.Wait(0)
	end

	SetEntityCoords(entity, coords.x, coords.y, coords.z)

	if cb then
		cb()
	end
end

function Core:SetTimeout(msec, cb)
    local id = DWB.TimeoutCount + 1

	SetTimeout(msec, function()
		if DWB.CancelledTimeouts[id] then
			DWB.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	DWB.TimeoutCount = id

	return id
end

function Core:ClearTimeout(id)
	DWB.CancelledTimeouts[id] = true
end
