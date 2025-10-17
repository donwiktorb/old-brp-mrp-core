SetDefaultVehicleNumberPlateTextPattern(2, " AAA111 ")

function getMods(veh, modType, label2)
  local mods = {}

  local modsNum = GetNumVehicleMods(veh, modType) - 1

  table.insert(mods, {
    label = "Stock",
    index = -1,
  })

  for i = 0, modsNum do
    local label = label2 .. " " .. i
    local labelName = GetModTextLabel(veh, modType, i)
    if labelName then
      label = GetLabelText(labelName)
    end
    table.insert(mods, {
      label = label,
      index = i,
    })
  end
  return mods
end

function setColliderSize(veh, value)
  for i = 0, GetVehicleNumberOfWheels(veh) do
    SetVehicleWheelTireColliderSize(veh, i, value)
  end
end

function setColliderWidth(veh, value)
  for i = 0, GetVehicleNumberOfWheels(veh) do
    SetVehicleWheelTireColliderWidth(veh, i, value)
  end
end

function getWheelsTractionVectorLength(veh)
  local wheels = {}
  for i = 0, GetVehicleNumberOfWheels(veh) do
    table.insert(wheels, {
      type = "number",
      name = "wheel-traction-vector",
      wheel = i,
      label = "Trackja wktora dlugosci " .. i,
      value = GetVehicleWheelTractionVectorLength(veh, i),
    })
  end

  return wheels
end

function getWheelsRotSpeed(veh)
  local wheels = {}
  for i = 0, GetVehicleNumberOfWheels(veh) do
    table.insert(wheels, {
      type = "number",
      name = "wheel-rot-speed",
      wheel = i,
      label = "Szybkość obrotu koła " .. i,
      value = GetVehicleWheelRotationSpeed(veh, i),
    })
  end

  return wheels
end

function getPoweredWheels(veh)
  local wheels = {}
  for i = 0, GetVehicleNumberOfWheels(veh) do
    table.insert(wheels, {
      type = "checkbox",
      name = "wheel-powered",
      wheel = i,
      label = "Napęd na koło " .. i,
      value = GetVehicleWheelIsPowered(veh, i),
    })
  end

  return wheels
end
function getWheelsPower(veh)
  local wheels = {}
  for i = 0, GetVehicleNumberOfWheels(veh) do
    table.insert(wheels, {
      type = "number",
      name = "wheel-power",
      wheel = i,
      label = "Napęd na koło " .. i,
      value = GetVehicleWheelPower(veh, i),
    })
  end

  return wheels
end

function generateMenu()
  local elements = {}

  local veh = GetVehiclePedIsIn(PlayerPedId())
  local vehProp = Vehicle:GetProperties2(veh)

  SetVehicleModKit(veh, 0)
  -- for k,v in pairs(modTypes) do
  --     local mods = GetNumVehicleMods(veh, v)
  --     table.insert(elements, {
  --         label = k
  --     })
  -- end

  local pageLabels = {
    "Mechaniczne",
    "Dodatki",
    "Kolory",
    "Koła",
    "Karoseria",
    "Extrasy",
    "Livery",
    "Nieznane",
    "Stock",
    "Unkown",
  }

  local engineMods = {}

  local engineModsNum = GetNumVehicleMods(veh, 11) - 1

  for i = -1, engineModsNum do
    table.insert(engineMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local breakMods = {}

  local breakModsNum = GetNumVehicleMods(veh, 12) - 1

  for i = -1, breakModsNum do
    table.insert(breakMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local gearMods = {}

  local gearModsNum = GetNumVehicleMods(veh, 13) - 1

  for i = -1, gearModsNum do
    table.insert(gearMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local suspensionMods = {}

  local suspensionModsNum = GetNumVehicleMods(veh, 15) - 1

  for i = -1, suspensionModsNum do
    table.insert(suspensionMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local armorMods = {}

  local armorModsNum = GetNumVehicleMods(veh, 16) - 1

  for i = -1, armorModsNum do
    table.insert(armorMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local boostMods = {}

  local boostModsNum = GetNumVehicleMods(veh, 40) - 1

  for i = -1, boostModsNum do
    table.insert(boostMods, {
      label = "Poziom " .. i + 1,
      index = i,
    })
  end

  local driftTyres --[[ boolean ]] = GetDriftTyresEnabled(veh --[[ Vehicle ]])

  local windowTints = {
    {
      label = "Brak",
      tint = 0,
    },
    {
      label = "Czarne",
      tint = 1,
    },
    {
      label = "Czarny Dym",
      tint = 2,
    },
    {
      label = "Lekki Dym",
      tint = 3,
    },
    {
      label = "Stock",
      tint = 4,
    },
    {
      label = "Limuzynowe",
      tint = 5,
    },

    -- -- 'Czarne',
    -- -- 'Czarny Dym',
    -- -- 'Lekki Dym',
    -- -- 'Stock',
    -- -- 'Limuzynowe',
    -- -- 'Zielone'
  }

  local r, g, b = GetVehicleCustomPrimaryColour(veh)

  local primaryColor = {
    r = r,
    g = g,
    b = b,
  }

  local r, g, b = GetVehicleCustomSecondaryColour(veh)

  local secondaryColor = {
    r = r,
    g = g,
    b = b,
  }

  local normalColors = {}

  for k, v in pairs(Config.Mechanic.Colors["normal"]) do
    table.insert(normalColors, {
      label = v,
      color = k,
      colorType = 0,
    })
  end

  local metalicColors = {}

  for k, v in pairs(Config.Mechanic.Colors["metallic"]) do
    table.insert(metalicColors, {
      label = v,
      color = k,
      colorType = 1,
    })
  end

  local pearlColors = {}

  for k, v in pairs(Config.Mechanic.Colors["pearl"]) do
    table.insert(pearlColors, {
      label = v,
      color = k,
      colorType = 2,
    })
  end

  local matteColors = {}

  for k, v in pairs(Config.Mechanic.Colors["matte"]) do
    table.insert(matteColors, {
      label = v,
      color = k,
      colorType = 3,
    })
  end

  local metalColors = {}

  for k, v in pairs(Config.Mechanic.Colors["metal"]) do
    table.insert(metalColors, {
      label = v,
      color = k,
      colorType = 4,
    })
  end

  local chromeColors = {}

  for k, v in pairs(Config.Mechanic.Colors["chrome"]) do
    table.insert(chromeColors, {
      label = v,
      color = k,
      colorType = 5,
    })
  end

  local paintType, --[[ integer ]]
    color, --[[ integer ]]
    pearlescentColor --[[ integer ]] =
    GetVehicleModColor_1(veh --[[ Vehicle ]])

  local paintType2, --[[ integer ]]
    color2 --[[ integer ]] =
    GetVehicleModColor_2(veh --[[ Vehicle ]])

  local hasXenon, --[[ boolean ]]
    red, --[[ integer ]]
    green, --[[ integer ]]
    blue --[[ integer ]] =
    GetVehicleXenonLightsCustomColor(veh --[[ Vehicle ]])

  local xenonColor = {
    r = red,
    g = green,
    b = blue,
  }

  local xenonColors = {
    {
      label = "Domyślne",
      color = -1,
    },
    {
      label = "Biały",
      color = 0,
    },
    {
      label = "Niebieski",
      color = 1,
    },
    {
      label = "Elektryczny Niebieski",
      color = 2,
    },
    {
      label = "Miętowa Zieleń",
      color = 3,
    },
    {
      label = "Limonkowa Zieleń",
      color = 4,
    },
    {
      label = "Żółty",
      color = 5,
    },
    {
      label = "Złoty Prysznic",
      color = 6,
    },
    {
      label = "Pomarańczowy",
      color = 7,
    },
    {
      label = "Czerwony",
      color = 8,
    },
    {
      label = "Różowy kucyk",
      color = 9,
    },
    {
      label = "Gorący Róż",
      color = 10,
    },
    {
      label = "Fiolet",
      color = 11,
    },

    {
      label = "Czarne światło",
      color = 12,
    },
  }

  local xenonColorMod = GetVehicleXenonLightsColor(veh)

  local r, --[[ integer ]]
    g, --[[ integer ]]
    b --[[ integer ]] =
    GetVehicleNeonLightsColour(veh --[[ Vehicle ]])

  local neonColor = {
    r = r,
    g = g,
    b = b,
  }

  local dashboardColor --[[ integer ]] = GetVehicleDashboardColor(veh --[[ Vehicle ]])

  local r, --[[ integer ]]
    g, --[[ integer ]]
    b --[[ integer ]] =
    GetVehicleTyreSmokeColor(veh --[[ Vehicle ]])

  local tyreSmokeColor = {
    r = r,
    g = g,
    b = b,
  }

  local interiorColor --[[ integer ]] = GetVehicleInteriorColor(veh --[[ Vehicle ]])

  local pearlescentColorExtra, --[[ integer ]]
    wheelColorExtra --[[ integer ]] =
    GetVehicleExtraColours(veh --[[ Vehicle ]])

  local bulletProof --[[ boolean ]] = GetVehicleTyresCanBurst(veh --[[ Vehicle ]])

  local horns = {}

  local hornModsNum = GetNumVehicleMods(veh, 14) - 1

  table.insert(horns, {
    label = "Stock",
    index = -1,
  })

  for i = 0, hornModsNum do
    local label = Config.Mechanic.Horns[i + 1]
    table.insert(horns, {
      label = label and label.label or "Klakson " .. i,
      index = i,
    })
  end

  local tints2 = {}

  local tintModsNum = GetNumVehicleMods(veh, 14) - 1

  table.insert(tints2, {
    label = "Stock",
    index = -1,
  })

  for i = 0, tintModsNum do
    table.insert(tints2, {
      label = "Szyby " .. i,
      index = i,
    })
  end

  local wheelType = GetVehicleWheelType(veh) - 1

  local wheelMods = {}

  local wheelModsNum = GetNumVehicleMods(veh, 23) - 1

  table.insert(wheelMods, {
    label = "Stock",
    index = -1,
  })

  for i = 0, wheelModsNum do
    local label = "Koła " .. i
    local labelName = GetModTextLabel(veh, 23, i)
    if labelName then
      label = GetLabelText(labelName)
    end
    table.insert(wheelMods, {
      label = label,
      index = i,
    })
  end

  local plateIndex --[[ integer ]] = GetVehicleNumberPlateTextIndex(veh --[[ Vehicle ]]) + 1

  local spoilerMods = {}

  local spoilerModsNum = GetNumVehicleMods(veh, 0) - 1

  table.insert(spoilerMods, {
    label = "Stock",
    wheel = -1,
  })

  for i = 0, spoilerModsNum do
    local label = "Spoiler " .. i
    local labelName = GetModTextLabel(veh, 0, i)
    if labelName then
      label = GetLabelText(labelName)
    end
    table.insert(spoilerMods, {
      label = label,
      index = i,
    })
  end

  local frontBumperMods = getMods(veh, 1, "Przedni Bumper")
  local rearBumperMods = getMods(veh, 2, "Tylni Bumper")
  local sideSkirtMods = getMods(veh, 3, "Bocznye brzegi")
  local exhaustMods = getMods(veh, 4, "Wydech")
  local frameMods = getMods(veh, 5, "Klatka")
  local grillMods = getMods(veh, 6, "Grill")
  local hoodMods = getMods(veh, 7, "Maska")
  local fenderLeftMods = getMods(veh, 8, "Błotnik Lewy")
  local fenderRightMods = getMods(veh, 9, "Błotnik Prawy")
  local roofMods = getMods(veh, 10, "Dach")
  local plateHoldersMods = getMods(veh, 25, "Blachy")
  local plateVanityMods = getMods(veh, 26, "Blachy 2")
  local trimDesignsMods = getMods(veh, 27, "Interior 1/Trim")
  local trimDesigns2Mods = getMods(veh, 28, "Interior 2/Trim")
  local trimDesigns3Mods = getMods(veh, 29, "Interior 3/Trim")
  local trimDesigns4Mods = getMods(veh, 30, "Interior 4/Trim")
  local trimDesigns5Mods = getMods(veh, 31, "Interior 5/Trim")
  local seatsMods = getMods(veh, 32, "Siedzenia")
  local steeringMods = getMods(veh, 33, "Kierwonica")
  local shiftLevelMods = getMods(veh, 34, "Skrzynia Biegów")
  local plaqueMods = getMods(veh, 35, "Plakieta")
  local iceMods = getMods(veh, 36, "Lód")
  local trunkMods = getMods(veh, 37, "Bagażnik")
  local hydroMods = getMods(veh, 38, "Hydraulics")
  local engineBayMods = getMods(veh, 39, "Komora Silnika")
  local engineBay2Mods = getMods(veh, 40, "Komora Silnika 2")
  local engineBay3Mods = getMods(veh, 41, "Komora Silnika 3")
  local chasis2Mods = getMods(veh, 42, "Podwozie 2")
  local chasis3Mods = getMods(veh, 43, "Podwozie 3")
  local chasis4Mods = getMods(veh, 44, "Podwozie 4")
  local chasis5Mods = getMods(veh, 45, "Podwozie 5")
  local doorLeftMods = getMods(veh, 46, "Drzwi Lewo")
  local doorRightMods = getMods(veh, 47, "Drzwi Prawo")
  local liveryMods = getMods(veh, 48, "Naklejki")
  local lightBarMods = getMods(veh, 49, "Światło")

  local uknownMods = {}

  for i = 49, 200 do
    local uknownMod = getMods(veh, i, "Nieznany mod")
    table.insert(uknownMods, {
      type = "select",
      name = "uknown-mod" .. i,
      label = "Nieznany mod " .. i,
      value = GetVehicleMod(veh, i),
      options = uknownMod,
      modType = i,
    })
  end

  local extras = {}

  for i = 0, 40 do
    if DoesExtraExist(veh, i) then
      table.insert(extras, {
        type = "checkbox",
        name = "extras",
        label = "Extras " .. i,
        extras = i,
        value = IsVehicleExtraTurnedOn(veh, i),
      })
    end
  end

  local liveries = {}

  local liveryNum --[[ integer ]] = GetVehicleLiveryCount(veh --[[ Vehicle ]])

  for i = 0, liveryNum do
    local label = GetLiveryName(veh, i)
    if label then
      label = GetLabelText(label)
    end
    table.insert(liveries, {
      label = label or "Livery " .. i,
      livery = i,
    })
  end

  local roofLiveries = {}

  local roofLiveriesNum --[[ integer ]] = GetVehicleRoofLiveryCount(veh --[[ Vehicle ]])

  for i = 0, roofLiveriesNum do
    local label = GetLiveryName(veh, i)
    if label then
      label = GetLabelText(label)
    end
    table.insert(roofLiveries, {
      label = label or "Livery " .. i,
      livery = i,
    })
  end

  local modKits = {}

  local modKitsNum --[[ integer ]] = GetNumModKits(vehicle --[[ Vehicle ]])

  for i = 0, modKitsNum do
    table.insert(modKits, {
      label = label or "Modkit " .. i,
      modkit = i,
    })
  end

  local pages = {
    {
      {
        type = "select",
        name = "engine",
        label = "Silnik",
        modType = 11,
        value = GetVehicleMod(veh, 11) + 1,
        options = engineMods,
      },
      {
        type = "select",
        name = "breaks",
        label = "Hamulce",
        modType = 12,
        value = GetVehicleMod(veh, 12) + 1,
        options = breakMods,
      },
      {
        type = "select",
        name = "gearbox",
        label = "Skrzynia biegów",
        modType = 13,
        value = GetVehicleMod(veh, 13) + 1,
        options = gearMods,
      },
      {
        type = "select",
        name = "gearbox",
        label = "Skrzynia biegów",
        modType = 15,
        value = GetVehicleMod(veh, 15) + 1,
        options = suspensionMods,
      },
      {
        type = "select",
        name = "armor",
        label = "Armor",
        modType = 16,
        value = GetVehicleMod(veh, 16) + 1,
        options = suspensionMods,
      },
      {
        type = "select",
        name = "boost",
        label = "Boost",
        modType = 40,
        value = GetVehicleMod(veh, 40) + 1,
        options = boostMods,
      },

      {
        type = "checkbox",
        name = "nitro",
        label = "Nitro",
        modType = 17,
        toggle = true,
        value = IsToggleModOn(veh, 17) == 1,
      },
      {
        type = "checkbox",
        name = "turbo",
        label = "Turbo",
        modType = 18,
        toggle = true,
        value = IsToggleModOn(veh, 18) == 1,
      },
      {
        type = "checkbox",
        name = "subwoofer",
        label = "Subwoofer",
        modType = 19,
        toggle = true,
        value = IsToggleModOn(veh, 19) == 1,
      },
      {
        type = "checkbox",
        name = "hydro",
        label = "Hydraulica",
        modType = 21,
        toggle = true,
        value = IsToggleModOn(veh, 21) == 1,
      },
    },
    {
      {
        type = "select",
        name = "horn",
        label = "Klakson",
        modType = 14,
        value = GetVehicleMod(veh, 14) - 1,
        options = horns,
      },
      {
        type = "checkbox",
        name = "tyres-drift",
        label = "Driftujące Koła",
        value = driftTyres,
      },

      {
        type = "checkbox",
        name = "tyres-proof",
        label = "Kuloodporne Opony",
        value = not bulletProof,
      },

      {
        type = "checkbox",
        name = "xenon",
        label = "Xenony",
        modType = 22,
        toggle = true,
        value = IsToggleModOn(veh, 22) == 1,
      },
      {
        type = "checkbox",
        name = "neon-left",
        label = "Neony Lewo",
        indice = 0,
        value = IsVehicleNeonLightEnabled(veh, 0),
      },
      {
        type = "checkbox",
        name = "neon-right",
        label = "Neony Prawo",
        indice = 1,
        value = IsVehicleNeonLightEnabled(veh, 1),
      },
      {
        type = "checkbox",
        name = "neon-front",
        label = "Neony Przód",
        indice = 2,
        value = IsVehicleNeonLightEnabled(veh, 2),
      },
      {
        type = "checkbox",
        name = "neon-back",
        label = "Neony Tył",
        indice = 3,
        value = IsVehicleNeonLightEnabled(veh, 3),
      },
      {
        type = "checkbox",
        name = "tyre-smoke",
        label = "Dym spod opon",
        modType = 20,
        toggle = true,
        value = IsToggleModOn(veh, 20) == 1,
      },

      {
        type = "select",
        name = "tints",
        label = "Szyby",
        value = GetVehicleWindowTint(veh),
        options = windowTints,
      },
    },
    {
      {
        type = "color",
        name = "color-main",
        label = "Kolor główny (CUSTOM)",
        value = primaryColor,
      },
      {
        type = "color",
        name = "color-second",
        label = "Kolor drugi (CUSTOM)",
        value = secondaryColor,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Normalny",
        paintType = 0,
        value = paintType == 0 and color,
        options = normalColors,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Metaliczny",
        paintType = 1,
        value = paintType == 1 and color,
        options = metalicColors,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Perła",
        paintType = 2,
        value = paintType == 2 and color,
        options = pearlColors,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Mat",
        paintType = 3,
        value = paintType == 3 and color,
        options = matteColors,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Metal",
        paintType = 4,
        value = paintType == 4 and color,
        options = metalColors,
      },
      {
        type = "select",
        name = "color-mod",
        label = "Kolor Główny Chromowany",
        paintType = 5,
        value = paintType == 5 and color,
        options = chromeColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Normalny",
        paintType = 0,
        value = paintType2 == 0 and color2,
        options = normalColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Metaliczny",
        paintType = 1,
        value = paintType2 == 1 and color2,
        options = metalicColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Perła",
        paintType = 3 - 1,
        value = paintType2 == 2 and color2,
        options = pearlColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Mat",
        paintType = 3,
        value = paintType2 == 3 and color2,
        options = matteColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Metal",
        paintType = 4,
        value = paintType2 == 4 and color2,
        options = metalColors,
      },
      {
        type = "select",
        name = "color-mod-2",
        label = "Kolor Drugi Chromowany",
        paintType = 5,
        value = paintType2 == 5 and color2,
        options = chromeColors,
      },
      {
        type = "color",
        name = "xenon-color",
        label = "Kolor Xenonów (CUSTOM)",
        value = hasXenon and xenonColor,
      },
      {
        type = "select",
        name = "xenon-color-mod",
        label = "Kolor Xenonów",
        value = xenonColorMod + 2,
        options = xenonColors,
      },
      {
        type = "color",
        name = "neon-color",
        label = "Kolor Neonów (CUSTOM)",
        value = neonColor,
      },
      {
        type = "select",
        name = "dashboard-color",
        label = "Kolor Panelu (środek)",
        value = dashboardColor,
        options = Config.Mechanic.ColorsFixed,
      },
      {
        type = "color",
        name = "tyre-smoke-color",
        label = "Kolor Dymu Spod Opon (CUSTOM)",
        value = tyreSmokeColor,
      },
      {
        type = "select",
        name = "interior-color",
        label = "Kolor Interioru (środek)",
        value = interiorColor,
        options = Config.Mechanic.ColorsFixed,
      },
      {
        type = "select",
        name = "extra-color-pearl",
        label = "Extra Kolor Perła",
        value = pearlescentColorExtra,
        options = Config.Mechanic.ColorsFixed,
      },
      {
        type = "select",
        name = "extra-color-wheel",
        label = "Extra Kolor Koła",
        value = wheelColorExtra,
        options = Config.Mechanic.ColorsFixed,
      },
      {
        type = "select",
        name = "plate-index",
        label = "Kolor Tablicy",
        value = plateIndex - 1,
        options = Config.Mechanic.Plates,
      },
    },
    {
      {
        type = "select",
        name = "wheel-type",
        label = "Typ Koła",
        value = wheelType,
        options = Config.Mechanic.WheelTypes,
      },
      {
        type = "select",
        name = "wheel-mod",
        label = "Koła",
        value = GetVehicleMod(veh, 23),
        modType = 23,
        options = wheelMods,
      },
    },
    {
      {
        type = "select",
        name = "spoiler",
        label = "Spoiler",
        value = GetVehicleMod(veh, 0),
        modType = 0,
        options = spoilerMods,
      },
      {
        type = "select",
        name = "front-bumper",
        label = "Przedni Bumper",
        modType = 1,
        value = GetVehicleMod(veh, 1),
        options = frontBumperMods,
      },

      {
        type = "select",
        name = "rear-bumper",
        label = "Tylni Bumper",
        modType = 2,
        value = GetVehicleMod(veh, 2),
        options = rearBumperMods,
      },
      {
        type = "select",
        name = "side-skirt",
        label = "Boczne brzegi",
        modType = 3,
        value = GetVehicleMod(veh, 3),
        options = sideSkirtMods,
      },
      {
        type = "select",
        name = "exhaust",
        label = "Wydech",
        modType = 4,
        value = GetVehicleMod(veh, 4),
        options = exhaustMods,
      },
      {
        type = "select",
        name = "frame",
        label = "Klatka",
        modType = 5,
        value = GetVehicleMod(veh, 5),
        options = frameMods,
      },
      {
        type = "select",
        name = "grill",
        label = "Grill",
        modType = 6,
        value = GetVehicleMod(veh, 6),
        options = grillMods,
      },

      {
        type = "select",
        name = "hood",
        label = "Maska",
        modType = 7,
        value = GetVehicleMod(veh, 7),
        options = hoodMods,
      },
      {
        type = "select",
        name = "fender-left",
        label = "Błotnik Lewy",
        modType = 8,
        value = GetVehicleMod(veh, 8),
        options = fenderLeftMods,
      },
      {
        type = "select",
        name = "fender-right",
        label = "Błotnik Prawy",
        modType = 9,
        value = GetVehicleMod(veh, 9),
        options = fenderRightMods,
      },
      {
        type = "select",
        name = "roof",
        label = "Dach",
        modType = 10,
        value = GetVehicleMod(veh, 10),
        options = roofMods,
      },
      {
        type = "select",
        name = "plate-holders",
        label = "Blachy",
        modType = 25,
        value = GetVehicleMod(veh, 25),
        options = plateHoldersMods,
      },
      {
        type = "select",
        name = "plate-vanity",
        label = "Blachy 2",
        modType = 26,
        value = GetVehicleMod(veh, 26),
        options = plateVanityMods,
      },
      {
        type = "select",
        name = "trim-desings",
        label = "Interior I",
        modType = 27,
        value = GetVehicleMod(veh, 27),
        options = trimDesignsMods,
      },
      {
        type = "select",
        name = "trim-desings-2",
        label = "Interior 2",
        modType = 28,
        value = GetVehicleMod(veh, 28),
        options = trimDesigns2Mods,
      },
      {
        type = "select",
        name = "trim-desings-3",
        label = "Interior 3",
        modType = 29,
        value = GetVehicleMod(veh, 29),
        options = trimDesigns3Mods,
      },
      {
        type = "select",
        name = "trim-desings-4",
        label = "Interior 4",
        modType = 30,
        value = GetVehicleMod(veh, 30),
        options = trimDesigns4Mods,
      },

      {
        type = "select",
        name = "trim-desings-5",
        label = "Interior 5",
        modType = 31,
        value = GetVehicleMod(veh, 31),
        options = trimDesigns5Mods,
      },
      {
        type = "select",
        name = "seats",
        label = "Siedzenia",
        modType = 32,
        value = GetVehicleMod(veh, 32),
        options = seatsMods,
      },
      {
        type = "select",
        name = "steering",
        label = "Kierwonica",
        modType = 33,
        value = GetVehicleMod(veh, 33),
        options = steeringMods,
      },
      {
        type = "select",
        name = "shift-levels",
        label = "Skrzynia Biegów",
        modType = 34,
        value = GetVehicleMod(veh, 34),
        options = shiftLevelMods,
      },
      {
        type = "select",
        name = "plaque",
        label = "Plakieta",
        modType = 35,
        value = GetVehicleMod(veh, 35),
        options = plaqueMods,
      },
      {
        type = "select",
        name = "ice",
        label = "Lód",
        modType = 36,
        value = GetVehicleMod(veh, 36),
        options = iceMods,
      },
      {
        type = "select",
        name = "trunk",
        label = "Bagażnik",
        modType = 37,
        value = GetVehicleMod(veh, 37),
        options = trunkMods,
      },
      {
        type = "select",
        name = "hydro",
        label = "Hydraulics",
        modType = 38,
        value = GetVehicleMod(veh, 38),
        options = hydroMods,
      },
      {
        type = "select",
        name = "engine-bay",
        label = "Komora Silnika",
        modType = 39,
        value = GetVehicleMod(veh, 39),
        options = engineBayMods,
      },
      {
        type = "select",
        name = "engine-bay-2",
        label = "Komora Silnika 2",
        modType = 40,
        value = GetVehicleMod(veh, 40),
        options = engineBay2Mods,
      },
      {
        type = "select",
        name = "engine-bay-3",
        label = "Komora Silnika 3",
        value = GetVehicleMod(veh, 41),
        modType = 41,
        options = engineBay3Mods,
      },
      {
        type = "select",
        name = "chasis-2",
        label = "Podwozie 2",
        modType = 42,
        value = GetVehicleMod(veh, 42),
        options = chasis2Mods,
      },
      {
        type = "select",
        name = "chasis-3",
        label = "Podwozie 3",
        modType = 43,
        value = GetVehicleMod(veh, 43),
        options = chasis3Mods,
      },
      {
        type = "select",
        name = "chasis-4",
        label = "Podwozie 4",
        modType = 44,
        value = GetVehicleMod(veh, 44),
        options = chasis4Mods,
      },

      {
        type = "select",
        name = "chasis-5",
        label = "Podwozie 5",
        modType = 45,
        value = GetVehicleMod(veh, 45),
        options = chasis5Mods,
      },
      {
        type = "select",
        name = "door-left",
        label = "Drzwi Lewo",
        modType = 46,
        value = GetVehicleMod(veh, 46),
        options = doorLeftMods,
      },

      {
        type = "select",
        name = "door-right",
        label = "Drzwi Prawo",
        modType = 47,
        value = GetVehicleMod(veh, 47),
        options = doorRightMods,
      },
      {
        type = "select",
        name = "livery",
        label = "Naklejki ",
        modType = 48,
        value = GetVehicleMod(veh, 48),
        options = liveryMods,
      },
      {
        type = "select",
        name = "light-bar",
        label = "Światło",
        modType = 49,
        value = GetVehicleMod(veh, 49),
        options = lightBarMods,
      },
    },
    {
      {
        type = "select",
        name = "liveries",
        label = "Livery",
        value = GetVehicleLivery(veh),
        options = liveries,
      },
      {
        type = "select",
        name = "liveries-roof",
        label = "Livery Dach",
        value = GetVehicleRoofLivery(veh),
        options = roofLiveries,
      },
    },
    uknownMods,
    {
      {
        type = "select",
        name = "modkits",
        label = "Modkit (USTAWIENIE TEGO WYKASUJE WSZYSTKIE MODY)",
        value = GetVehicleModKit(veh),
        options = modKits,
      },
    },
    -- {
    --     {
    --         type = 'number',
    --         name = 'turbo-pressure',
    --         label = 'Turbo Pressure',
    --         value = GetVehicleTurboPressure(veh),
    --     },
    --     {
    --         type = 'number',
    --         name = 'suspension-height',
    --         label = 'Suspension Height',
    --         value = GetVehicleSuspensionHeight(veh),
    --         max = 2.0
    --     },
    --     -- {
    --     --     type = 'number',
    --     --     name = 'wheel-size',
    --     --     label = 'Wielkość kół (tylko na nie domyślne ?, uzywac dodatkowo SetVehicleWheelTireColliderSize, aby zmienic kolizje)',
    --     --     value = GetVehicleWheelSize(veh),
    --     -- },
    --     {
    --         type = 'number',
    --         name = 'wheel-width',
    --         label = 'Szerokość kół (tylko na nie domyślne ?, uzywac dodatkowo SetVehicleWheelTireColliderWidth, aby zmienic kolizje)',
    --         value = GetVehicleWheelWidth(veh)+0.0,
    --     },
    --     table.unpack(getWheelsTractionVectorLength(veh)),
    --     table.unpack(getWheelsRotSpeed(veh)),
    --     table.unpack(getPoweredWheels(veh)),
    --     table.unpack(getWheelsPower(veh))
    -- },
  }

  local removeThis = {}

  for i = 1, #pages do
    for n = 1, #pages[i] do
      if pages[i][n].options and #pages[i][n].options <= 1 then
        table.insert(removeThis, { i, n })
      end
    end
  end

  for i = #removeThis, 1, -1 do
    table.remove(pages[removeThis[i][1]], removeThis[i][2])
  end

  for i = #pages, 1, -1 do
    if #pages[i] <= 0 then
      table.remove(pages, i)
      table.remove(pageLabels, i)
    end
  end

  UI:Open("MenuSide", {
    log = true,
    show = true,
    name = "x d",
    title = "x d",
    pages = pages,
    pageLabels = pageLabels,
    side = "right",
    main = 0,
    messages = {
      {
        type = "info",
        label = "Aktualna Cena",
        content = 0,
      },
    },
    -- -- elements = {
    -- --     pages = {
    -- --         {
    -- --             type = 'select',
    -- --             name = 'engine',
    -- --             label = 'Silnik',
    -- --             options = {
    -- --                 {
    -- --                     label = 'Poziom I',
    -- --                     value = 'level 1'
    -- --                 }
    -- --             }
    -- --         },
    -- --         {
    -- --             type = 'color',
    -- --             name = 'outside',
    -- --             label = 'Kolory'
    -- --         },
    -- --         {
    -- --             type = 'checkbox',
    -- --             name = 'xenon',
    -- --             label = 'xenony',
    -- --             checked = true
    -- --         }
    -- --     }
    -- -- }
  }, function(data, menu)
    local message = menu.data.messages[1]
    local price = tonumber(message.content)
    local msgs = Event:TriggerCbSync("dwb:mechanic:buy", price)
    if msgs then
      menu.close()
      -- else
      --     local tune = Vehicle:SetProperties2(veh, vehProp)
    end
  end, function(data, menu)
    menu.close()
    local tune = Vehicle:SetProperties(veh, vehProp)
  end, function(data, menu)
    local message = menu.data.messages[1]
    local price = tonumber(message.content)

    local el = data.current

    local removeThis = {
      ["horn"] = true,
      ["tints"] = true,
      ["wheel-type"] = true,
      ["color-main"] = true,
      ["color-second"] = true,
      ["color-mod"] = true,
      ["color-mod-2"] = true,
      ["xenon-color"] = true,
      ["dashboard-color"] = true,
      ["interior-color"] = true,
      ["extra-color-pearl"] = true,
      ["extra-color-wheel"] = true,
      ["plate-index"] = true,
      ["liveries"] = true,
      ["liveries-roof"] = true,
      ["wheel-mod"] = true,
    }

    if el.type == "checkbox" then
      if el.value ~= el.firstValue then
        price = price + (el.price or 100)
      else
        price = price - (el.price or 100)
      end
    elseif el.type == "color" then
      if el.change == "new" then
        price = price + (el.price or 100)
      elseif el.change == "back" then
        price = price - (el.price or 100)
      end
    elseif el.type == "select" and not removeThis[el.name] then
      local level = math.abs(el.lastIndexValue - el.indexValue)
      local newPrice = (el.price or 100) * level
      if el.change == "new" then
        price = price + newPrice
      elseif el.change == "back" then
        price = price - newPrice
      elseif el.change == "same" then
        if el.lastIndexValue < el.indexValue then
          price = price + newPrice
        elseif el.lastIndexValue > el.indexValue then
          price = price - newPrice
        end
      end
    elseif el.type == "select" and removeThis[el.name] then
      if el.change == "new" then
        price = price + (el.price or 100)
      elseif el.change == "back" then
        price = price - (el.price or 100)
      end
    end

    message.content = price
    menu.updateMessage(0, message)
    if data.current.modType then
      if not data.current.toggle then
        SetVehicleMod(veh, data.current.modType, data.current.value.index)
      else
        ToggleVehicleMod(
          veh --[[ Vehicle ]],
          data.current.modType --[[ integer ]],
          data.current.value --[[ boolean ]]
        )
      end
    elseif data.current.name == "tyres-drift" then
      SetDriftTyresEnabled(veh, data.current.value)
    elseif data.current.name == "tyres-proof" then
      SetVehicleTyresCanBurst(veh, not data.current.value)
    elseif
      data.current.name == "neon-right"
      or data.current.name == "neon-left"
      or data.current.name == "neon-front"
      or data.current.name == "neon-back"
    then
      SetVehicleNeonLightEnabled(veh, data.current.indice, data.current.value)
    elseif data.current.name == "tints" then
      SetVehicleWindowTint(veh, data.current.value.tint)
    elseif data.current.name == "color-main" then
      local r, g, b = data.current.value.r, data.current.value.g, data.current.value.b
      SetVehicleCustomPrimaryColour(veh, r, g, b)
    elseif data.current.name == "color-second" then
      local r, g, b = data.current.value.r, data.current.value.g, data.current.value.b
      SetVehicleCustomSecondaryColour(veh, r, g, b)
    elseif data.current.name == "color-mod" then
      ClearVehicleCustomPrimaryColour(veh)
      SetVehicleModColor_1(veh, data.current.paintType, data.current.value.color)
    elseif data.current.name == "color-mod-2" then
      ClearVehicleCustomSecondaryColour(veh)
      SetVehicleModColor_2(
        veh --[[ Vehicle ]],
        data.current.paintType --[[ integer ]],
        data.current.value.color --[[ integer ]]
      )
    elseif data.current.name == "xenon-color" then
      local r, g, b = data.current.value.r, data.current.value.g, data.current.value.b
      SetVehicleXenonLightsCustomColor(veh --[[ Vehicle ]], r, g, b)
    elseif data.current.name == "xenon-color-mod" then
      ClearVehicleXenonLightsCustomColor(veh)
      SetVehicleXenonLightsColor(veh, data.current.value.color)
    elseif data.current.name == "neon-color" then
      local r, g, b = data.current.value.r, data.current.value.g, data.current.value.b
      SetVehicleNeonLightsColour(veh --[[ Vehicle ]], r, g, b)
    elseif data.current.name == "dashboard-color" then
      SetVehicleDashboardColor(veh --[[ Vehicle ]], data.current.value.color --[[ integer ]])
    elseif data.current.name == "tyre-smoke-color" then
      local r, g, b = data.current.value.r, data.current.value.g, data.current.value.b
      SetVehicleTyreSmokeColor(veh --[[ Vehicle ]], r, g, b)
    elseif data.current.name == "interior-color" then
      SetVehicleInteriorColor(veh, data.current.value.color)
    elseif data.current.name == "extra-color-pearl" then
      local pearlescentColorExtra, --[[ integer ]]
        wheelColorExtra --[[ integer ]] =
        GetVehicleExtraColours(veh --[[ Vehicle ]])

      SetVehicleExtraColours(veh, data.current.value.color, wheelColorExtra)
    elseif data.current.name == "extra-color-wheel" then
      local pearlescentColorExtra, --[[ integer ]]
        wheelColorExtra --[[ integer ]] =
        GetVehicleExtraColours(veh --[[ Vehicle ]])
      SetVehicleExtraColours(veh, pearlescentColor, data.current.value.color)
    elseif data.current.name == "plate-index" then
      SetVehicleNumberPlateTextIndex(veh, data.current.value.index)
    elseif data.current.name == "wheel-type" then
      SetVehicleWheelType(veh, data.current.value.wheelType)
      local wheelMods = {}

      local wheelModsNum = GetNumVehicleMods(veh, 23) - 1

      table.insert(wheelMods, {
        label = "Stock",
        index = -1,
      })

      for i = 0, wheelModsNum do
        local label = "Koła " .. i
        local labelName = GetModTextLabel(veh, 23, i)
        if labelName then
          label = GetLabelText(labelName)
        end
        table.insert(wheelMods, {
          label = label,
          index = i,
        })
      end

      menu.updatePageElement(3, 1, {
        options = wheelMods,
        value = GetVehicleMod(veh, 23),
      })
    elseif data.current.name == "liveries" then
      SetVehicleLivery(veh, data.current.value.livery)
    elseif data.current.name == "liveries-roof" then
      SetVehicleRoofLivery(veh, data.current.value.livery)
    elseif data.current.name == "modkits" then
      -- SetVehicleModKit(veh, data.current.value.modkit)
    elseif data.current.name == "extras" then
      SetVehicleExtra(veh, data.current.extras, data.current.value and 0 or 1)
    elseif data.current.name == "turbo-pressure" then
      local value = tonumber(string.format("%.1f", data.current.value))
      SetVehicleTurboPressure(veh, value)
    elseif data.current.name == "suspension-height" then
      local value = tonumber(string.format("%.1f", data.current.value))
      SetVehicleSuspensionHeight(veh, value)
    elseif data.current.name == "wheel-size" then
      local value = tonumber(string.format("%.1f", data.current.value))
      setColliderSize(veh, value)

      SetVehicleWheelSize(veh, value)
    elseif data.current.name == "wheel-width" then
      local value = tonumber(string.format("%.1f", data.current.value))
      setColliderWidth(veh, value)
      SetVehicleWheelWidth(veh, value)
    elseif data.current.name == "wheel-traction-vector" then
      local value = tonumber(string.format("%.1f", data.current.value))
      SetVehicleWheelTractionVectorLength(veh, data.current.wheel, value)
    elseif data.current.name == "wheel-rot-speed" then
      local value = tonumber(string.format("%.1f", data.current.value))
      SetVehicleWheelRotationSpeed(veh, data.current.wheel, value)
    elseif data.current.name == "wheel-powered" then
      SetVehicleWheelIsPowered(veh, data.current.wheel, data.current.value)
    elseif data.current.name == "wheel-power" then
      local value = tonumber(string.format("%.1f", data.current.value))
      SetVehicleWheelPower(veh, data.current.wheel, value)
    end
  end)
end

Event:Register("dwb:mechanic:open", function(action, entityId, data, entData)
  generateMenu()
end, true)

Event:Register("dwb:mechanic:wash", function(price, time)
  local veh = GetVehiclePedIsIn(PlayerPedId(), false)
  if veh then
    FreezeEntityPosition(veh, true)
    UI:Open("Bar", {
      name = "mechanic",
      time = time,
      show = true,
      task = "Myjesz pojazd",
    }, function(data, menu)
      menu.close()
      Event:TriggerNet("dwb:mechanic:not:busy")
      SetVehicleDirtLevel(veh, 0.0)
      SetVehicleDoorsLocked(veh, 1)
      FreezeEntityPosition(veh, false)
    end)
  end
end, true)

Event:Register("dwb:mechanic:fix", function(time, price)
  local veh = GetVehiclePedIsIn(PlayerPedId(), false)

  if veh then
    FreezeEntityPosition(veh, true)
    UI:Open("Bar", {
      name = "mechanic",
      time = price,
      show = true,
      task = "Naprawiasz pojazd",
      forceOpen = true,
      forceClose = true,
    }, function(data, menu)
      menu.close()

      SetVehicleDoorShut(veh, 4, 0)

      Event:TriggerNet("dwb:mechanic:not:busy")
      SetVehicleFixed(veh)
      SetVehicleDeformationFixed(veh)
      SetVehicleUndriveable(veh, false)
      SetVehicleEngineOn(veh, true, true)
      SetVehicleDoorsLocked(veh, 1)
      FreezeEntityPosition(veh, false)
      Event:TriggerNet("dwb:mechanic:remove:item")
    end)
  end
end, true)
