local enabled = false
local cam = false

local speed_lr = 4.0 -- speed by which the camera pans left-right 
local speed_ud = 4.0 -- speed by which the camera pans up-down
local fov_max = 80.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)

local zoomspeed = 3.0 -- camera zoom speed
local fov = (fov_max+fov_min)*0.5
local veh 

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function createCam(veh)
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
        AttachCamToEntity(cam, veh, 0.0,0.0,-1.5, true)
        SetCamRot(cam, 0.0,0.0,GetEntityHeading(veh))
        SetCamFov(cam, fov)
        RenderScriptCams(true, false, 0, 1, 0)
    end
    return cam
end

Key:onJustPressed('E', 'Kamera', function()
    local ped = PlayerPedId()
    veh = GetVehiclePedIsIn(ped)
    if veh ~= 0 then
        enabled = not enabled
        if enabled then
            createCam(veh)     
        else
            fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
            RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
            DestroyCam(cam, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if enabled then
            if not IsPedInAnyVehicle(ped) or GetEntityHeightAboveGround(veh) < 5.0 then
                enabled = false
                fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
                RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
                DestroyCam(cam, false)
                
            else
                local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                CheckInputRotation(cam, zoomvalue)
                HandleZoom(cam)
            end
        end
    end
end)