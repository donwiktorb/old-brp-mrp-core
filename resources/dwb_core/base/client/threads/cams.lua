function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function HandleZoom(cam, obj)
    local fov = obj.fov
    local fovMin = obj.fovMin
    local fovMax = obj.fovMax
    local zoomSpeed = obj.zoomSpeed

	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomSpeed, fovMin)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomSpeed, fovMax) -- ScrollDown		
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
    obj.fov = fov
end

-- function calculate_heading(rotationX, rotationZ)
--     -- Convert the rotations to radians
--     local rad_rotationX = math.rad(rotationX)
--     local rad_rotationZ = math.rad(rotationZ)

--     -- Calculate the heading angle
--     local heading = math.atan2(math.sin(rad_rotationZ), math.cos(rad_rotationZ) * math.cos(rad_rotationX))

--     -- Convert the heading angle from radians to degrees and adjust to be in the range of 0 to 360 degrees
--     local heading_degrees = math.deg(heading) % 360

--     return heading_degrees
-- end

function calculate_heading(cameraRotation)
    -- Extract the yaw (Y-axis rotation) from the cameraRotation vector
    local yaw = cameraRotation.z

    -- Adjust the yaw angle to be in the range of 0 to 360 degrees
    local heading = yaw % 360

    return heading
end

-- -- function calculate_heading(yaw, pitch, roll)
-- --     -- Calculate the heading angle from the yaw (Y-axis rotation)
-- --     local heading = yaw % 360

-- --     -- Adjust the heading angle to be in the range of 0 to 360 degrees
-- --     if heading < 0 then
-- --         heading = heading + 360
-- --     end

-- --     return heading
-- -- end


function CheckInputRotation(cam, zoomvalue, speedLR, speedUD, rotatePed, rotateEntity, entity, minX, maxX)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		local new_z = rotation.z + rightAxisX*-1.0*(speedUD)*(zoomvalue+0.1)
		local new_x = math.max(math.min(maxX or 20.0, rotation.x + rightAxisY*-1.0*(speedLR)*(zoomvalue+0.1)), minX or -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
        if minX then
            -- print(minX, rightAxisX, new_x, rotation.x)
            if new_x <= minX then
                new_x = minX
            end
        elseif maxX then
            if new_x >= maxX then
                new_x = maxX
            end
        end
		SetCamRot(cam, new_x, 0.0, new_z, 2)
        if rotatePed then
            local heading = math.atan2(rotation.z, -rotation.x) * 360 / math.pi
            -- -- print(heading, rotation.x, rotation.y)
            SetEntityHeading(PlayerPedId(), heading)
        end
        if rotateEntity then
            -- local heading = math.atan2(rotation.z, -rotation.x) * 360.0 / math.pi
            local heading = calculate_heading(rotation)
            -- -- print(heading, rotation.x, rotation.y)
            print(heading, GetEntityHeading(PlayerPedId()))
            SetEntityHeading(entity, heading)
        end
	end
end

Thread:Create(function()
    while true do
        local allCam = Cam:GetAll()
        local sleep = 500
        for k,v in pairs(allCam) do
            if v.handle then
                sleep = 0
                local zoomvalue = (1.0/(v.fovMax-v.fovMin))*(v.fov-v.fovMin)
                CheckInputRotation(v.cam, zoomvalue, v.speedLR, v.speedUD, v.rotatePed, v.rotateEntity, v.entity, v.minX, v.maxX)
                HandleZoom(v.cam, v)
            end
        end
        Wait(sleep)
    end
end)