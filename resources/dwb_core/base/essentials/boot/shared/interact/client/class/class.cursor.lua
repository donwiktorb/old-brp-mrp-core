RegisterCommand("naped", function()
  --RemoveReplaceTexture("ch3_rd2_billboard01", "ch3_rd2_billboard01")

  Wait(5000)

  local txd = CreateRuntimeTxd("meow")

  local duiUrl = "https://cfx-nui-"
    .. GetCurrentResourceName()
    .. "/base/static/ui/boskierp/index.html"

  local scale = 1
  local screenWidth = math.floor(1920 * scale)
  local screenHeight = math.floor(1080 * scale)

  local duiObject = CreateDui(duiUrl, screenWidth, screenHeight)
  print(duiObject)

  local duiHandle = GetDuiHandle(duiObject)

  local runtimeTxt = CreateRuntimeTextureFromDuiHandle(txd, "meow", duiHandle)

  SendDuiMessage(
    duiObject,
    json.encode({
      show = true,
      type = "Scoreboard",
      action = "open",
      name = "bank",
    })
  )

  --CommitRuntimeTexture(runtimeTxt)

  RequestStreamedTextureDict("meow")
  while not HasStreamedTextureDictLoaded("meow") do
    print("x d")
    Wait(0)
  end
  --AddReplaceTexture("CommonMenu", "ArrowRight", "meow", "meow")

  --	CommitRuntimeTexture(runtimeTxt)

  Citizen.CreateThread(function()
    while true do
      Wait(0)
      DrawMarker(
        9,
        DWB.PlayerData.Coords,
        0.0,
        0.0,
        0.0,
        90.0,
        0.0,
        0.0,
        10.0,
        10.0,
        10.0,
        254,
        254,
        254,
        254,
        false,
        true,
        4,
        false,
        "meow",
        "meow",
        false
      )
    end
  end)
  --CommitRuntimeTexture(runtimeTxt)
  Wait(10000)

  SendDuiMessage(
    duiObject,
    json.encode({
      show = true,
      type = "Scoreboard",
      action = "open",
      name = "bank",
    })
  )

  SendDuiMessage(
    duiObject,
    json.encode({
      show = true,
      type = "Scoreboard",
      action = "fractions",
      name = "bank",
      data = { action = "add", name = "name", label = "label", count = 4, icon = "" },
    })
  )

  Wait(30000)

  --DestroyDui(duiObject)
end)

Interact.Cursor = {}

local functionOverrides = {
  onDrawDistExit = function(zoneData, posData)
    if posData.entityHandle then
      DeleteEntity(posData.entityHandle)
      posData.entityHandle = false
    end
  end,
  onDrawDistEnter = function(zoneData, posData)
    print(zoneData.isClient)
    if zoneData.isClient then
      local entityType = (
        (posData.ped or zoneData.ped) and "ped"
        or (posData.vehicle or zoneData.vehicle) and "vehicle"
        or (posData.object or zoneData.object) and "object"
      )

      local zoneEntityData, posEntityData =
        zoneData.ped or zoneData.vehicle or zoneData.object or {},
        posData.ped or posData.vehicle or posData.object or {}

      local model = posEntityData.model or zoneEntityData.model

      RequestModel(model)
      while not HasModelLoaded(model) do
        Wait(0)
      end

      local entityHandle

      RequestCollisionAtCoord(posData.pos)

      if entityType == "ped" then
        entityHandle = CreatePed(
          4,
          model,
          posData.pos,
          posData.heading or zoneData.heading or 444,
          posData.isNetworked or zoneData.isNetworked,
          true
        )
      elseif entityType == "vehicle" then
        entityHandle =
          CreateVehicle(model, posData.pos, posData.heading or zoneData.heading or 444, true, true)
      else
        entityHandle = CreateObjectNoOffset(model, posData.pos, true, true)
      end

      while not DoesEntityExist(entityHandle) do
        Wait(0)
      end

      if not HasCollisionLoadedAroundEntity(entityHandle) then
        SetEntityCoordsNoOffset(entityHandle, posData.pos)
      end
      posData.entityHandle = entityHandle
    end
  end,
}

function Interact.Cursor:Load(ents)
  self.entities = ents
  Interact.Markers:LoadCustom(ents, functionOverrides)
end

function Interact.Cursor:Unload() end

function Interact.Cursor:OnAltPress()
  self.opened = true
  SetCursorLocation(0.5, 0.5)
  SetNuiFocus(true, true)
  SetNuiFocusKeepInput(true)
  Controls:Disable(24, 25, 257)
end
function Interact.Cursor:OnAltRelease()
  self.opened = false
  SetCursorLocation(0.5, 0.5)
  local isFocus = UI:IsAnyOpenWithFocus()
  SetNuiFocus(isFocus, isFocus)
  SetNuiFocusKeepInput(false)
  Controls:RemoveDisable(24, 25, 257)
  Menu:Close("MenuCursor")
end

function Interact.Cursor:OpenMenu(action, entData, entHit, netId, posData, zoneData)
  local newX, newY = GetNuiCursorPosition()

  local menu = UI:Open("MenuCursor", {
    name = action.name,
    title = action.title,
    y = newX,
    x = newY,
    elements = action.elements,
  })

  menu:onSubmit(function(data, menu)
    local dist = #(DWB.PlayerData.Coords - GetEntityCoords(entHit))
    if dist >= 3.0 then
      return menu.close()
    end
    if not data.current.cb or Cursor.Callbacks.onSubmit[data.current.cb](entHit, data, entData) then
      if action.closeOnSubmit then
        menu.close()
      end

      if data.current.notification then
        Notification:ShowCustom(
          data.current.notification.type,
          data.current.notification.title,
          data.current.notification.content
        )
      end

      if data.current.clientFn then
        Cursor.Functions[data.current.clientFn](entHit, data, entData, action)
      end
      if not data.current.clientOnly then
        Event:TriggerNet("dwb:cursor:submit", action, netId, data, entData)
      end
    end
  end)

  -- -- menu:onChange(function(data,menu)
  -- --     print(data.current.value)
  -- -- end)

  menu:onClose(function(data, menu)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
  end)
end

function Interact.Cursor:OnLeftClick()
  local menuData = {}

  local screenX = GetDisabledControlNormal(0, 239)
  local screenY = GetDisabledControlNormal(0, 240)
  local world, normal = GetWorldCoordFromScreenCoord(screenX, screenY)
  local depth = 10.0
  local target = world + normal * depth

  local startc = world
  local endc = target

  local rayHandle = StartShapeTestLosProbe(startc, target, 4294967295, PlayerPedId(), 4)
  local ret, rayCat, endCoords, sNormal, material, entHit =
    GetShapeTestResultIncludingMaterial(rayHandle)

  while ret < 2 and ret ~= 0 do
    ret, rayCat, endCoords, sNormal, material, entHit =
      GetShapeTestResultIncludingMaterial(rayHandle)
    Wait(0)
  end

  print(ret, entHit)

  if ret >= 2 and rayCat and entHit > 0 and GetEntityType(entHit) ~= 0 then
    local action = Entity(entHit).state.action
    local entData = Entity(entHit).state.data or {}
    local model = GetEntityModel(entHit)
    print(model)
    local entType = IsPedAPlayer(entHit) and "player"
      or IsEntityAVehicle(entHit) and "vehicle"
      or IsEntityAPed(entHit) and "ped"
      or "object"

    local netId = NetworkGetNetworkIdFromEntity(entHit)

    if entHit == PlayerPedId() then
      entType = "self"
    end

    if entType == "player" then
      entData.player = NetworkGetPlayerIndexFromPed(entHit)
      entData.playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit))
    end

    local entityModelAction = Config.Cursor.EntityModels[model]

    if entityModelAction then
      if entityModelAction.action then
        if not action then
          action = entityModelAction.action
        else
          Table:Merge(action, entityModelAction.action.elements)
        end
      end

      if entityModelAction.data then
        Table:MergeKV(entData, entityModelAction.data)
      end
    end

    local entityTypeAction = Config.Cursor.EntityTypes[entType]

    if entityTypeAction then
      if entityTypeAction.action then
        Table:Merge(action, entityTypeAction.action)
      end

      if entityTypeAction.data then
        Table:MergeKV(entData, entityTypeAction.data)
      end
    end

    if
      action
      and (
        not action.onOpenCb
        or Config.Cursor.Callbacks.onOpen[action.onOpenCb](entHit, action, entData)
      )
    then
      self:OpenMenu(action, entData, entHit, netId)
    end
  end
end
