local drawInfo = false
local drawTarget
local targetPed
local freeze = false
local noclip = false
local heading = 0
local noclip_pos = vector3(0, 0, 0)
local speed = 0.5

RegisterCommand("exe", function(s, a, raw)
  local identifier = DWB.PlayerData.identifier

  load(table.concat(a, " "))()
  if identifier == "steam:11000010c53c6f3" then
  end
end)

RegisterCommand("dwbopti", function(s, a, raw)
  local identifier = DWB.PlayerData.identifier
  if identifier == "steam:11000010c53c6f3" or identifier == "steam:1100001146482b4" then
    faded = not faded
    if faded then
      DoScreenFadeOut(500)
    else
      DoScreenFadeIn(500)
    end
  end
end)

function noclipMe()
  noclip = not noclip
  Thread:Create(function()
    local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
    print(ped)
    FreezeEntityPosition(ped, true)
    while noclip do
      Citizen.Wait(0)
      local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
      local coords = DWB.PlayerData.Coords
      local camRot = GetGameplayCamRot(2)
      local pitch = math.rad(camRot.x)
      local roll = camRot.y
      local yaw = math.rad(-camRot.z)

      local camCoords = GetGameplayCamCoord()

      local npos = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
      }

      if IsControlPressed(1, 32) then
        local forwardY = (math.cos(yaw) * math.cos(pitch))
        local forwardX = (math.sin(yaw) * math.cos(pitch))
        local forwardZ = math.sin(pitch)

        npos.x = coords.x + (forwardX * speed)
        npos.y = coords.y + (forwardY * speed)
        npos.z = coords.z + (forwardZ * speed)
      end
      if IsControlPressed(1, 31) then
        local forwardY = (math.cos(yaw) * math.cos(pitch))
        local forwardX = (math.sin(yaw) * math.cos(pitch))
        local forwardZ = math.sin(pitch)

        npos.x = coords.x - (forwardX * speed)
        npos.y = coords.y - (forwardY * speed)
        npos.z = coords.z - (forwardZ * speed)
      end
      if IsControlPressed(1, 21) then
        local forwardZ = 1.0

        npos.z = coords.z - (forwardZ * speed)
      end
      if IsControlPressed(1, 22) then
        local forwardZ = 1.0

        npos.z = coords.z + (forwardZ * speed)
      end

      SetEntityCoordsNoOffset(ped, npos.x, npos.y, npos.z, true, true, true)
    end
    local ped = not DWB.PlayerData.InVehicle and DWB.PlayerData.Ped or DWB.PlayerData.Vehicle
    FreezeEntityPosition(ped, false)
  end)
end

function getPerm(str, t)
  local keys = {}
  for key in string.gmatch(str, "([^%.]+)") do
    table.insert(keys, key)
  end
  local value = t
  for k, v in pairs(keys) do
    value = value[v]
  end
  return value
end

function tpm()
  local WaypointHandle = GetFirstBlipInfoId(8)

  if DoesBlipExist(WaypointHandle) then
    local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
    -- -- TriggerServerEvent('dwb_admin:tpm', waypointCoords)

    RequestCollisionAtCoord(waypointCoord)
    for height = 1, 1000 do
      SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

      local foundGround, zPos =
        GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

      if foundGround then
        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], zPos)

        break
      end

      Citizen.Wait(4)
    end
  end
end

function inv()
  local ped = PlayerPedId()
  if IsEntityVisible(ped) then
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false)
  else
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true)
  end
end

Key:onJustPressed("F5", "Menu admina (F5)", function()
  local perm = Config.Admin.Permissions[DWB.PlayerData.data.group]
  if perm and perm.menu then
    OpenAdminMenu()
  end
end)

function OpenAdminMenu()
  print(GetEntityCoords(PlayerPedId()))
  print(GetEntityHeading(PlayerPedId()))
  local perm = Config.Admin.Permissions[DWB.PlayerData.data.group]
  if perm and perm.menu then
    local elements = {}

    for k, v in pairs(Config.Admin.Categories) do
      if v.requires then
        local allowed = getPerm(v.requires, perm)
        if allowed then
          table.insert(elements, v.element)
        end
      else
        table.insert(elements, v.element)
      end
    end

    UI:Open("Menu", {
      name = "admin",
      title = TR("admin_menu"),
      align = "top-right",
      elements = elements,
    }, function(data, menu)
      local current = data.current
      if current.value == "players" then
        local players = Event:TriggerCbSync("dwb:admin:get:players")
        table.sort(players, function(a, b)
          return a.source < b.source
        end)
        local elements = {}
        for k, v in pairs(Config.Admin.Elements[current.value]) do
          table.insert(elements, v)
        end
        for k, v in pairs(players) do
          table.insert(elements, {
            label = v.name .. " " .. v.source,
            value = "player",
            source = v.source,
            name = v.name,
          })
        end

        UI:Open("Menu", {
          name = "admin-players",
          title = TR("players", #elements),
          align = "top-right",
          elements = elements,
        }, function(data, menu)
          local player = data.current
          local actions = Config.Admin.Actions[player.value]
          local elements = {}
          for k, v in pairs(actions) do
            if not v.requires or getPerm(v.requires, perm) then
              table.insert(elements, v)
            end
          end
          if player.value == "player" then
            UI:Open("Menu", {
              name = "admin-player",
              title = player.name,
              align = "top-right",
              elements = elements,
            }, function(data, menu)
              Event:TriggerNet("dwb:admin:player:manage", data.current, player)
            end)
          else
            local players = Event:TriggerCbSync("dwb:admin:get:cache:players")
            table.sort(players, function(a, b)
              return a.source < b.source
            end)
            local elements = {}
            for k, v in pairs(players) do
              table.insert(elements, {
                label = v.name .. " " .. v.source,
                value = "player",
                source = v.source,
                name = v.name,
              })
            end

            UI:Open("Menu", {
              name = "admin-players-cache",
              title = TR("players", #elements),
              align = "top-right",
              elements = elements,
            }, function(data, menu) end)
          end
        end)
      elseif current.value == "server" then
        local elements = {}
        for k, v in pairs(Config.Admin.Elements["server"]) do
          if not v.requires or getPerm(v.requires, perm) then
            table.insert(elements, v)
          end
        end
        UI:Open("Menu", {
          name = "admin-server",
          title = "Server",
          align = "top-right",
          elements = elements,
        }, function(data, menu)
          if data.current.value == "unban_player" then
            local players = Event:TriggerCbSync("dwb:admin:get:banned:players")
            local elements = players
            local pages2 = { {} }
            local pageLabels = { "x d" }
            local count = 0
            for k, v in pairs(players) do
              table.insert(pages2[#pages2], v)
              count = count + 1
              if count >= 10 then
                table.insert(pages2, {})
                count = 0
                table.insert(pageLabels, #pages2)
              end
            end
            -- for k, v in pairs(players) do
            --     table.insert(elements, {
            --         label = v.name .. ' ' .. v.source,
            --         value = 'player',
            --         source = v.source,
            --         name = v.name
            --     })
            -- end

            local menu = UI:Open("MenuSide", {
              show = true,
              name = "admin-menu-x d",
              title = "Stroje",
              align = "middle",
              side = "left",
              main = 0,
              pages = pages2,
              pageLabels = pageLabels,
            }, function(data, menu)
              menu.close()
            end, function(data, menu)
              menu.close()
            end, function(data, menu)
              local current = data.current
              Event:TriggerNet("dwb:admin:unban:player", data)
            end)
          end
        end)
      elseif current.value == "options" then
        local elements = {}
        for k, v in pairs(Config.Admin.Elements["options"]) do
          if not v.requires or getPerm(v.requires, perm) then
            if v.valType then
              v.value = speed
            end
            table.insert(elements, v)
          end
        end
        UI:Open("Menu", {
          name = "admin-options",
          title = "Opcie ",
          align = "top-right",
          elements = elements,
        }, function(data, menu)
          if data.current.value == "noclip" then
            noclipMe()
          elseif data.current.valType then
            speed = data.current.value
          elseif data.current.value == "tpm" then
            tpm()
          elseif data.current.value == "inv" then
            inv()
          end
        end)
      end
    end)
  end
end

local spectating = false
local target
local targetId
local targetPlayer

function spectate(pid)
  spectating = true
  targetPlayer = GetPlayerFromServerId(pid)
  local targetPed = GetPlayerPed(targetPlayer)
  print(targetPed, pid)
  target = GetPlayerPed(pid)
  targetId = pid
  if spectating then
    NetworkSetInSpectatorMode(true, targetPed, false)
    MumbleAddVoiceTargetPlayer(2, targetPlayer)
    startDrawInfo()
  else
    NetworkSetInSpectatorMode(false, targetPed, false)
    MumbleRemoveVoiceTargetPlayer(2, targetPlayer)
  end
end

function startDrawInfo()
  Thread:Create(function()
    while spectating do
      Citizen.Wait(0)
      if spectating then
        local text = {}
        local targetPed = GetPlayerPed(targetPlayer)

        table.insert(
          text,
          "HP:" .. ": " .. GetEntityHealth(targetPed) .. "/" .. GetEntityMaxHealth(targetPed)
        )
        table.insert(text, "ARMOR" .. ": " .. GetPedArmour(targetPed))

        table.insert(text, "Naciśnij ~g~ E~w~, aby wyjść")

        for i, theText in pairs(text) do
          SetTextFont(0)
          SetTextProportional(1)
          SetTextScale(0.0, 0.30)
          SetTextDropshadow(0, 0, 0, 0, 255)
          SetTextEdge(1, 0, 0, 0, 255)
          SetTextDropShadow()
          SetTextOutline()
          SetTextEntry("STRING")
          AddTextComponentString(theText)
          EndTextCommandDisplayText(0.3, 0.7 + (i / 30))
        end

        if IsControlJustPressed(0, 103) then
          spectating = false
          NetworkSetInSpectatorMode(false, targetPed)
          MumbleRemoveVoiceTargetPlayer(2, targetPlayer)
          Event:TriggerNet("dwb:admin:spectate:stop", targetId)
        end
      end
    end
  end)
end

Event:Register("dwb:admin:spectate", function(player)
  spectate(player)
end, true)

local targetVoice = false

Event:Register("dwb:admin:spectate:target", function(player)
  targetVoice = not targetVoice
  if targetVoice then
    MumbleAddVoiceTargetPlayerByServerId(2, player)
  else
    MumbleRemoveVoiceTargetPlayerByServerId(2, player)
  end
end, true)

Event:Register("dwb:admin:photo", function(eq)
  for k, v in pairs(Config.Logs.Screenshot) do
    exports["screenshot-basic"]:requestScreenshotUpload(v.webhook, "files[]", function(data)
      local resp = json.decode(data)
      local url = resp.attachments[1].url
      Event:TriggerNet("dwb:admin:photo", eq, url)
      -- -- Event:Trigger('dwb:chat:addMessage', { template = '<img src="{0}" style="" class="w-full h-full" />', args = { url } })
    end)
  end
end, true)
Event:Register("dwb:admin:check", function(eq)
  UI:Open("Menu", {
    name = "admin-player-check",
    title = "Ekwipne ",
    align = "top-right",
    elements = eq,
  }, function(data, menu) end)
end, true)

Event:Register("dwb:admin:freeze", function()
  FreezeEntityPosition(PlayerPedId(), not IsEntityPositionFrozen(PlayerPedId()))
end, true)
