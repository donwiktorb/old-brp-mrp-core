Event:Register("dwb:property:room", function(posData, prop)
  local elements = {}

  table.insert(elements, {
    label = "Zapisz strój",
    value = "save-skin",
  })

  table.insert(elements, {
    label = "Usuń strój",
    value = "remove-skin",
  })

  table.insert(elements, {
    label = "Stroje",
    value = "skin",
  })

  table.insert(elements, {
    label = "Szafka",
    value = "eq",
  })

  UI:Open("Menu", {
    name = "property-room",
    title = "Mieszkanie",
    elements = elements,
  }, function(data, menu)
    if data.current.value == "save-skin" then
      local skin = Skinchanger:GetSkin()
      menu.close()
      UI:Open("MenuDialog", {
        name = "property-room-skin",
        title = "Wpisz nazwę",
      }, function(data5, menu5)
        menu5.close()
        Event:TriggerNet("dwb:property:save:skin", data5.current.value, skin)
      end)
    elseif data.current.value == "remove-skin" then
      local newElements = {}
      for k, v in pairs(prop.clothes) do
        table.insert(newElements, {
          label = v.label,
          value = k,
        })
      end
      UI:Open("Menu", {
        name = "property-room5",
        title = "Mieszkanie",
        elements = newElements,
      }, function(data5, menu5)
        menu5.close()
        Event:TriggerNet("dwb:property:remove:skin", data5.current.value)
      end)
    elseif data.current.value == "skin" then
      UI:Open("Menu", {
        name = "property-room2",
        title = "Mieszkanie",
        elements = prop.clothes,
      }, function(data5, menu5)
        menu5.close()
        Skinchanger:Apply(false, data5.current.skin)
      end)
    elseif data.current.value == "eq" then
      menu.close()
      Event:TriggerNet("dwb:property:inventory")
    end
  end)
end, true)

Event:Register("dwb:property:menu", function(posData, houses, owned, owned_number, owned_limit)
  local _owned_num = owned_number
  local _owned_lim = owned_limit
  local elements = {}
  if houses then
    for k2, v2 in pairs(houses) do
      table.insert(elements, {
        label = v2.label,
        value = v2.name,
        price = v2.price,
        owned = v2.owned,
        name = v2.name,
        data = v2.data,
        one_owner = v2.one_owner,
        owner = v2.owner,
      })
    end
  else
    table.insert(elements, {
      label = posData.label,
      value = posData.name,
      price = posData.price,
      owned = owned,
      name = posData.name,
      data = posData,
      one_owner = posData.one_owner,
      owner = posData.owner,
    })
  end

  UI:Open("Menu", {
    name = "property",
    title = "Mieszkanie",
    elements = elements,
  }, function(data, menu)
    local elements2 = {}
    if
      not data.current.owned
      and (not data.current.one_owner or not data.current.owner)
      and _owned_num < _owned_lim
    then
      table.insert(elements2, {
        label = ("Zakup za %s $"):format(data.current.price),
        value = "buy",
      })
    elseif data.current.owned then
      table.insert(elements2, {
        label = "Wejdź",
        value = "enter",
      })
    end

    if houses then
      table.insert(elements2, {
        label = "Zadzwoń",
        value = "call",
      })
    else
      table.insert(elements2, {
        label = "Zapukaj",
        value = "call",
      })
    end

    UI:Open("Menu", {
      name = "property2",
      title = "Mieszkanie",
      elements = elements2,
    }, function(data2, menu2)
      if data2.current.value == "enter" then
        Event:TriggerNet("dwb:property:enter", posData, data.current.data)
      elseif data2.current.value == "buy" then
        menu.close()
        menu2.close()
        Event:TriggerNet("dwb:property:buy", data.current)
      elseif data2.current.value == "call" then
        Event:TriggerCb("dwb:property:call", function(players)
          local elements2 = {}
          for k, v in pairs(players) do
            table.insert(elements2, {
              label = v.name,
              value = v.source,
            })
          end
          UI:Open("Menu", {
            name = "property5",
            title = "Mieszkanie",
            elements = elements2,
          }, function(data5, menu5)
            menu5.close()
            Event:TriggerNet("dwb:property:ask", data5.current.value)
          end)
        end, data.current)
      end
    end)
  end)
end, true)

local knocking = nil

Event:Register("dwb:property:ask", function(src, name)
  if not knocking then
    knocking = src
    SendNuiMessage(json.encode({
      type = "Notify2",
      action = "open",
      data = {
        show = true,
        content = string.format(
          "%s prosi o wejście. Naciśnij <k>G</k> aby zaakceptować albo <k>C</k>, aby odrzucić..",
          name
        ),
      },
    }))
    Wait(15000)
    knocking = nil
    SendNuiMessage(json.encode({
      type = "Notify2",
      action = "close",
      data = {
        show = true,
        content = string.format(
          "%s prosi o wejście. Naciśnij <k>G</k> aby zaakceptować albo <k>C</k>, aby odrzucić..",
          name
        ),
      },
    }))
  end
end, true)

Key:onJustPressed("G", "Zaakceptuj zaproszenie do mieszkania", function()
  if knocking then
    Event:TriggerNet("dwb:property:ask:accept", knocking)
    knocking = nil
  end
end)

Key:onJustPressed("C", "Odrzuć zaproszenie do mieszkania", function()
  if knocking then
    Event:TriggerNet("dwb:property:ask:deny", knocking)
    knocking = nil
  end
end)

Event:Register("dwb:property:enter", function(data)
  UI:CloseAll()
  if data.ipls then
    for k, v in pairs(data.ipls) do
      RequestIpl(v)
      while not IsIplActive(v) do
        Wait(0)
      end
    end
  end

  if data.room_menu then
    Marker:Add("property-room", {
      -- -- name = 'property-room',
      -- -- type = 'property-room',
      -- -- functions = {
      -- --     onClickCb = function(zoneData, posData)
      -- --         Event:TriggerNet('dwb:marker:submit', zoneData, posData)
      -- --     end,
      -- -- },
      coords = {
        {
          pos = vec3(data.room_menu.x, data.room_menu.y, data.room_menu.z),
        },
      },
    })
  end

  User:Teleport({
    coords = vec3(data.inside.x, data.inside.y, data.inside.z),
    heading = 44.44,
  })
end, true)

Event:Register("dwb:property:exit", function(data)
  Marker:Remove("room-menu")
  User:Teleport({
    coords = vec3(data.outside.x, data.outside.y, data.outside.z),
    heading = 44.44,
  })

  if data.ipls then
    for k, v in pairs(data.ipls) do
      RemoveIpl(v)
    end
  end
end, true)

local props = {}

Event:Register("dwb:property:loaded", function(properties)
  for k, v in pairs(properties) do
    Wait(0)
    props[v.name] = true
    print(v.name, v.single, json.encode(v), Interact.Markers)
    if not v.single then
      Interact.Markers:Edit(
        { { "name", { "data", "name" } }, { "property-enter", v.name }, { "coords" } },
        {
          fromParent = { { "ownedBlip" } },
          toChild = { { "blip" } },
          refreshBlip = true,
        }
      )
      --MarkerM:EditBlipByData('name', 'property-enter', 'name', v.name, false, 'ownedBlip')
    else
      Interact.Markers:Edit(
        { { "name", { "data", "name" } }, { "property-enter", v.name }, { "coords" } },
        {
          fromParent = { { "ownedSingleBlip" } },
          toChild = { { "blip" } },
          refreshBlip = true,
        }
      )
      --MarkerM:EditBlipByData('name', 'property-enter', 'name', v.name, false, 'ownedSingleBlip')
    end
  end
end, true)

Event:Register("dwb:property:owned", function(name, charId)
  if not props[name] then
    props[name] = true
    --Interact.Markers:Edit(
    --  { { "name", { "data", "name" } }, { "property-enter", name }, { "coords" } },
    --  {
    --    refreshBlip = true,
    --    fromParent = { { "ownedSingleBlip" } },
    --    toChild = { { "blip" } },
    --  }
    --)
    --        Cursor:EditMarker('boskierp', 'name', 'property-enter', {
    --      singleKey = 'name',
    --      singleValue = name,
    --      cb = function(v, v4)
    --v4.data.owner =  charId,
    --        v4.noBlip = true
    --      end
    --    })
  end
end, true)
