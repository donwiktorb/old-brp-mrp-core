local vehData = {}
local veh2
local vehMenu
local vehCoords

Event:Register("dwb:player:vehicle:exit", function(veh)
  if UI:IsOpen("car-dealer") and veh2 == veh then
    UI:ToggleFocus(true, true)
    vehMenu.updateData({
      page = 1,
    })
    DeleteEntity(veh2)
    SetEntityCoords(PlayerPedId(2), vehCoords)
  end
end)

Event:Register("dwb:cardealer:store", function(data)
  vehData = data
end, true)

Event:Register("dwb:cardealer:open", function(data2, data4, bucket)
  for k, v in pairs(vehData) do
    for k2, v2 in pairs(v.elements) do
      print(v2.value)
      if not IsModelValid(v2.value) then
        v2.new = true
      end
    end
  end
  vehCoords = GetEntityCoords(PlayerPedId())
  vehMenu = UI:Open("MenuCategory", {
    name = "car-dealer",
    page = 1,
    elements = data4 or vehData,
    show = true,
    noButtons = data2.noButtons,
    focus = {
      cursor = true,
      doNotKeepInput = true,
    },
  }, function(data, menu)
    if data.type == "buy" then
      local found = false

      for k, v in pairs(data2.spawns) do
        if not IsAnyVehicleNearPoint(v.pos, 2.0) then
          found = v
        end
      end
      if not found then
        Notification:ShowCustom("info", TR("parking"), TR("no_place"))
        return
      end
      local enough, hasLicense = Event:TriggerCbSync("dwb:cardealer:enough", data.current)
      if not hasLicense then
        Notification:ShowCustom(
          "warning",
          TR("car-dealer"),
          "Nie masz licencji " .. data.current.license
        )
        return
      end
      if enough then
        menu.close()
        SetEntityCoords(PlayerPedId(2), vehCoords)
        local properties = Vehicle:GetProperties2(veh2)
        Event:TriggerNet(
          "dwb:cardealer:buy",
          NetworkGetNetworkIdFromEntity(veh2),
          properties,
          found,
          data.current.price,
          bucket
        )
      else
        Notification:ShowCustom("warning", TR("car-dealer"), TR("too_low_money"))
        return
      end
      return
    end
    local label = data.current.label
    local model = data.current.value
    local price = data.current.price
    local index = data.current.index
    local category = data.current.category
    Vehicle:Spawn(model, data2.coords, data2.heading, function(veh)
      SetVehicleModKit(veh, 0)
      veh2 = veh
      SetPedIntoVehicle(PlayerPedId(), veh, -1)
      FreezeEntityPosition(veh, true)
      SetVehicleEngineOn(veh, true, true, true)
      SetVehicleLights(veh, 2)
      local speed = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia")
      local speedMax = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel")
      local gears = GetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears")
      local weight = GetVehicleHandlingFloat(veh, "CHandlingData", "fMass")
      local chosen = data.current
      chosen.value = model
      chosen.elements = {
        {
          label = TR("speed"),
          value = string.format("%.1f s", speed),
        },
        {
          label = TR("mas"),
          value = string.format("%.1f t", weight / 1000),
        },
        {
          label = TR("gears"),
          value = gears,
        },
        {
          label = TR("vmax"),
          value = string.format("%.0f km/h", speedMax),
        },
      }

      menu.updateData({
        chosen = chosen,
        page = 2,
      })

      UI:ToggleFocus(true, false)
    end)
  end, function(data, menu)
    menu.close()
    Event:TriggerNet("dwb:cardealer:exit", bucket)
  end, function(data, menu)
    if data.current == 1 then
      UI:ToggleFocus(true, true)
      SetEntityAsMissionEntity(veh2, true, true)
      DeleteEntity(veh2)
      SetEntityCoords(PlayerPedId(2), vehCoords)
      return
    end

    if data.current.name == "xenon" then
      ToggleVehicleMod(veh2, 22, data.current.value)
    elseif data.current.name == "neon-left" then
      SetVehicleNeonLightEnabled(veh2, 0, data.current.value)
    elseif data.current.name == "neon-right" then
      SetVehicleNeonLightEnabled(veh2, 1, data.current.value)
    elseif data.current.name == "neon-all" then
      for i = 0, 3 do
        SetVehicleNeonLightEnabled(veh2, i, data.current.value)
      end
    elseif data.current.name == "neon-forward" then
      SetVehicleNeonLightEnabled(veh2, 2, data.current.value)
    elseif data.current.name == "neon-back" then
      SetVehicleNeonLightEnabled(veh2, 3, data.current.value)
    elseif data.current.name == "xenon-color" then
      SetVehicleXenonLightsCustomColor(
        veh2,
        data.current.value.r,
        data.current.value.g,
        data.current.value.b
      )
      return
    elseif data.current.name == "neon-color" then
      SetVehicleNeonLightsColour(
        veh2,
        data.current.value.r,
        data.current.value.g,
        data.current.value.b
      )
      return
    elseif data.current.name == "color-main" then
      SetVehicleCustomPrimaryColour(
        veh2,
        data.current.value.r,
        data.current.value.g,
        data.current.value.b
      )
      return
    elseif data.current.name == "color-2" then
      SetVehicleCustomSecondaryColour(
        veh2,
        data.current.value.r,
        data.current.value.g,
        data.current.value.b
      )
      return
    end

    local price = data.current.value and menu.data.chosen.price + 500
      or menu.data.chosen.price - 500
    local chosen = menu.data.chosen
    chosen.price = price
    menu.updateData({
      chosen = chosen,
    })
  end)
end, true)

