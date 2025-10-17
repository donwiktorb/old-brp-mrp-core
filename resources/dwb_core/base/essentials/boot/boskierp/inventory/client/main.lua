function changeSlot(item, data, invData2)
  Event:TriggerNet("dwb:inventory:slot:change", item, data, invData2)
end

function itemDesc(item, data, invData2)
  Event:TriggerNet("dwb:inventory:item:desc", item, data, invData2)
end

function changeItem(item, data, invData2)
  Event:TriggerNet("dwb:inventory:item:change", item, data, invData2)
end

function changeInventory(data, data2, invData2)
  Event:TriggerNet("dwb:inventory:change", data, data2, invData2)
end

Event:Register("dwb:inventory:close", function()
  UI:Close("Inventory", {
    name = "inventory",
  })
end, true)

Event:Register("dwb:inventory:notify", function(item, count, remove)
  Notification:ShowInventory(item, count, remove)
end, true)

function setItemsData(items)
  for k, v in pairs(items) do
    local desc = {}

    if v.description then
      table.insert(desc, {
        label = v.description,
      })
    end
    for k2, v2 in pairs(v.data or {}) do
      if type(v2) ~= "table" then
        local keyLabel, noKeyLabel = TR(k2)
        local valueLabel, noValueLabel = TR(tostring(v2))
        local label = string.format(
          "%s: %s",
          not noKeyLabel and keyLabel or k2,
          not noValueLabel and valueLabel or tostring(v2)
        )

        table.insert(desc, {
          label = label,
          name = k2,
          value = v2,
        })
      end
    end
    v.description = desc
  end
end

function ShowInventory(data)
  while not DWB.PlayerData.char do
    Wait(0)
  end
  local Inventories = data
  if not Inventories[1].items then
    Inventories[1].items = DWB.PlayerData.char.inventory
  end
  setItemsData(Inventories[1].items)
  setItemsData(Inventories[2].items)
  local invType = DWB.UISettings["inventory"] == 1 and "inv" or "inv2"
  if invType == "inv" then
    UI:Open("Inventory", {
      name = "inventory",
      inventories = Inventories,
      quantity = 1,
      show = true,
    }, function(data, menu)
      -- submit
      useItem(data, invData)
    end, function(data, menu)
      -- cancel
      Event:TriggerNet("dwb:inventory:closed")
      menu.close()
      UI:CloseAll()
    end, function(data, menu)
      data.quantity = tonumber(data.quantity)
      --change
      if data.action == "inventory_change" then
        changeInventory(data, invData, invData2)
      elseif data.action == "slot_change" then
        changeSlot(data, invData, invData2)
      elseif data.action == "item_change" then
        changeItem(data, invData, invData2)
      elseif data.action == "inventory_item_desc" then
        itemDesc(data, invData, invData2)
      end
    end)
  else
    local elements = nil
    local elements2 = {}
    local names = {
      ["player"] = true,
      ["shop"] = true,
      ["drop"] = true,
    }
    local sharedNames = {
      ["vehicle"] = true,
      ["property"] = true,
      ["gang"] = true,
    }
    local noSlotLabels = {
      ["shop"] = true,
    }
    local label = "x d"
    local firstInv = Inventories[1]
    local secondInv = Inventories[2]
    local invType2 = "inv"
    local align = nil
    if secondInv then
      align = secondInv.align
      if names[secondInv.name] then
        label = secondInv.label
        elements = secondInv.items
        invType2 = "inv2"
      end
    end

    if not elements then
      label = firstInv.label
      elements = firstInv.items
      invType2 = "inv"
    end

    table.sort(elements, function(a, b)
      return b.slot > a.slot
    end)

    for k, v in pairs(elements) do
      if (secondInv and noSlotLabels[secondInv.name]) or v.slot > 5 then
        v.label = string.format("%s %s", v.label, v.price and v.price .. "$" or v.count .. "x")
      else
        v.label =
          string.format("%s %s (%s)", v.label, v.price and v.price .. "$" or v.count .. "x", v.slot)
      end
      if invType2 ~= "inv" then
        v.type = "slider"
        v.min = 1
        -- v.max = v.limit or v.count
        v.max = v.count
        v.value = 1
      else
        v.inv = "inv"
      end
      table.insert(elements2, v)
    end

    if secondInv then
      if sharedNames[secondInv.name] then
        table.insert(elements2, {
          label = "----Wyjmij----",
        })
        for k, v in pairs(secondInv.items) do
          v.label = string.format("%s %s", v.label, v.price and v.price .. "$" or v.count .. "x")
          -- if invType2 ~= 'inv' then
          v.type = "slider"
          v.min = 1
          -- v.max = v.limit or v.count
          v.max = v.count
          v.value = 1
          -- end
          table.insert(elements2, v)
        end
      end
    end

    UI:Open("Menu", {
      name = "inventory",
      title = label,
      -- inventories = Inventories,
      elements = elements2,
      -- quantity = 1,
      show = true,
      align = align or "bottom-right",
    }, function(data, menu)
      -- submit
      -- useItem(data, invData)
      if data.current.inv == "inv" then
        UI:Open("Menu", {
          name = data.current.name,
          title = data.current.label,
          -- inventories = Inventories,
          elements = {
            {
              label = "Użyj",
              value = "use",
            },
            {
              label = "Użyj na itemie",
              value = "use-item",
            },
            {
              label = "Dodatki",
              value = "addons",
            },
            {
              label = "Zmień slot",
              value = "slot",
            },
            {
              label = "Wyrzuć/Włóż",
              value = "drop",
            },
          },
          -- quantity = 1,
          show = true,
          align = "bottom-right",
        }, function(data2, menu2)
          if data2.current.value == "use" then
            data.quantity = 1
            useItem(data, invData)
          elseif data2.current.value == "use-item" then
            UI:Open("Menu", {
              name = data.current.name,
              title = data2.current.label,
              -- inventories = Inventories,
              elements = elements2,
              -- quantity = 1,
              show = true,
              align = "bottom-right",
            }, function(data5, menu5)
              data.target = data5.current
              data.currentSlot = data.current.slot
              data.targetSlot = data5.current.slot
              data.quantity = 1
              data.oldInv = "inventory"
              data.newInv = data5.current.inv and "inventory" or "none"
              changeItem(data, invData, invData2)
            end)
          elseif data2.current.value == "addons" then
            if data.current.data then
              local elems = {}
              for k, v in pairs(data.current.data) do
                table.insert(elems, {
                  label = TR(k) .. " " .. v,
                  value = {
                    name = k,
                  },
                })
              end
              UI:Open("Menu", {
                name = data.current.name,
                title = data2.current.label,
                -- inventories = Inventories,
                elements = elems,
                -- quantity = 1,
                show = true,
                align = "bottom-right",
              }, function(data5, menu5)
                data.target = data5.current
                data.currentSlot = data.current.slot
                data.targetSlot = data5.current.slot
                data.quantity = 1
                data.oldInv = "inventory"
                data.newInv = data5.current.inv and "inventory" or "none"
                data.value = data5.current.value
                itemDesc(data, invData, invData2)
              end)
            end
          elseif data2.current.value == "slot" then
            menu2.close()
            UI:Open("MenuDialog", {
              name = data.current.name,
              title = "Wpisz slot",
              -- inventories = Inventories,
              elements = {
                {
                  label = "Użyj",
                  value = "use",
                },
                {
                  label = "Przekaż",
                  value = "give",
                },
              },
              -- quantity = 1,
              show = true,
              align = "center",
            }, function(data5, menu5)
              menu5.close()
              data.oldInv = "inventory"
              data.newInv = "inventory"
              data.currentSlot = data.current.slot
              data.targetSlot = tonumber(data5.current.value)
              data.quantity = data.current.count
              changeSlot(data)
            end)
          else
            menu2.close()
            UI:Open("MenuDialog", {
              name = data.current.name,
              title = "Wpisz ilosć",
              -- inventories = Inventories,
              elements = {
                {
                  label = "Użyj",
                  value = "use",
                },
                {
                  label = "Przekaż",
                  value = "give",
                },
              },
              -- quantity = 1,
              show = true,
              align = "center",
            }, function(data5, menu5)
              menu5.close()
              data.quantity = tonumber(data5.current.value) or 1
              data.oldInv = "inventory"
              data.newInv = "drop"
              data.currentSlot = data.current.slot
              data.targetSlot = math.random(1, 50)
              changeInventory(data, invData, invData2)
            end)
          end
        end)
      else
        data.quantity = tonumber(data.current.value) or 1
        data.currentSlot = data.current.slot
        local targetSlot = math.random(1, 50)
        for k2, v2 in pairs(firstInv.items) do
          if v2.name == data.current.name then
            targetSlot = v2.slot
            data.target = v2
            -- print(targetSlot)
            -- data.targetSlot = targetSlot
            -- changeItem(data, invData, invData2)
            -- return
          end
        end
        data.targetSlot = targetSlot
        data.oldInv = secondInv.name
        data.newInv = "inventory"
        changeInventory(data, invData, invData2)
      end
    end, function(data, menu)
      -- cancel
      Event:TriggerNet("dwb:inventory:closed")
      menu.close()
      UI:CloseAll()
      -- end, function(data, menu)
      -- data.quantity = tonumber(data.quantity)
      -- --change
      -- if data.action == 'inventory_change' then
      --     changeInventory(data, invData, invData2)
      -- elseif data.action == 'slot_change' then
      --     changeSlot(data, invData, invData2)
      -- elseif data.action == 'item_change' then
      --     changeItem(data, invData, invData2)
      -- elseif data.action == 'inventory_item_desc' then
      --     itemDesc(data, invData, invData2)
      -- end
    end)
  end
end

Event:Register("dwb:inventory:open", function(data)
  DWB.PlayerData.char.inventory = data[1].items
  ShowInventory(data)
end, true)

Thread:Create(function()
  SetWeaponsNoAutoswap(true)
  while true do
    Wait(0)
    if DWB.PlayerData.HasWeapon and DWB.PlayerData.IsShooting then
      Event:TriggerNet("dwb:inventory:sync:ammo", DWB.PlayerData.Weapon, DWB.PlayerData.Ammo)
    end
  end
end)

Key:onJustPressed("F2", "Ekwipunek (F2)", function()
  if not UI:IsOpen("inventory") and not IsEntityDead(PlayerPedId()) then
    if not DWB.PlayerData.InVehicle then
      local itemFound = false
      for k, v in pairs(DWB.PlayerData.ClosestObjects) do
        if v.dist <= 5.0 and v.state.isPackage then
          Event:TriggerNet("dwb:inventory:open", 50, NetworkGetNetworkIdFromEntity(v.obj))
          return
        end
      end
      Event:TriggerNet("dwb:inventory:open")
    else
      local class = GetVehicleClass(DWB.PlayerData.Vehicle)
      Event:TriggerNet("dwb:inventory:open", Config.Inventory.VehicleSlots[class] or 25)
    end
  end
end)

function itemBySlot(slot)
  for k, v in pairs(DWB.PlayerData.char.inventory) do
    if tonumber(v.slot) == slot then
      return v
    end
  end
end

for i = 1, 5 do
  Key:onJustPressed(tostring(i), string.format("Użyj slota %s", i), function()
    local item = itemBySlot(i)
    if not item then
      return
    end
    local cb = Config.Inventory.ItemCallbacks[item.name]
    if not cb or Config.Inventory.Functions[cb.cb](table.unpack(cb.args)) then
      local itemType = item.type
      local job = User:GetJob({ "police", "ambulance", "mechanic" })
      if job and item.type == "weapon" then
        itemType = "weapon_fraction"
      end
      local anim = Config.Inventory.Animations[itemType]
      if anim then
        anim.play()
      end
      Event:TriggerNet("dwb:inventory:use", item, data)
    end
  end)
end

function useItem(data, data2, invData2)
  local item = data.current
  local cb = Config.Inventory.ItemCallbacks[item.name]
  if not cb or Config.Inventory.Functions[cb.cb](table.unpack(cb.args)) then
    local itemType = item.type
    local job = User:GetJob({ "police", "ambulance", "mechanic" })
    if job and item.type == "weapon" then
      itemType = "weapon_fraction"
    end
    local anim = Config.Inventory.Animations[itemType]
    if anim then
      anim.play()
    end
    Event:TriggerNet("dwb:inventory:use", data, data2, invData2)
  end
end
