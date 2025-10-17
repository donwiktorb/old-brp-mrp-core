local HasAlreadyEnteredMarker = false
local LastPart = {}
local currentZoneData
local currentPosData
local isInMarker, hasExited, letSleep = false, false, true

local CurrentAction = {}
local drawMarkers = {}

local inMarkers = {}
function enteredMarker(value, parent)
  local zoneData, posData = parent, value

  if not DWB.Zones[zoneData.name] then
    return
  elseif not DWB.Zones[zoneData.name].coords[posData.index] then
    return
  end

  local enterCb = (
    DWB.Zones[zoneData.name].coords[posData.index].functions
      and DWB.Zones[zoneData.name].coords[posData.index].functions.onEnterCb
    or DWB.Zones[zoneData.name].functions.onEnterCb
  )

  local autoRemove = false

  local settings = zoneData.settings

  if settings and settings.removeOnEnter then
    autoRemove = true
    table.remove(zoneData.coords, posData.index)
    if settings.createBlips then
      Blips:RemoveDynamic(zoneData.name, posData.blip)
    end
  end

  local removeMe = false

  if enterCb then
    removeMe = enterCb(zoneData, posData)
  end

  local finishRouteCb = (
    DWB.Zones[zoneData.name].coords[posData.index].functions
      and DWB.Zones[zoneData.name].coords[posData.index].functions.onFinishRouteCb
    or DWB.Zones[zoneData.name].functions.onFinishRouteCb
  )

  if #DWB.Zones[zoneData.name].coords <= 0 then
    if settings.autoRoute and finishRouteCb then
      finishRouteCb(zoneData, posData)
      DWB.Zones[zoneData.name] = nil
    end
  end

  if not DWB.Zones[zoneData.name] then
    inMarkers[zoneData.idx] = nil
    drawMarkers[zoneData.idx] = nil
    return
  elseif not DWB.Zones[zoneData.name].coords[posData.index] or removeMe or autoRemove then
    inMarkers[posData.idx] = nil
    drawMarkers[posData.idx] = nil
    return
  end

  local ActionMSG = (
    DWB.Zones[zoneData.name].coords[posData.index].messages
      and DWB.Zones[zoneData.name].coords[posData.index].messages.onEnter
    or DWB.Zones[zoneData.name].messages.onEnter
  )

  local ActionMSGVehicle = (
    DWB.Zones[zoneData.name].coords[posData.index].messages
      and DWB.Zones[zoneData.name].coords[posData.index].messages.onEnterInVehice
    or DWB.Zones[zoneData.name].messages.onEnterInVehicle
  )

  if ActionMSGVehicle then
    if IsPedInAnyVehicle(PlayerPedId()) then
      ActionMSG = ActionMSGVehicle
    end
  end

  if type(ActionMSG) == "function" then
    ActionMSG = ActionMSG(zoneData, posData)
  end

  if ActionMSG then
    SendNuiMessage(json.encode({
      type = "Notify2",
      action = "open",
      data = {
        show = true,
        content = ActionMSG,
      },
    }))
  end
end

function countMarkers2()
  local count = 0
  for k, v in pairs(inMarkers) do
    local zoneData, posData = v.parent, v.value
    if zoneData.messages then
      if zoneData.messages.onEnter then
        count = count + 1
      end
    elseif posData.messages then
      if posData.messages.onEnter then
        count = count + 1
      end
    end
  end
  return count
end

function countMarkers()
  local count = 0
  for k, v in pairs(inMarkers) do
    count = count + 1
  end
  return count
end

function leftMarker(value, parent)
  local zoneData, posData = parent, value

  -- for k2,v2 in pairs(CurrentAction) do
  --     if v2.zoneName == zoneData.name and v2.posIndex == posData.index then
  --         CurrentAction[k] = nil
  --     end
  -- end
  local markerCount = countMarkers2()
  if markerCount <= 1 then
    SendNuiMessage(json.encode({
      type = "Notify2",
      action = "close",
    }))
    if DWB.Zones[zoneData.name] then
      local exitCb = (
        DWB.Zones[zoneData.name].coords[posData.index].functions
          and DWB.Zones[zoneData.name].coords[posData.index].functions.onExitCb
        or DWB.Zones[zoneData.name].functions.onExitCb
      )
      if exitCb then
        exitCb(zoneData, posData)
      end
    end
  end
end

function IsPlayerInsideRectangle(A, B, C, D, Player)
  local minX = math.min(A.x, B.x, C.x, D.x)
  local maxX = math.max(A.x, B.x, C.x, D.x)
  local minY = math.min(A.y, B.y, C.y, D.y)
  local maxY = math.max(A.y, B.y, C.y, D.y)

  return Player.x >= minX and Player.x <= maxX and Player.y >= minY and Player.y <= maxY
end

function isPlayerInRectangle(playerCoords, rectangleCenter, rectangleHeight, rectangleWidth)
  local halfHeight = rectangleHeight / 2
  local halfWidth = rectangleWidth / 2

  local minX = rectangleCenter.x - halfWidth
  local maxX = rectangleCenter.x + halfWidth
  local minY = rectangleCenter.y - halfHeight
  local maxY = rectangleCenter.y + halfHeight

  return playerCoords.x >= minX
    and playerCoords.x <= maxX
    and playerCoords.y >= minY
    and playerCoords.y <= maxY
end

function isPointInsideRectangle(pointX, pointY, rectX, rectY, rectWidth, rectHeight)
  return pointX >= rectX
    and pointX <= rectX + rectWidth
    and pointY >= rectY
    and pointY <= rectY + rectHeight
end

function pointToLocalSpace(pointX, pointY, centerX, centerY, angle)
  local dx = pointX - centerX
  local dy = pointY - centerY

  local rotatedX = dx * math.cos(angle) + dy * math.sin(angle)
  local rotatedY = -dx * math.sin(angle) + dy * math.cos(angle)

  return rotatedX, rotatedY
end

-- -- function isPointInsideRotatedRectangle(pointX, pointY, rectCenterX, rectCenterY, rectWidth, rectHeight, angle)
-- --     local rotatedX, rotatedY = pointToLocalSpace(pointX, pointY, rectCenterX, rectCenterY, -angle)

-- --     local halfWidth = rectWidth / 2
-- --     local halfHeight = rectHeight / 2

-- --     return rotatedX >= -halfWidth and rotatedX <= halfWidth and rotatedY >= -halfHeight and rotatedY <= halfHeight
-- -- end

function rotateMe(rectCenter, radianRot)
  -- local rectX = (rectCenter.x*math.cos(radianRot)-rectCenter.y*math.sin(radianRot))
  -- local rectY = (rectCenter.x*math.sin(radianRot)+rectCenter.y*math.cos(radianRot))
  -- return vec2(rectX, rectY)
  --    local x = rectCenter.x
  --     local y = rectCenter.y
  --     local cosAngle = math.cos(radianRot)
  --     local sinAngle = math.sin(radianRot)
  --     local rotatedX = x * cosAngle - y * sinAngle
  --     local rotatedY = x * sinAngle + y * cosAngle
  --     return vec2(rotatedX, rotatedY)
  return rectCenter
end

function rotateMe3(pos, rot)
  local cos = math.cos(rot)
  local sin = math.sin(rot)

  local x = (pos.x * cos) - (pos.y * sin)
  local y = (pos.x * sin) + (pos.y * cos)
  return vec2(x, y)
end
function rotatePoint(x, y, centerX, centerY, angle)
  local cosA = math.cos(angle)
  local sinA = math.sin(angle)

  local relativeX = x - centerX
  local relativeY = y - centerY

  local rotatedX = centerX + (relativeX * cosA - relativeY * sinA)
  local rotatedY = centerY + (relativeX * sinA + relativeY * cosA)

  return rotatedX, rotatedY
end

-- -- function isPointInsideRotatedRectangle(playerCoords, rectCenter, rectWidth, rectHeight, rectRotation)
-- --     local radianRot = math.rad(rectRotation)
-- --     local width = rectWidth / 2
-- --     local height = rectHeight / 2

-- --     local bottomLeft = {rectCenter.x - width, rectCenter.y - height}
-- --     local bottomRight = {rectCenter.x + width, rectCenter.y - height}
-- --     local topLeft = {rectCenter.x - width, rectCenter.y + height}
-- --     local topRight = {rectCenter.x + width, rectCenter.y + height}

-- --     local rotatedBottomLeftX, rotatedBottomLeftY = rotatePoint(bottomLeft[1], bottomLeft[2], rectCenter.x, rectCenter.y, radianRot)
-- --     local rotatedBottomRightX, rotatedBottomRightY = rotatePoint(bottomRight[1], bottomRight[2], rectCenter.x, rectCenter.y, radianRot)
-- --     local rotatedTopLeftX, rotatedTopLeftY = rotatePoint(topLeft[1], topLeft[2], rectCenter.x, rectCenter.y, radianRot)
-- --     local rotatedTopRightX, rotatedTopRightY = rotatePoint(topRight[1], topRight[2], rectCenter.x, rectCenter.y, radianRot)

-- --     local pCoordsX, pCoordsY = playerCoords.x, playerCoords.y

-- --     local isInside = false

-- --     -- -- if pCoordsX >= rotatedBottomLeftX and pCoordsX <= rotatedBottomRightX and
-- --     -- --    pCoordsY >= rotatedBottomLeftY and pCoordsY <= rotatedTopLeftY then
-- --     -- --     isInside = true
-- --     -- -- end

-- --     -- print(pCoordsX, pCoordsY, rotatedBottomLeftX, rotatedBottomLeftY, rotatedTopRightX, rotatedTopRightY)

-- --     local maxX = rotatedTopLeftX
-- --     local maxX2 = rotatedTopRightX

-- --     local maxY = rotatedTopLeftY
-- --     local maxY2 = rotatedTopRightY

-- --     local minX = rotatedBottomLeftX
-- --     local minX2 = rotatedBottomRightX

-- --     local minY = rotatedBottomLeftY
-- --     local minY2 = rotatedBottomRightY

-- --     -- if (pCoordsX <= maxX or pCoordsX <= maxX2) and (pCoordsX >= minX or pCoordsX >= minX2) and (pCoordsY >= minY or pCoordsY >= minY2) and (pCoordsY <= maxY or pCoordsY <= maxY2) then
-- --     --     isInside = true
-- --     -- end

-- --     -- if ((pCoordsX <= maxX and pCoordsX >= minX2) and (pCoordsY <= maxY and pCoordsY >= minY2)) then
-- --     --     isInside = true
-- --     -- end
-- --     -- print(isInside)

-- --     -- Draw lines
-- --     local firstCorner = vec2(rotatedBottomLeftX, rotatedBottomLeftY) -- prwy gorny
-- --     local secondCorner = vec2(rotatedTopRightX, rotatedTopRightY) -- lewy dolny
-- --     local thirdCorner = vec2(rotatedTopLeftX, rotatedTopLeftY)
-- --     -- pray dolny
-- --     local fourthCorner = vec2(rotatedBottomRightX, rotatedBottomRightY)
-- --     -- lewy gorny

-- --     local px = pCoordsX
-- --     local py = pCoordsY

-- --     local playerPos = vec2(px, py)

-- --     local firstDist = #(playerPos-firstCorner)
-- --     local firstDist2 = #(playerPos-secondCorner)
-- --     local firstDist3 = #(playerPos-thirdCorner)
-- --     local firstDist4 = #(playerPos-fourthCorner)

-- --     local correctWidth = rectWidth-(rectWidth/10)

-- --     if
-- --     (firstDist2 <= correctWidth and firstDist <= rectHeight) or
-- --      (firstDist3 <= rectHeight and firstDist4 <= correctWidth) or (firstDist <= rectWidth and firstDist2 <= rectHeight) or (firstDist3 <= rectWidth and firstDist4 <= rectHeight) then
-- --         isInside = true
-- --     end

-- --     -- -- if (firstDist <= rectWidth or firstDist3 <= rectWidth) and (firstDist2 <= rectHeight or firstDist4 <= rectHeight) then
-- --     -- --     isInside = true
-- --     -- -- end

-- --     -- if (px >= secondCorner.x and px <= firstCorner.x) and (py >= fourthCorner.y and py <= thirdCorner.y) then
-- --     --     isInside = true
-- --     -- end

-- --     -- -- DrawLine(rotatedBottomLeftX, rotatedBottomLeftY, 100.0, rotatedBottomRightX, rotatedBottomRightY, 100.0, 255, 255, 255, 255) -- pierwsy
-- --     -- -- DrawLine(rotatedBottomLeftX, rotatedBottomLeftY, 100.0, rotatedTopLeftX, rotatedTopLeftY, 100.0, 255, 255, 255, 255)
-- --     -- -- -- pierwszy

-- --     -- -- DrawLine(rotatedTopRightX, rotatedTopRightY, 100.0, rotatedTopLeftX, rotatedTopLeftY, 100.0, 255, 255, 255, 255)
-- --     -- -- DrawLine(rotatedTopRightX, rotatedTopRightY, 100.0, rotatedBottomRightX, rotatedBottomRightY, 100.0, 255, 255, 255, 255)

-- --     return IsPlayerInsideRectangle(firstCorner, thirdCorner, fourthCorner, secondCorner, playerPos)
-- -- end

function isPointInsideRotatedRectangle(
  playerCoords,
  rectCenter,
  rectWidth,
  rectHeight,
  rectRotation
)
  local radianRot = math.rad(rectRotation)
  local halfWidth = rectWidth / 2
  local halfHeight = rectHeight / 2

  -- Define the corners of the rectangle in local coordinates
  local bottomLeft = { x = -halfWidth, y = -halfHeight, z = 0 }
  local bottomRight = { x = halfWidth, y = -halfHeight, z = 0 }
  local topLeft = { x = -halfWidth, y = halfHeight, z = 0 }
  local topRight = { x = halfWidth, y = halfHeight, z = 0 }

  -- Rotate the points
  bottomLeft = rotatePoint(bottomLeft, radianRot)
  bottomRight = rotatePoint(bottomRight, radianRot)
  topLeft = rotatePoint(topLeft, radianRot)
  topRight = rotatePoint(topRight, radianRot)

  -- Translate the points to global coordinates
  bottomLeft.x = bottomLeft.x + rectCenter.x
  bottomLeft.y = bottomLeft.y + rectCenter.y
  bottomLeft.z = bottomLeft.z + rectCenter.z

  bottomRight.x = bottomRight.x + rectCenter.x
  bottomRight.y = bottomRight.y + rectCenter.y
  bottomRight.z = bottomRight.z + rectCenter.z

  topLeft.x = topLeft.x + rectCenter.x
  topLeft.y = topLeft.y + rectCenter.y
  topLeft.z = topLeft.z + rectCenter.z

  topRight.x = topRight.x + rectCenter.x
  topRight.y = topRight.y + rectCenter.y
  topRight.z = topRight.z + rectCenter.z

  -- Check if the player is inside the rectangle
  local playerX, playerY, playerZ = playerCoords.x, playerCoords.y, playerCoords.z
  local isInside = false

  -- Perform point-in-polygon test
  if isPointInPolygon(playerX, playerY, bottomLeft, bottomRight, topRight, topLeft) then
    isInside = true
  end

  return isInside
end

-- Helper function to rotate a 3D point around the origin
function rotatePoint(point, angle)
  local sinA = math.sin(angle)
  local cosA = math.cos(angle)
  local x = point.x
  local y = point.y
  local z = point.z

  return {
    x = cosA * x - sinA * y,
    y = sinA * x + cosA * y,
    z = z, -- Z coordinate remains unchanged
  }
end

-- Helper function to check if a point is inside a 2D polygon
function isPointInPolygon(x, y, ...)
  local oddNodes = false
  local arg = { ... }
  local j = #arg

  for i = 1, #arg do
    local xi, yi, xi1, yi1 = arg[i].x, arg[i].y, arg[j].x, arg[j].y
    if yi < y and yi1 >= y or yi1 < y and yi >= y then
      if xi + (y - yi) / (yi1 - yi) * (xi1 - xi) < x then
        oddNodes = not oddNodes
      end
    end
    j = i
  end

  return oddNodes
end

Thread:Create(function()
  while true do
    Wait(0)
    for k, v in pairs(drawMarkers) do
      local marker = v.marker
      local closeDistCb = (
        v.value.functions and v.value.functions.onCloseDist or v.parent.functions.onCloseDist
      )

      if closeDistCb then
        local waitTime = v.parent.settings.closeDistWait
        if waitTime then
          Wait(waitTime)
        end
        closeDistCb(v.parent, v.value)
      end
      if v.drawMarker then
        local txd, txn
        if marker.txd then
          if not marker.txdLoaded then
            if HasStreamedTextureDictLoaded(marker.txd) then
              marker.txdLoaded = true
              txd, txn = marker.txd, marker.txn
            else
              RequestStreamedTextureDict(marker.txd)
            end
          else
            txd, txn = marker.txd, marker.txn
          end
        end

        DrawMarker(
          marker.type,
          v.value.pos,
          marker.direction.x,
          marker.direction.y,
          marker.direction.z,
          marker.rotation.x,
          marker.rotation.y,
          marker.rotation.z,
          marker.scale.x,
          marker.scale.y,
          marker.scale.z,
          marker.color.r,
          marker.color.g,
          marker.color.b,
          marker.color.a,
          marker.animate,
          marker.faceCam,
          2,
          marker.animRotate,
          txd or false,
          txn or false,
          marker.drawOnEntity or false
        )
      end
      local distance = #(DWB.PlayerData.Coords - v.value.pos)

      -- local markerScaleDist = #(marker.scale)
      local isClose = distance < marker.scale.x

      if marker.rectangleCheck then
        local pCoords = DWB.PlayerData.Coords
        local markerScale = marker.scale
        local width = markerScale.x
        local height = markerScale.y
        local markerPos = v.value.pos.x
        local markerPos2 = v.value.pos.y
        -- isClose = isPointInsideRotatedRectangle(pCoords.x, pCoords.y, markerPos, markerPos2, width, height, math.rad(v.value.blip.rotation))
        isClose =
          isPointInsideRotatedRectangle(pCoords, v.value.pos, width, height, v.value.blip.rotation)
      end

      if isClose and not inMarkers[v.idx] then
        -- if distance < markerScaleDist and not inMarkers[v.idx] then
        inMarkers[v.idx] = v
        enteredMarker(v.value, v.parent)

        -- isInMarker, currentZoneData, currentPosData  = true, v.parent, v.value
      elseif not isClose and inMarkers[v.idx] then
        -- elseif distance > markerScaleDist and inMarkers[v.idx] then
        leftMarker(v.value, v.parent)
        inMarkers[v.idx] = nil
      end
    end
  end
end)

Key:onJustPressed("G", "Użyj", function()
  for k, v in pairs(inMarkers) do
    local zoneData, posData = v.parent, v.value
    local clickCb = (
      DWB.Zones[zoneData.name].coords[posData.index].functions
        and DWB.Zones[zoneData.name].coords[posData.index].functions.onSecondClickCb
      or DWB.Zones[zoneData.name].functions.onSecondClickCb
    )
    local ActionData = v

    if zoneData.settings.oneUse then
      CurrentAction[k] = nil
    end

    if clickCb then
      clickCb(zoneData, posData, ActionData)
    end
  end
end)

Key:onJustPressed("E", "Użyj", function()
  for k, v in pairs(inMarkers) do
    local zoneData, posData = v.parent, v.value
    local canClickCb = (
      DWB.Zones[zoneData.name].coords[posData.index].functions
        and DWB.Zones[zoneData.name].coords[posData.index].functions.canClickCb
      or DWB.Zones[zoneData.name].functions.canClickCb
    )

    if canClickCb then
      if not canClickCb(zoneData, posData) then
        goto continue
      end
    end

    local clickCb = (
      DWB.Zones[zoneData.name].coords[posData.index].functions
        and DWB.Zones[zoneData.name].coords[posData.index].functions.onClickCb
      or DWB.Zones[zoneData.name].functions.onClickCb
    )
    local ActionData = v

    if zoneData.settings.oneUseSecond then
      CurrentAction[k] = nil
    end

    if clickCb then
      clickCb(zoneData, posData, ActionData)
    end

    ::continue::
  end
end)

Thread:Create(function()
  while true do
    Citizen.Wait(1000)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for k, v in pairs(DWB.Zones) do
      if not v.deactive then
        local displayOnlyFirst = v.settings and v.settings.displayOnlyFirst
        for i, z in pairs(displayOnlyFirst and { v.coords[1] } or v.coords) do
          local idx = z.uid or k .. "-" .. i
          if type(z) ~= "table" then
            local pos = z
            z = { pos = pos, index = i }
          end
          z.index = i
          z.idx = idx
          v.idx = idx
          if v.settings and v.settings.dynamicBlips and not z.blip then
            z.blip = Blips:AddDynamic(v.name, z, v)
            if v.settings.autoRoute then
              SetBlipRoute(z.blip, 1)
            end
          end
          local distance = #(playerCoords - z.pos)
          local drawDist = z.settings and (z.settings.drawDist or v.settings.drawDist)
            or v.settings.drawDist

          -- -- print(drawDist, distance)

          if distance < drawDist then
            local drawDistEnterCb = (
              z.functions and z.functions.onDrawDistEnter or v.functions.onDrawDistEnter
            )

            if drawDistEnterCb and not z.drawDistEnterCalled and not v.drawDistEnterCalled then
              z.drawDistEnterCalled = true
              z.drawDistExitCalled = nil
              drawDistEnterCb(v, z)
            end

            local drawMarker = v.settings.drawMarker
            local marker = z.marker or v.marker

            -- if drawMarker then
            --     DrawMarker(marker.type, z.pos, marker.direction.x, marker.direction.y, marker.direction.z, marker.rotation.x, marker.rotation.y, marker.rotation.z, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.animate, marker.faceCam, 2, true, false, false, false)
            -- end

            -- local closeDistCb = (z.functions and z.functions.onCloseDist or v.functions.onCloseDist)

            -- if closeDistCb then
            --     local waitTime = v.settings.closeDistWait
            --     if waitTime then Wait(waitTime) end
            --     closeDistCb(v, z)
            -- end

            -- letSleep = false
            if marker and not marker.scale then
              marker.scale = {
                x = z.radius or v.settings.radius,
              }
            end

            if not drawMarkers[idx] then
              drawMarkers[idx] = {
                marker = marker,
                value = z,
                parent = v,
                drawMarker = drawMarker,
                idx = idx,
              }
            end

            -- table.insert(drawMarkers , {
            --     marker = marker,
            --     value = z,
            --     parent = v,
            --     idx = idx
            -- })

            -- if distance < marker.scale.x then
            --     z.index = i
            --     isInMarker, currentZoneData, currentPosData  = true, v, z
            -- end
          else
            if v.drawDistEnterCalled or z.drawDistEnterCalled then
              local drawDistExitCb = (
                z.functions and z.functions.onDrawDistExit or v.functions.onDrawDistExit
              )

              if drawDistExitCb then
                z.drawDistExitCalled = true
                z.drawDistEnterCalled = nil
                drawDistExitCb(v, z)
              end
            end

            drawMarkers[idx] = nil
            if inMarkers[idx] then
              leftMarker(v, z)
              inMarkers[idx] = nil
            end
          end

          if v.remove then
            drawMarkers[idx] = nil
            inMarkers[idx] = nil
            DWB.Zones[k] = nil
            SendNuiMessage(json.encode({
              type = "Notify2",
              action = "close",
            }))
          end

          if z.remove then
            drawMarkers[idx] = nil
            inMarkers[idx] = nil
            v.coords[i] = nil
            SendNuiMessage(json.encode({
              type = "Notify2",
              action = "close",
            }))
          end
        end
      end
    end
  end
end)

Thread:Create(function()
  while true do
    Wait(0)
    for k, v in pairs(drawMarkers) do
      local updateCb = (
        v.value.functions and v.value.functions.onUpdate or v.parent.functions.onUpdate
      )

      if updateCb then
        updateCb(v.value, v.parent)
      end
    end
  end
end)
