function OpenSettings()
  DWB.OLDSettings = json.decode(json.encode(DWB.UISettings))
  UI:Open("MenuSide", {
    name = "settings",
    title = "Ustawienia (nacisnij ALT dla kursora)",
    show = true,
    side = "right",
    main = 0,
    elements = {
      {
        type = "button",
        name = "settings",
        label = "Bindy, Keybindy, Przyciski, Klawiszologia",
      },
      {
        type = "checkbox",
        name = "outlines",
        label = "Markery nad pedami lub obiektami z interakcją",
        value = DWB.UISettings["outlines"],
      },
      {
        type = "checkbox",
        name = "speedometer-on",
        label = "Licznik",
        value = DWB.UISettings["speedometer-on"],
      },
      {
        type = "checkbox",
        name = "compass",
        label = "Kompas",
        value = DWB.UISettings["compass"],
      },
      {
        type = "checkbox",
        name = "hud-on",
        label = "Hud",
        value = DWB.UISettings["hud-on"],
      },

      {
        type = "number",
        min = 0,
        max = 500,
        value = DWB.UISettings["compass-update"] or 100,
        name = "compass-update",
        label = "Aktualizacja kompasu co ile (ms)",
      },
      {
        type = "number",
        min = 0,
        max = 500,
        value = DWB.UISettings["hud-update"] or 100,
        name = "hud-update",
        label = "Aktualizacja hudu co ile (ms)",
      },
      {
        type = "number",
        min = 0,
        max = 200,
        value = DWB.UISettings["speed-scale"] or 100,
        name = "speed-scale",
        label = "Skala licznika (%)",
      },
      {
        type = "number",
        min = 0,
        max = 200,
        value = DWB.UISettings["speed-update"] or 100,
        name = "speed-update",
        label = "Aktualizacja licznika co ile (ms)",
      },
      {
        type = "number",
        min = 0.0,
        max = 1.0,
        value = DWB.UISettings["volume"] or 1,
        name = "volume",
        label = "Głośność (od 0.0 do 1.0)",
      },
      {
        type = "number",
        min = 0,
        max = 100,
        value = DWB.UISettings["car-radio-volume"] or 70,
        name = "car-radio-volume",
        label = "Głośność radia samochodu (od 0.0 do 100.0)",
      },
      {
        type = "number",
        min = 0.0,
        max = 1.0,
        value = DWB.UISettings["radio-volume"] or 1.0,
        name = "radio-volume",
        label = "Głośność radia (od 0.0 do 1.0)",
      },
      {
        type = "select",
        name = "speedometer",
        label = "Hud Samochodu (3 wersje)",
        value = DWB.UISettings["speedometer"],
        options = {
          {
            label = "Hud domyślny",
            value = 0,
          },
          {
            label = "Hud uproszczony",
            value = 1,
          },
          {
            label = "Hud OG (Kwadrat z numerkiem)",
            value = 4,
          },
        },
      },
      {
        type = "select",
        name = "inventory",
        label = "Ekwipunek",
        value = DWB.UISettings["inventory"],
        options = {
          {
            label = "Prosty",
            value = 0,
          },
          {
            label = "Kafelkowy",
            value = 1,
          },
        },
      },
      {
        type = "select",
        name = "phone",
        label = "Telefon (Sterowanie myszka)",
        value = DWB.UISettings["phone"] or 0,
        options = {
          {
            label = "Bez ruszania sie",
            value = 0,
          },
          {
            label = "Z ruszaniem sie",
            value = 1,
          },
        },
      },
      {
        type = "select",
        name = "speedometer-main",
        label = "Pozycja licznika",
        value = (DWB.UISettings["speedometer-main"] or 0),
        options = {
          {
            label = "Prawy Dolny",
            value = 0,
          },
          {
            label = "Dolny Środek",
            value = 1,
          },
          {
            label = "Góra śodek",
            value = 2,
          },
          {
            label = "Środek Środek",
            value = 3,
          },
          {
            label = "Lewy Dolny",
            value = 4,
          },
          {
            label = "Lewa Góra",
            value = 5,
          },
          {
            label = "Lewy środek",
            value = 6,
          },
          {
            label = "Prawy środek",
            value = 7,
          },
          {
            label = "Prawy góra",
            value = 8,
          },
        },
      },
      {
        type = "select",
        name = "hud-main",
        label = "Pozycja Hudu",
        value = (DWB.UISettings["hud-main"] or 0),
        options = {
          {
            label = "Srodek Dol",
            value = 0,
          },
          {
            label = "Srodek gora",
            value = 1,
          },
          {
            label = "Lewa gora",
            value = 2,
          },
          {
            label = "Prawa Gora",
            value = 3,
          },
          {
            label = "Prawa dol",
            value = 4,
          },
          {
            label = "Lewa Dol",
            value = 5,
          },
        },
      },
      {
        type = "color",
        name = "hud-color-icon",
        value = DWB.UISettings["hud-color-icon"],
        label = "Kolor iknoek HUD",
      },
      -- {
      --     type = 'color',
      --     name = 'hud-color-text',
      --     label = 'Kolor tekstu HUD'
      -- },
      {
        type = "color",
        value = DWB.UISettings["hud-color-bg"],
        name = "hud-color-bg",
        label = "Kolor tła HUD",
      },
      {
        type = "number",
        min = 0.0,
        max = 100.0,
        name = "hud-opacity",
        label = "Przezroczystosc hudu",
        value = DWB.UISettings["hud-opacity"],
      },
      {
        type = "checkbox",
        name = "hud-compass",
        label = "Kompas w hudzie",
        value = DWB.UISettings["hud-compass"],
      },
      {
        type = "checkbox",
        name = "hud-time",
        label = "Czas w hudzie",
        value = DWB.UISettings["hud-time"],
      },
    },
  }, function(data, menu)
    for k, v in pairs(data.menu.elements) do
      if tonumber(v.value) then
        v.value = tonumber(v.value)
      end
      DWB.UISettings[v.name] = type(v.value) == "table" and v.value.value or v.value
    end
    menu.close()
    local items = {}
    for k, v in pairs(DWB.UISettings) do
      table.insert(items, {
        name = k,
        value = v,
      })
    end
    Event:Trigger("dwb:settings:changed", DWB.UISettings)
    SendNuiMessage(json.encode({
      action = "setItems",
      items = items,
    }))
  end, function(data, menu)
    menu.close()
    if DWB.OLDSettings then
      for k, v in pairs(DWB.OLDSettings) do
        DWB.UISettings[k] = v
      end
    end
  end, function(data, menu)
    if data.current.name == "settings" then
      menu.close()
      ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_LANDING_KEYMAPPING_MENU"), true, 44)
    else
      for k, v in pairs(data.menu.elements) do
        if tonumber(v.value) then
          v.value = tonumber(v.value)
        end
        DWB.UISettings[v.name] = type(v.value) == "table" and v.value.value or v.value
      end
      -- local items = {}
      -- for k,v in pairs(DWB.UISettings) do
      --     table.insert(items, {
      --         name = k,
      --         value = v
      --     })
      -- end
      Event:Trigger("dwb:settings:changed", DWB.UISettings)
      -- SendNuiMessage(json.encode({
      --     action = 'setItems',
      --     items = items
      -- }))
    end
  end)
end

RegisterCommand("ustawienia", function(s, a)
  OpenSettings()
end)

Key:onJustPressed("F9", "Ustawienia", function()
  UI:CloseAll()
  OpenSettings()
end)
