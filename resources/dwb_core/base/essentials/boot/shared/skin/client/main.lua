local cam, isCameraActive

local zoomOffset, camOffset, heading = 0.0, 0.0, 90.0

function startLoop()
  Thread:Create(function()
    while isCameraActive do
      Citizen.Wait(0)

      -- DisableControlAction(2, 30, true)
      -- DisableControlAction(2, 31, true)
      -- DisableControlAction(2, 32, true)
      -- DisableControlAction(2, 33, true)
      -- DisableControlAction(2, 34, true)
      -- DisableControlAction(2, 35, true)
      -- DisableControlAction(0, 25, true) -- Input Aim
      -- DisableControlAction(0, 24, true) -- Input Attack

      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)

      local angle = heading * math.pi / 180.0
      local theta = {
        x = math.cos(angle),
        y = math.sin(angle),
      }

      local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y),
      }

      local angleToLook = heading - 140.0
      if angleToLook > 360 then
        angleToLook = angleToLook - 360
      elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
      end

      angleToLook = angleToLook * math.pi / 180.0
      local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook),
      }

      local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y),
      }

      SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
      PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

      -- Notification:ShowHelp(TR('use_rotate_view'))
    end
  end)
end

function CreateSkinCam()
  if not DoesCamExist(cam) then
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
  end

  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)

  isCameraActive = true
  SetCamRot(cam, 0.0, 0.0, 270.0, true)
  SetEntityHeading(DWB.PlayerData.Ped, -35.0)
  startLoop()
end

function DeleteSkinCam()
  zoomOffset, camOffset, heading = 0.0, 0.0, 90.0

  isCameraActive = false
  SetCamActive(cam, false)
  RenderScriptCams(false, true, 500, true, true)
  cam = nil
end

function OpenSkin(submitCb, cancelCb, only, restrict, onlyExtras)
  Skinchanger:SaveSkin()
  local comps, max = Skinchanger:GetData()
  local skin = Skinchanger:GetSkin()
  local leaveThis = {}

  if restrict or only then
    for k, v in pairs(restrict or only) do
      leaveThis[v] = true
    end
  end

  local elements = {}

  for k, v in pairs(comps) do
    -- if not (restrict and leaveThis[v.name]) or not (only and not leaveThis[v.name]) then
    if
      (not only and not restrict)
      or (only and leaveThis[v.name])
      or (restrict and not leaveThis[v.name])
    then
      v.max = max[v.name]
      v.type = "slider"
      v.value = skin[v.name] or 0
      table.insert(elements, v)
      -- end
    end
  end

  CreateSkinCam()

  zoomOffset = elements[1].zoomOffset
  camOffset = elements[1].camOffset

  local extraElements = {}

  if onlyExtras then
    if onlyExtras[1] then
      table.insert(extraElements, {
        value = 0.0,
        min = -180.0,
        max = 180.0,
        step = 1.0,
        name = "cam",
        disableNumber = true,
        type = "slider",
        lable = "Obracanie kamery",
      })
    end

    if onlyExtras[2] then
      table.insert(extraElements, {
        value = 0.0,
        min = -0.80,
        max = 0.80,
        step = 0.1,
        name = "cam2",
        disableNumber = true,
        type = "slider",
        lable = "Obracanie kamery 2",
      })
    end

    if onlyExtras[3] then
    end
  else
    local el = {
      {
        value = 0.0,
        min = -180.0,
        max = 180.0,
        step = 1.0,
        name = "cam",
        disableNumber = true,
        type = "slider",
        lable = "Obracanie kamery",
      },
      {
        value = 0.0,
        min = -0.80,
        max = 0.80,
        step = 0.1,
        name = "cam2",
        disableNumber = true,
        type = "slider",
        lable = "Obracanie kamery 2",
      },
      {
        value = 0.0,
        min = 0.4,
        max = 1.5,
        step = 0.1,
        name = "cam3",
        disableNumber = true,
        type = "slider",
        lable = "Obracanie kamery 2",
      },
    }
    extraElements = el
  end

  UI:Open("MenuExtra", {
    name = "skin",
    title = "Menu skina",
    align = "right",
    elements = elements,
    extraElements = extraElements,
  }, function(data, menu)
    menu.close()
    DeleteSkinCam()
    if submitCb then
      submitCb(data, menu)
    end
  end, function(data, menu)
    Skinchanger:RestoreSkin()
    menu.close()
    DeleteSkinCam()
    if cancelCb then
      cancelCb(data, menu)
    end
  end, function(data, menu)
    if data.type == "extra" then
      if data.current.name == "cam" then
        local angle = data.current.value

        if angle > 360 then
          angle = angle - 360
        elseif angle < 0 then
          angle = angle + 360
        end

        heading = angle + 0.0
      elseif data.current.name == "cam2" then
        camOffset = data.current.value
      else
        zoomOffset = data.current.value
      end

      return
    elseif data.type == "submit" then
      camOffset = data.current.camOffset
    end

    local obj = data.current

    Skinchanger:Set(data.current.name, data.current.value)

    local maxVals = Skinchanger:GetMaxValues()

    for i = 1, #elements do
      local v = elements[i]
      local maxVal = maxVals[v.name]
      local update = false
      if v.max ~= maxVal then
        v.max = maxVals[v.name]
        update = true
      end

      if v.textureof and v.textureof == obj.name then
        v.value = 0
        update = true
      end
      if update then
        menu.update("name", v.name, v)
      end
    end
  end, function(data, menu)
    DeleteSkinCam()
  end)
end

Event:Register("dwb:skin:open:restricted", function(submit, cancel, restrict)
  OpenSkin(submit, cancel, restrict)
end, false)

Event:Register("dwb:skin:load", function(skin)
  while IsPlayerTeleportActive() do
    Wait(0)
  end

  while IsScreenFadedOut() do
    Wait(0)
  end
  Skinchanger:LoadSkin(skin)
end, true)

Event:Register("dwb:skin:load:default", function(skin)
  while IsPlayerTeleportActive() do
    Wait(0)
  end

  while IsScreenFadedOut() do
    Wait(0)
  end
  Skinchanger:LoadDefault("m", function()
    Skinchanger:Reset()
  end)
end, true)

Event:Register("dwb:skin:check", function(cb, cb2, cb3)
  Event:TriggerCb("dwb:skin:getPlayerSkin", function(skin, sex)
    if not skin then
      if cb then
        cb()
      end
      Skinchanger:LoadSkin({ sex == "m" and 0 or 1 })
      local cb2 = cb2
      OpenSkin(function()
        Event:TriggerNet("dwb:skin:save", Skinchanger:GetSkin())
        cb2()
      end, cb3)
    else
      Skinchanger:LoadSkin(skin)
    end
  end)
end, false)

Event:Register("dwb:skin:open:client", function()
  OpenSkin(function()
    Event:TriggerNet("dwb:skin:save", Skinchanger:GetSkin())
  end)
end, false)

Event:Register("dwb:skin:open", function()
  OpenSkin(function()
    Event:TriggerNet("dwb:skin:save", Skinchanger:GetSkin())
  end)
end, true)

Event:Register("dwb:skin:apply:clothes", function(clothes)
  if type(clothes) == "string" then
    clothes = Config.Clothes.Jobs[clothes]
  end
  Skinchanger:SaveClothes()
  Skinchanger:Apply(false, clothes)
end, true)

Event:Register("dwb:skin:restore:clothes", function(clothes)
  Skinchanger:RestoreSkin()
end, true)
