Object = class()

function Object:Spawn(model, coords, cb)
	local model = (type(model) == "number" and model or GetHashKey(model))

	Thread:Create(function()
		Stream:RequestModel(model)

		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end

function Object:RayCast()
	local screenX = GetDisabledControlNormal(0, 239)
	local screenY = GetDisabledControlNormal(0, 240)
	local world, normal = GetWorldCoordFromScreenCoord(screenX, screenY)
	local depth = 10.0
	local target = world + normal * depth

	local startc = world
	local endc = target
	local rayHandle = StartShapeTestLosProbe(startc, target, 4294967295, PlayerPedId(), 4)
	local ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)

	while ret < 2 and ret ~= 0 do
		ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)
		Wait(0)
	end

	return ret, rayCat, endCoords, sNormal, entHit
end

function Object:GetInDirection(flag, coll)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	-- local rayHandle    = StartShapeTestLosProbe(playerCoords, inDirection, 10, playerPed, 0)

	local rayHandle = StartShapeTestLosProbe(playerCoords, inDirection, flag or 4294967295, PlayerPedId(), coll or 4)

	local ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)

	while ret < 2 and ret ~= 0 do
		ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)
		Wait(0)
	end

	return ret, rayCat, endCoords, sNormal, entHit
end

function Object:RayCastMid()
	local world, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)

	local camRot = GetGameplayCamRot(2)

	-- Convert rotation to radians
	local pitch = math.rad(-camRot.x)
	local roll = math.rad(camRot.y)
	local yaw = math.rad(-camRot.z)

	-- Define camera parameters
	local fovHorizontal = 90 -- Example FOV, adjust as needed
	local fovVertical = 60 -- Example FOV, adjust as needed
	local cameraHeight = 10 -- Example camera height, adjust as needed

	-- Calculate horizontal and vertical angles
	local horizontalAngle = math.atan(math.tan(fovHorizontal / 2) * (roll / (GetAspectRatio() * 1.333333)))
	local verticalAngle = math.atan(math.tan(fovVertical / 2) * (pitch / (GetAspectRatio() * 1.333333)))

	-- Calculate depth based on camera height
	local depth = cameraHeight / math.cos(verticalAngle)
	local target = world + normal * depth

	local startc = world
	local endc = target
	local rayHandle = StartShapeTestLosProbe(startc, target, 4294967295, PlayerPedId(), 4)
	local ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)

	while ret < 2 and ret ~= 0 do
		ret, rayCat, endCoords, sNormal, entHit = GetShapeTestResult(rayHandle)
		Wait(0)
	end

	return ret, rayCat, endCoords, sNormal, entHit, target
end

