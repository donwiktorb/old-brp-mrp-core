--- Cam Module
---Provides functionality for managing input controls.
---@module Cam

--- Controls class for managing input states.
---@type Cam
Cam = class()

Cam.cameras = {}

--- Start cinematic camera at vehicle
---@param veh integer
---@param coords table
function Cam:CinameticVehicle(veh, coords)
  local coords = coords or GetEntityCoords(veh)
  local cam =
    CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords, 0.0, 0.0, 0.0, 90.0, true, 2)
  -- local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
  --
  PointCamAtEntity(cam, veh, 0.0, 0.0, 0.0, true)
  RenderScriptCams(true, true, 200, true, true)
  local offsets = {
    { 5.0, 5.0, 2.33 },
    { -4.0, -4.0, 2.33 },
    { 4.0, -4.0, 0.33 },
    { -4.0, 4.0, 2.33 },
  }
  local points = {}

  for i = 1, 4 do
    local off = offsets[i]
    local coords = GetOffsetFromEntityInWorldCoords(veh, off[1], off[2], off[3])
    SetCamParams(cam, coords, 0, 0, 0, 43.0557, 9100, 0, 0, 2)
    PointCamAtEntity(cam, veh, 0.0, 0.0, 0.0, true)
    Wait(3000)
  end

  RenderScriptCams(false, true, 200, true, false)
  DestroyCam(cam, true)
end

--- Create camera
---@param name string
---@param cb function
---@param handle boolean
---@param camName string
---@param data table
function Cam:Create(name, cb, handle, camName, data)
  local coords = data.coords
  local fovMin = data.fovMin
  local fovMax = data.fovMax
  local speedLR = data.speedLR
  local speedUD = data.speedUD
  local zoomSpeed = data.zoomSpeed

  if not coords then
    local cam = CreateCam(camName or "DEFAULT_SCRIPTED_CAMERA", true)
    RenderScriptCams(true, true, 200, true, false)

    Cam.cameras[name] = {
      cam = cam,
      handle = handle,
      fovMax = fovMax,
      fovMin = fovMin,
      speedLR = speedLR,
      speedUD = speedUD,
      zoomSpeed = zoomSpeed,
      fov = (fovMax + fovMin) * 0.5,
    }
    if cam then
      cb(cam)
    end
  else
    local rots = data.rots or { x = 0, y = 0, z = 0 }
    local cam = CreateCamWithParams(
      camName or "DEFAULT_SCRIPTED_CAMERA",
      coords.x,
      coords.y,
      coords.z,
      rots.x,
      rots.y,
      rots.z,
      fov,
      true,
      2
    )
    RenderScriptCams(true, true, 200, true, false)

    Cam.cameras[name] = {
      cam = cam,
      handle = handle,
      fov_max = fov_max,
      fov_min = fov_min,
      speed_lr = speed_lr,
      speed_ud = speed_ud,
      zoomspeed = zoomspeed,
      fov = (fovMax + fovMin) * 0.5,
    }
    if cb then
      cb(cam)
    else
      return cam
    end
  end
end

--- Create entity camera
---@param name string
---@param cb function
---@param handle boolean
---@param entity integer
---@param data table
function Cam:CreateEntity(name, cb, handle, entity, data)
  local fovMin = data.fovMin
  local fovMax = data.fovMax
  local speedLR = data.speedLR
  local speedUD = data.speedUD
  local zoomSpeed = data.zoomSpeed
  local minX = data.minX
  local maxX = data.maxX

  local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
  AttachCamToEntity(
    cam,
    entity,
    data.offsetX or 0.0,
    data.offsetY or 0.0,
    data.offsetZ or 0.0,
    true
  )
  SetCamRot(cam, 0.0, 0.0, GetEntityHeading(entity))
  SetCamFov(cam, (fovMax + fovMin) * 0.5)
  RenderScriptCams(true, false, 0, 1, 0)

  Cam.cameras[name] = {
    cam = cam,
    handle = handle,
    fovMax = fovMax,
    fovMin = fovMin,
    speedLR = speedLR,
    speedUD = speedUD,
    zoomSpeed = zoomSpeed,
    fov = (fovMax + fovMin) * 0.5,
    rotatePed = data.rotatePed,
    rotateEntity = data.rotateEntity,
    entity = entity,
    minX = minX,
    maxX = maxX,
  }

  if cb then
    cb(cam)
  end
  return cam
end

--- Destroy camera
---@param name string
---@param cb function
function Cam:Destroy(name, cb)
  if Cam.cameras[name] then
    RenderScriptCams(false, true, 200, true, false)
    DestroyCam(Cam.cameras[name].cam, true)
    Cam.cameras[name] = nil
    if cb then
      cb()
    end
  end
end

--- Get all cameras
function Cam:GetAll()
  return Cam.cameras
end
