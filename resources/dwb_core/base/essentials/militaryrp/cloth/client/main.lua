Key:onJustReleased("K", "Menu ubrań (K)", function()
  OpenAccessoryMenu()
end)

function OpenAccessoryMenu()
  local elements = {}

  for k, v in ipairs(Config.Clothes) do
    table.insert(elements, { label = v.label, value = k })
  end

  UI:Open("Menu", {
    name = "clothes2",
    title = "Zdejmij / Załóż",
    align = "center",
    elements = elements,
  }, function(data, menu)
    PutOnOff(data.current.value)
  end, function(data, menu)
    menu.close()
  end)
end

function PutOnOff(key)
  local obj = Config.Clothes[key]
  if obj.name then
    if obj.name == "putOnAll" then
      Callback:Trigger("dwb:skin:getPlayerSkin", function(skin)
        TriggerEvent("dwb_skinchanger:loadSkin", skin)
      end)
    elseif obj.name == "putOffAll" then
      TriggerEvent("dwb_skinchanger:getSkin", function(skin)
        local newClothes
        if skin.sex == 0 then
          newClothes = obj.clothes.male
        else
          newClothes = obj.clothes.female
        end

        TriggerEvent("dwb_skinchanger:loadClothes", skin, newClothes)
      end)
    end
    local lib, anim = obj.anim.lib, obj.anim.anim

    Stream:RequestAnimDict(lib, function()
      TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)
    end)
    return
  end
  TriggerEvent("dwb_skinchanger:getSkin", function(skin)
    if not obj.naked then
      local newClothes

      if skin.sex == 0 then
        newClothes = obj.clothes.male
      else
        newClothes = obj.clothes.female
      end

      if newClothes then
        TriggerEvent("dwb_skinchanger:loadClothes", skin, newClothes)
        obj.naked = true
        for k, v in pairs(newClothes) do
          obj.nakedClothes[k] = skin[k]
        end
      end
    else
      obj.naked = false
      TriggerEvent("dwb_skinchanger:loadClothes", skin, obj.nakedClothes)
      obj.nakedClothes = {}
      -- Callback:Trigger('dwb_skin:getPlayerSkin', function(skin)
      -- 	TriggerEvent('dwb_skinchanger:loadSkin', skin)
      -- end)
    end
  end)

  local lib, anim = obj.anim.lib, obj.anim.anim

  Stream:RequestAnimDict(lib, function()
    TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)
  end)
end
