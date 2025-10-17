BW = class()

function BW:ShowUI(data, uiData, timeoutCb, buttonCb)
  local ui = {
    time = 45,
    msg = TR("not_awake"),
    title = TR("bw_title"),
    buttons = {
      {
        label = TR("call_ems"),
        value = "call_ems",
        onClickRemove = true,
      },
    },
    afterTimer = {
      title = TR("awake"),
      desc = TR("ask_local"),
      buttons = {
        {
          label = TR("ask"),
          value = "local",
        },
      },
    },
  }

  if
    data
    and (data.deathCause == -1569615261 or (data.killerWeapon and data.killerWeapon == -1553120962))
  then
    ui.msg = TR("respawn")
    ui.time = 30
    -- ui.afterTimer.desc = TR("get_up")
    -- ui.afterTimer.buttons[1].label = TR("get_up_button")
    -- ui.afterTimer.buttons[1].value = 'up'
    ui.afterTimer = false
    timeoutCb = function()
      self:Respawn()
    end
  end

  if uiData then
    ui = uiData
  end

  UI:Open("Bg", {
    name = "bg",
    forceOpen = true,
  })
  UI:Open("Bw", {
    name = "bw",
    time = ui.time,
    title = ui.title,
    desc = ui.msg,
    buttons = ui.buttons,
    afterTimer = ui.afterTimer,
    forceOpen = true,
    forceClose = true,
  }, function(data, menu)
    if data.type == "bw_timeout" then
      if timeoutCb then
        timeoutCb()
      end
    else
      if buttonCb then
        buttonCb(data)
      end
    end
  end)
end

function BW:CloseUI()
  UI:Close("Bg")
  UI:Close("Bw")
end

function BW:GetSpawn()
  local found, maxDist
  for k, v in pairs(Config.Default.Respawn) do
    local dist = #(DWB.PlayerData.Coords - v.coords)
    if not found then
      found = v
      maxDist = dist
    else
      if dist < maxDist then
        found = v
      end
    end
  end

  return found, maxDist
end

function BW:Heal(d)
  SetEntityHealth(PlayerPedId(), hp or GetEntityMaxHealth(PlayerPedId()))
end

function BW:SpawnAtPoint()
  local found, maxDist = self:GetSpawn()
  User:Teleport(found)
end

function BW:StartAnim()
  local ped = DWB.PlayerData.Ped
  local oldVeh = GetVehiclePedIsIn(ped, lastVehicle)
  local lib = "combat@damage@writhe"
  local anim = "writhe_loop"

  local carLib = "random@crash_rescue@car_death@low_car"
  local carAnim = "loop"

  local currentLib = ""
  local currentAnim = ""
  local seat = 0

  if oldVeh > 0 then
    for i = -1, 5 do
      if GetLastPedInVehicleSeat(oldVeh, i) == ped then
        seat = i
        break
      end
    end

    SetPedIntoVehicle(ped, oldVeh, seat)
    currentLib = carLib
    currentAnim = carAnim
  else
    currentLib = lib
    currentAnim = anim
  end

  Stream:RequestAnimDict(currentLib, function()
    TaskPlayAnim(ped, currentLib, currentAnim, 8.0, 3.0, -1, 1, 1, false, false, false)
  end)
  Thread:Create(function()
    while DWB.PlayerData.char.data.IsDead do
      Wait(50)

      if self.stopAnim then
        self.stopAnim = false
        ClearPedTasks(ped)
        return
      end

      local vehicle = GetVehiclePedIsIn(ped, lastVehicle)

      if oldVeh == 0 and vehicle > 0 then
        currentLib = carLib
        currentAnim = carAnim
        oldVeh = vehicle
        --Stream:RequestAnimDict(currentLib, function()
        --	TaskPlayAnim(ped, currentLib, currentAnim, 8.0, 3.0, -1, 1, 1, false, false, false)
        --end)
      elseif oldVeh ~= 0 and vehicle == 0 then
        oldVeh = vehicle
        currentLib = lib
        currentAnim = anim
        --Stream:RequestAnimDict(currentLib, function()
        --	TaskPlayAnim(ped, currentLib, currentAnim, 8.0, 3.0, -1, 1, 1, false, false, false)
        --end)
      end

      if
        IsEntityPlayingAnim(PlayerPedId(), currentLib, currentAnim, 3) == 0
        and not IsEntityInWater(DWB.PlayerData.Ped)
      then
        Stream:RequestAnimDict(currentLib, function()
          TaskPlayAnim(ped, currentLib, currentAnim, 8.0, 3.0, -1, 1, 1, false, false, false)
        end)
      end
    end
  end)
end

function BW:StopAnim()
  -- self.stopAnim = true
  ClearPedTasks(PlayerPedId())
end

function BW:Kill() end

function BW:Respawn()
  Event:TriggerNet("dwb:player:respawn")
  -- Event:TriggerNet('dwb:ambulance:revive')
end

function BW:RespawnPed(ped, coord)
  SetPedToRagdoll(ped, 0, 0, 0, 0, 0, 0)
  SetEntityCoords(ped, coord)
end

function BW:RespawnClient(coord, heading)
  local ped = DWB.PlayerData.Ped
  local coords = coord or DWB.PlayerData.Coords
  NetworkResurrectLocalPlayer(coords, heading or GetEntityHeading(ped), true, false)
  self:RespawnPed(coords)
  ClearPedTasks(ped)
end

function BW:State(state)
  Animation:SetCanPlay(state)
  UI:SetCanOpen(state)
  UI:SetCanClose(state)
end

function BW:Start(data, uiData, cb, btnCb)
  UI:CloseAll()
  DWB.PlayerData.timer = true
  self:RespawnClient(data.coords, data.heading)
  local player = DWB.PlayerData.Player
  passiveMode(true)
  SetPlayerInvincible(player, true)
  self:ShowUI(data, uiData, cb or function()
    DWB.PlayerData.afterTimer = true
  end, btnCb)
  ClearPedTasks(DWB.PlayerData.Ped)
  self:StartAnim(data)
  self:State(false)
  FreezeEntityPosition(DWB.PlayerData.Ped, true)
end

function BW:Stop(coord)
  FreezeEntityPosition(DWB.PlayerData.Ped, false)
  DWB.PlayerData.WasDead = false
  DWB.PlayerData.timer = false
  self:RespawnClient(coord)
  local player = DWB.PlayerData.Player
  passiveMode(false)
  SetPlayerInvincible(player, false)
  self:State(true)
  self:CloseUI()
  self:StopAnim()
end

function BW:Button()
  Event:TriggerNet("dwb:tablet:report", "Obywatel wzywa pomocy", {
    coords = { table.unpack(GetEntityCoords(PlayerPedId())) },
    type = "gps",
    notify = "player_report",
  }, "ambulance")
end

User:OnLoadedChar(function()
  if DWB.PlayerData.char.data.IsDead then
    DWB.PlayerData.WasDead = true
    BW:Start(DWB.PlayerData.char.data.deadData)
  end
end)
User:OnSyncCharData(function(self, k, v)
  if k == "data" then
    if v.IsDead then
      if not DWB.PlayerData.timer then
        DWB.PlayerData.WasDead = true
        BW:Start(v.deadData)
      end
    elseif DWB.PlayerData.WasDead then
      BW:Stop()
    end
  end
end)
Key:onJustPressed("G", "Wezij help", function()
  if DWB.PlayerData.char.data.IsDead then
    BW:Button()
  end
end)

function BW:RespawnPay()
  local found, maxDist = self:GetSpawn()
  Event:TriggerNet("dwb:ambulance:revive:pay", found)
end

Key:onJustPressed("E", "Respawn", function()
  if DWB.PlayerData.char.data.IsDead and DWB.PlayerData.afterTimer then
    DWB.PlayerData.afterTimer = false
    BW:RespawnPay()
  end
end)
