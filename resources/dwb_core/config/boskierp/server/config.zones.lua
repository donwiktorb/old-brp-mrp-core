--- Config
-- template
---@not_luadoc=true
-- @module Config.Zones.boskierp

--- Zone Template
-- Zone template
-- @table zone
-- @field type string Type name
-- @field name string name
-- @field settings table
-- @field marker marker Marker settings.
-- @see Config.Default.Zone
-- @field coords table<table, table> Coords
-- @field data table Data
-- @field label string Label
-- @field blip table Blip
-- @field messages table Messages

--- Config.Zones.boskierp
-- Default template for a zone
-- @table Config.Zones.boskierp
-- @field zone zone Zone zone including type, scale, and color.
-- @usage
-- Config.Zones["boskierp"] = {}
-- @see Config
Config.Zones["boskierp"] = {
  { -- Sklepy
    type = "shop",
    name = "shop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      --- LTDgasoline
      {
        pos = vec3(-48.519, -1757.514, 29.421),
      },
      {
        pos = vec3(1163.373, -323.801, 69.205),
      },
      {
        pos = vec3(-707.501, -914.260, 19.215),
      },
      {
        pos = vec3(-1820.523, 792.518, 138.118),
      },
      {
        pos = vec3(-1820.523, 792.518, 138.118),
      },
      {
        pos = vec3(1698.388, 4924.404, 42.063),
      },
      --- TwentyFourSeven
      {
        pos = vec3(373.875, 325.896, 103.566),
      },
      {
        pos = vec3(2557.458, 382.282, 108.622),
      },
      {
        pos = vec3(-3038.939, 585.954, 7.908),
      },
      {
        pos = vec3(-3241.927, 1001.462, 12.830),
      },
      {
        pos = vec3(547.431, 2671.710, 42.156),
      },
      {
        pos = vec3(1961.464, 3740.672, 32.343),
      },
      {
        pos = vec3(2678.916, 3280.671, 55.241),
      },
      {
        pos = vec3(25.94, -1347.71, 29.60),
      },
      {
        pos = vec3(1729.216, 6414.131, 35.037),
      },
      --- RobsLiquor
      {
        pos = vec3(1135.808, -982.281, 46.415),
      },
      {
        pos = vec3(-1222.915, -906.983, 12.326),
      },
      {
        pos = vec3(-1487.553, -379.107, 40.163),
      },
      {
        pos = vec3(-2968.243, 390.910, 15.043),
      },
      {
        pos = vec3(1166.024, 2708.930, 38.157),
      },
      {
        pos = vec3(1392.562, 3604.684, 34.980),
      },
    },
    data = {
      items = {
        {
          name = "water",
          price = 35,
          label = "Woda",
        },
        {
          name = "cola",
          price = 45,
          label = "CocaCola",
        },
        {
          name = "sprunk",
          price = 45,
          label = "Sprite",
        },
        {
          name = "bread",
          price = 35,
          label = "Chleb",
        },
        {
          name = "apple",
          price = 25,
          label = "Jabłko",
        },
        {
          name = "banana",
          price = 25,
          label = "Banan",
        },
        {
          name = "paczek",
          price = 32,
          label = "Pączek",
        },
        {
          name = "cookie",
          price = 28,
          label = "Ciastko",
        },
        {
          name = "scratchoff",
          price = 1500,
          label = "Zdrapka",
        },
        {
          name = "beer",
          price = 35,
          label = "Piwo",
        },
        {
          name = "cigarett",
          price = 3,
          label = "Papieros",
        },
      },
    },
    label = "Sklep",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Sklep",

      color = 2,
      scale = 0.9,
      sprite = 52,
      shortRange = true,
      display = 4,
    },
  },

  { -- Sklep techniczny
    type = "shop",
    name = "Technicalshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(2748.042, 3472.277, 55.6744),
      },
      {
        pos = vec3(55.38076, -1739.263, 29.5922),
      },
    },
    data = {
      items = {
        {

          name = "binoculars",
          price = 850,
          label = "Lornetka",
        },
        {
          name = "lockpick",
          price = 5500,
          label = "Wytrych",
        },
        {
          name = "fixkit",
          price = 8000,
          label = "Zestaw naprawczy",
        },
        {
          name = "graffiti",
          price = 12000,
          label = "Sprej",
        },
        {
          name = "handcuffs",
          price = 5500,
          label = "Kajdanki",
        },
        {
          name = "drone",
          price = 100000,
          label = "Dron",
        },
      },
    },
    label = "Sklep techniczny",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Sklep techniczny",

      color = 3,
      scale = 0.9,
      sprite = 52,
      shortRange = true,
      display = 4,
    },
  },

  { -- Sklep z bronia
    type = "shop",
    name = "weaponshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-662.180, -934.961, 21.829),
      },
      {
        pos = vec3(810.25, -2157.60, 29.62),
      },
      {
        pos = vec3(1693.44, 3760.16, 34.71),
      },
      {
        pos = vec3(-330.24, 6083.88, 31.45),
      },
      {
        pos = vec3(252.63, -50.00, 69.94),
      },
      {
        pos = vec3(22.09, -1107.28, 29.80),
      },
      {
        pos = vec3(2567.69, 294.38, 108.73),
      },
      {
        pos = vec3(-1117.58, 2698.61, 18.55),
      },
      {
        pos = vec3(842.44, -1033.42, 28.19),
      },
    },
    data = {
      items = {
        {
          name = "weapon_pistol",
          price = 250000,
          label = "Pistol",
          license = "short-weapon",
        },
        {
          name = "weapon_combatpistol",
          price = 350000,
          label = "Combat Pistol",
          license = "short-weapon",
        },
        {
          name = "weapon_bat",
          price = 45000,
          label = "Kij",
        },
        {
          name = "weapon_knuckle",
          price = 85000,
          label = "Kastet",
          license = "short-weapon",
        },
        {
          name = "weapon_knife",
          price = 55000,
          label = "Nóż",
          license = "short-weapon",
        },
        {
          name = "weapon_switchblade",
          price = 55000,
          label = "Scyzoryk",
          license = "short-weapon",
        },
        {
          name = "weapon_flare",
          price = 8000,
          label = "Flara",
        },
        {
          name = "pistol_ammo",
          price = 10000,
          label = "9 mm Ammo",
          license = "short-weapon",
        },
      },
    },
    label = "Ammu-Nation",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby zakupić broń.",
    },
    blip = {
      label = "Ammu-Nation",

      color = 55,
      scale = 0.9,
      sprite = 110,
      shortRange = true,
      display = 4,
    },
  },
  { -- Sklep Elektroniczny
    type = "shop",
    name = "elektronikshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-1082.2, -247.67, 37.76),
      },
    },
    data = {
      items = {
        {
          name = "phone",
          price = 190,
          label = "Telefon",
        },
        {
          name = "tablet",
          price = 1200,
          label = "Podejrzany tablet",
        },
        {
          name = "radio",
          price = 270,
          label = "Radio",
        },
        {
          name = "sim",
          price = 50,
          label = "Karta SIM",
        },
      },
    },
    label = "Sklep Elektroniczny",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Sklep Elektroniczny",

      color = 43,
      scale = 0.9,
      sprite = 459,
      shortRange = true,
      display = 4,
    },
  },
  { -- vanillaunicorn
    type = "shop",
    name = "vanillaunicorn",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(127.728, -1285.072, 29.280),
      },
    },
    data = {
      items = {
        {
          name = "shot1",
          price = 25,
          label = "Shot",
        },
        {
          name = "shot2",
          price = 25,
          label = "Shot",
        },
        {
          name = "shot3",
          price = 25,
          label = "Shot",
        },
        {
          name = "drink1",
          price = 55,
          label = "Drink",
        },
        {
          name = "drink2",
          price = 55,
          label = "Drink",
        },
        {
          name = "drink3",
          price = 55,
          label = "Drink",
        },
        {
          name = "champagne",
          price = 150,
          label = "Szampan",
        },
        {
          name = "whisky",
          price = 80,
          label = "Whisky",
        },
        {
          name = "beer",
          price = 35,
          label = "Piwo",
        },
      },
    },
    label = "Vanilla Unicorn",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Vanilla Unicorn",

      color = 8,
      scale = 0.9,
      sprite = 121,
      shortRange = true,
      display = 4,
    },
  },
  { -- vanillaunicorn
    type = "shop",
    name = "tequilala",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-560.177, 286.049, 82.176),
      },
    },
    data = {
      items = {
        {
          name = "shot1",
          price = 25,
          label = "Shot",
        },
        {
          name = "shot2",
          price = 25,
          label = "Shot",
        },
        {
          name = "shot3",
          price = 25,
          label = "Shot",
        },
        {
          name = "drink1",
          price = 55,
          label = "Drink",
        },
        {
          name = "drink2",
          price = 55,
          label = "Drink",
        },
        {
          name = "drink3",
          price = 55,
          label = "Drink",
        },
        {
          name = "champagne",
          price = 150,
          label = "Szampan",
        },
        {
          name = "whisky",
          price = 80,
          label = "Whisky",
        },
        {
          name = "beer",
          price = 35,
          label = "Piwo",
        },
      },
    },
    label = "Tequi-la-la",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Tequi-la-la",

      color = 21,
      scale = 0.9,
      sprite = 436,
      shortRange = true,
      display = 4,
    },
  },
  { --Sklep odzieżowy
    type = "clotheshop",
    name = "clothesshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(2.5, 2.5, 2.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(72.3, -1399.1, 29.4 - 0.9),
      },
      {
        pos = vec3(-703.8, -152.3, 37.4 - 0.9),
      },
      {
        pos = vec3(-167.9, -299.0, 39.7 - 0.9),
      },
      {
        pos = vec3(428.7, -800.1, 29.5 - 0.9),
      },
      {
        pos = vec3(-829.4, -1073.7, 11.3 - 0.9),
      },
      {
        pos = vec3(-1447.8, -242.5, 49.8 - 0.9),
      },
      {
        pos = vec3(11.6, 6514.2, 31.9 - 0.9),
      },
      {
        pos = vec3(123.6, -219.4, 54.6 - 0.9),
      },
      {
        pos = vec3(1696.3, 4829.3, 42.1 - 0.9),
      },
      {
        pos = vec3(618.1, 2759.6, 42.1 - 0.9),
      },
      {
        pos = vec3(1190.6, 2713.4, 38.2 - 0.9),
      },
      {
        pos = vec3(-1193.4, -772.3, 17.3 - 0.9),
      },
      {
        pos = vec3(-3172.5, 1048.1, 20.9 - 0.9),
      },
      {
        pos = vec3(-1108.4, 2708.9, 19.1 - 0.9),
      },
    },
    data = {
      price = 250,
      elements = {
        "tshirt_1",
        "tshirt_2",
        "torso_1",
        "torso_2",
        "decals_1",
        "decals_2",
        "arms",
        "arms_2",
        "pants_1",
        "pants_2",
        "shoes_1",
        "shoes_2",
        "bproof_1",
        "bproof_2",
        "chain_1",
        "chain_2",
        "glasses_1",
        "glasses_2",
        "helmet_1",
        "helmet_2",
        "watches_1",
        "watches_2",
        "bracelets_1",
        "bracelets_2",
        "bags_1",
        "bags_2",
        "pants_1",
        "pants_2",
        "pants_1",
        "pants_2",
        "ears_1",
        "ears_2",
      },
    },
    label = "Sklep odzieżowy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać ubrania. Koszt: 250$",
    },
    blip = {
      label = "Sklep odzieżowy",

      color = 47,
      scale = 0.9,
      sprite = 73,
      shortRange = true,
      display = 4,
    },
  },
  { --Sklep z maskami
    type = "clotheshop",
    name = "maskshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(2.5, 2.5, 2.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-1338.279, -1277.255, 4.885 - 0.9),
      },
    },
    data = {
      price = 150,
      elements = {
        "mask_1",
        "mask_2",
        "helmet_1",
        "helmet_2",
        "glasses_1",
        "glasses_2",
      },
    },
    label = "Sklep odzieżowy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać maski oraz nakrycia głowy. Koszt: 150$",
    },
    blip = {
      label = "Sklep z maskami",

      color = 28,
      scale = 0.9,
      sprite = 362,
      shortRange = true,
      display = 4,
    },
  },
  { -- Fryzjer
    type = "clotheshop",
    name = "barbershop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(2.5, 2.5, 2.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-814.308, -183.823, 37.568 - 0.9),
      },
      {
        pos = vec3(136.826, -1708.373, 29.291 - 0.9),
      },
      {
        pos = vec3(-1282.604, -1116.757, 6.990 - 0.9),
      },
      {
        pos = vec3(1931.513, 3729.671, 32.844 - 0.9),
      },
      {
        pos = vec3(1212.840, -472.921, 66.208 - 0.9),
      },
      {
        pos = vec3(-32.885, -152.319, 57.076 - 0.9),
      },
      {
        pos = vec3(-278.077, 6228.463, 31.695 - 0.9),
      },
    },
    data = {
      price = 250,
      elements = {
        "hair_1",
        "hair_2",
        "hair_color_1",
        "hair_color_2",
        "eye_color",
        "eyebrows_1",
        "eyebrows_2",
        "eyebrow_color_1",
        "eyebrow_color_2",
        "eyebrow_color_3",
        "eyebrow_color_3",
        "makeup_1",
        "makeup_2",
        "makeup_3",
        "makeup_4",
        "lipstick_1",
        "lipstick_2",
        "lipstick_3",
        "lipstick_4",
        "chest_1",
        "chest_2",
        "chest_3",
        "blush_1",
        "blush_2",
        "blush_3",
        "complexion_1",
        "complexion_2",
        "moles_1",
        "moles_2",
        "beard_1",
        "beard_2",
        "beard_3",
        "beard_4",
      },
    },
    label = "Fryzjer",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby sprawdzić fryzury. Koszt: 250$",
    },
    blip = {
      label = "Fryzjer",

      color = 12,
      scale = 0.9,
      sprite = 71,
      shortRange = true,
      display = 4,
    },
  },
  { -- Salon z tatuażami
    type = "tattooshop",
    name = "tattoosshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(2.5, 2.5, 2.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(1322.645, -1651.976, 52.275 - 0.9),
      },
      {
        pos = vec3(-1153.676, -1425.68, 4.954 - 0.9),
      },
      {
        pos = vec3(322.139, 180.467, 103.587 - 0.9),
      },
      {
        pos = vec3(-3170.071, 1075.059, 20.829 - 0.9),
      },
      {
        pos = vec3(1864.633, 3747.738, 33.032 - 0.9),
      },
      {
        pos = vec3(-293.713, 6200.04, 31.487 - 0.9),
      },
    },
    data = {
      price = 250,
    },
    label = "Salon z tatuażami",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać tatuaże. Koszt: 250$",
    },
    blip = {
      label = "Salon z tatuażami",

      color = 1,
      scale = 0.9,
      sprite = 75,
      shortRange = true,
      display = 4,
    },
  },
  { -- Sprzedawca Aut
    type = "vehicleshop",
    name = "vehicleshop",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-33.7, -1102.0, 26.4),
        data = {
          spawns = {
            {
              pos = vec3(-47.062, -1077.490, 26.999),
              heading = 69.0,
            },
          },
          coords = vec3(-45.891, -1097.590, 25.3),
          heading = 319.0,
        },
      },
    },
    data = {},
    label = "Dealer samochodowy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać pojazdy.",
    },
    blip = {
      label = "Dealer samochodowy",

      color = 0,
      scale = 0.9,
      sprite = 523,
      shortRange = true,
      display = 4,
    },

    keepUI = true,
  },
  { -- darkshop
    type = "shop",
    name = "darkshop",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-110.951, 2810.392, 53.158),
      },
    },
    data = {
      blackMoney = true,
      items = {
        {
          name = "weapon_pistol",
          price = 350000,
          label = "Pistol",
        },
        {
          name = "weapon_combatpistol",
          price = 350000,
          label = "Combat Pistol",
        },
        {
          name = "weapon_vintagepistol",
          price = 450000,
          label = "Vintage Pistol",
        },
        {
          name = "weapon_snspistol",
          price = 430000,
          label = "SNS Pistol",
        },
        {
          name = "weapon_pistol_mk2",
          price = 550000,
          label = "Pistol Mk II",
        },
        {
          name = "weapon_snspistol_mk2",
          price = 450000,
          label = "SNS Pistol Mk II",
        },
        {
          name = "pistol_ammo",
          price = 12000,
          label = "9 mm Ammo",
        },
      },
    },
    label = "DarkShop",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać oferty.",
    },
  },
  { -- darkshop2
    type = "shop",
    name = "darkshop2",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(1320.764, 4314.474, 38.143),
      },
    },
    data = {
      blackMoney = true,
      items = {
        {
          name = "weapon_dagger",
          price = 50000,
          label = "Sztylet",
        },
        {
          name = "weapon_switchblade",
          price = 50000,
          label = "Scyzoryk",
        },
        {
          name = "weapon_knife",
          price = 50000,
          label = "Nóż",
        },
        {
          name = "weapon_battleaxe",
          price = 75000,
          label = "Topór",
        },
        {
          name = "weapon_knuckle",
          price = 35000,
          label = "Kastet",
        },
        {
          name = "weapon_bat",
          price = 15000,
          label = "Kij",
        },
      },
    },
    label = "DarkShop",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać oferty.",
    },
  },
  { -- darkshop3
    type = "shop",
    name = "darkshop3",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-169.369, 6144.650, 42.637),
      },
    },
    data = {
      blackMoney = true,
      items = {
        {
          name = "bulletproof",
          price = 65000,
          label = "Kamizelka kuloodporna",
        },
        {
          name = "drill",
          price = 12000,
          label = "Wiertnica",
        },
        {
          name = "cash",
          price = 4,
          label = "Czysta Gotówka",
        },
      },
    },
    label = "DarkShop",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać oferty.",
    },
  },
  { -- darkshop4
    type = "shop",
    name = "darkshop4",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(2100.985, 2342.350, 94.285),
      },
    },
    data = {
      blackMoney = true,
      items = {
        {
          name = "suppresor",
          price = 80000,
          label = "Tłumik do pistoletu",
        },
        {
          name = "flashlight",
          price = 30000,
          label = "Latarka do pistoletu",
        },
        {
          name = "extclip",
          price = 95000,
          label = "Powiększony magazynek do pistoletu",
        },
      },
    },
    label = "DarkShop",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przeglądać oferty.",
    },
  },
  { -- dmvschool
    type = "dmvschool",
    name = "dmvschool",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(216.195, -1389.567, 30.587),
      },
    },
    data = {
      {
        label = "Kat. A",
        value = "driving_a",
        price = 3000,
      },
      {
        label = "Kat. B",
        value = "driving_b",
        price = 5000,
      },
      {
        label = "Kat. C",
        value = "driving_c",
        price = 9000,
      },
    },
    label = "Szkoła jazdy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby rozpaczać kurs.",
    },
    blip = {
      label = "Szkoła jazdy",

      color = 0,
      scale = 0.9,
      sprite = 351,
      shortRange = true,
      display = 4,
    },
  },
  { -- autorepair
    type = "autorepair",
    name = "autorepair",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(1.5, 1.5, 1.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-1154.929, -2005.973, 13.180 - 0.9),
        data = {
          price = 600,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 600$",
        },
      },
      {
        pos = vec3(731.483, -1088.871, 22.169 - 0.9),
        data = {
          price = 7500,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 750$",
        },
      },
      {
        pos = vec3(-338.749, -136.733, 39.009 - 0.9),
        data = {
          price = 800,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 800$",
        },
      },
      {
        pos = vec3(1175.127, 2639.821, 37.753 - 0.9),
        data = {
          price = 350,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 350$",
        },
      },
      {
        pos = vec3(110.783, 6626.823, 31.787 - 0.9),
        data = {
          price = 300,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 300$",
        },
      },
      {
        pos = vec3(534.701, -185.099, 54.226 - 0.85),
        data = {
          price = 890,
          time = 10,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby naprawić pojazd. Koszt: 890$",
        },
      },
    },

    label = "Auto naprawa",
    blip = {
      label = "Auto naprawa",

      color = 5,
      scale = 0.6,
      sprite = 446,
      shortRange = true,
      display = 4,
    },
  },

  { -- wash
    type = "wash",
    name = "wash",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 27,
      scale = vec3(1.5, 1.5, 1.5),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(29.122, -1391.974, 29.362 - 0.9),
        data = {
          price = 600,
          time = 5,
        },
      },
      {
        pos = vec3(-669.814, -933.139, 19.013 - 0.9),
        data = {
          price = 600,
          time = 5,
        },
      },
    },
    label = "Myjnia samochodowa",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby umyć pojazd.",
    },
    blip = {
      label = "Myjnia samochodowa",

      color = 0,
      scale = 0.9,
      sprite = 100,
      shortRange = true,
      display = 4,
    },
  },

  { -- bank
    type = "bank",
    name = "bank",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(150.266, -1040.203, 29.374),
      },
      {
        pos = vec3(-1212.980, -330.841, 37.787),
      },
      {
        pos = vec3(-2962.997, 483.013, 15.703),
      },
      {
        pos = vec3(-112.202, 6469.295, 31.626),
      },
      {
        pos = vec3(314.187, -278.621, 54.170),
      },
      {
        pos = vec3(-351.534, -49.529, 49.042),
      },
      {
        pos = vec3(247.163, 222.710, 106.286),
      },
      {
        pos = vec3(1175.064, 2706.643, 38.094),
      },
    },
    label = "Bank",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby otworzyć konto.",
    },
    blip = {
      label = "Bank",

      color = 2,
      scale = 0.9,
      sprite = 207,
      shortRange = true,
      display = 4,
    },
  },
  { -- garages
    type = "garages",
    name = "garages",
    secondClick = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 36,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 222,
        g = 222,
        b = 222,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(1712.571411, 3770.373535, 34.368530),
        data = {
          coords = {
            {
              spawnCoords = vec3(1708.114, 3763.226, 33.778),
              heading = 317.480,
            },
            {
              spawnCoords = vec3(1705.160, 3766.035, 33.879),
              heading = 317.480,
            },
          },
        },
      },
      {
        pos = vec3(327.824, -204.501, 54.082),
        data = {
          coords = {
            {
              spawnCoords = vec3(318.329, -203.551, 53.577),
              heading = 249.448,
            },
            {
              spawnCoords = vec3(316.984, -206.597, 53.577),
              heading = 249.448,
            },
            {
              spawnCoords = vec3(315.718, -209.802, 53.577),
              heading = 249.448,
            },
          },
        },
      },
      {
        pos = vec3(-1048.852, -2657.723, 13.828),
        data = {
          coords = {
            {
              spawnCoords = vec3(-1046.914, -2651.353, 13.323),
              heading = 147.401,
            },
            {
              spawnCoords = vec3(-1043.960, -2653.054, 13.323),
              heading = 147.401,
            },
            {
              spawnCoords = vec3(-1041.151, -2654.756, 13.323),
              heading = 147.401,
            },
          },
        },
      },
      {
        pos = vec3(-1647.9, -915.85, 7.49 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-1644.276, -911.512, 8.082),
              heading = 138.897,
            },
            {
              spawnCoords = vec3(-1646.637, -909.481, 8.082),
              heading = 138.897,
            },
            {
              spawnCoords = vec3(-1641.969, -913.608, 8.082),
              heading = 138.897,
            },
          },
        },
      },
      {
        pos = vec3(-3043.91, 119.9, 10.61 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-3047.525, 114.685, 11.065),
              heading = 317.480,
            },
            {
              spawnCoords = vec3(-3044.835, 112.285, 11.065),
              heading = 317.480,
            },
            {
              spawnCoords = vec3(-3042.013, 109.925, 11.065),
              heading = 317.480,
            },
          },
        },
      },
      {
        pos = vec3(-2221.226, 4240.035, 46.972 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-2219.010, 4234.852, 46.753),
              heading = 36.850,
            },
            {
              spawnCoords = vec3(-2221.305, 4232.979, 46.618),
              heading = 36.850,
            },
            {
              spawnCoords = vec3(-2223.969, 4230.909, 46.517),
              heading = 36.850,
            },
          },
        },
      },
      {
        pos = vec3(417.6317, -1283.484, 29.26882 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(412.760, -1284.909, 29.768),
              heading = 323.149,
            },
            {
              spawnCoords = vec3(416.545, -1287.876, 29.768),
              heading = 323.149,
            },
            {
              spawnCoords = vec3(420.000, -1290.830, 29.751),
              heading = 323.149,
            },
          },
        },
      },
      {
        pos = vec3(1875.542, 2618.43, 44.67207 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(1877.314, 2622.158, 45.169),
              heading = 272.125,
            },
            {
              spawnCoords = vec3(1877.287, 2625.626, 45.169),
              heading = 272.125,
            },
            {
              spawnCoords = vec3(1877.235, 2629.081, 45.169),
              heading = 272.125,
            },
          },
        },
      },
      {
        pos = vec3(-270.052, 318.632, 93.241),
        data = {
          coords = {
            {
              spawnCoords = vec3(-272.070, 312.751, 92.753),
              heading = 0.0,
            },
            {
              spawnCoords = vec3(-275.512, 312.738, 92.753),
              heading = 0.0,
            },
            {
              spawnCoords = vec3(-278.927, 312.857, 92.753),
              heading = 0.0,
            },
          },
        },
      },
      {
        pos = vec3(128.8066, -1069.2, 28.19236 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(125.578, -1070.307, 28.690),
              heading = 178.582,
            },
            {
              spawnCoords = vec3(122.307, -1070.294, 28.690),
              heading = 178.582,
            },
            {
              spawnCoords = vec3(118.905, -1070.320, 28.690),
              heading = 178.582,
            },
          },
        },
      },
      {
        pos = vec3(-828.6084, -760.542, 21.03846 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-823.015, -757.134, 21.832),
              heading = 87.874,
            },
            {
              spawnCoords = vec3(-823.186, -760.668, 21.512),
              heading = 87.874,
            },
            {
              spawnCoords = vec3(-823.239, -764.347, 21.141),
              heading = 87.874,
            },
          },
        },
      },
      {
        pos = vec3(-487.559, -608.738, 30.17442 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-484.443, -615.745, 30.661),
              heading = 181.417,
            },
            {
              spawnCoords = vec3(-487.569, -615.758, 30.661),
              heading = 178.582,
            },
            {
              spawnCoords = vec3(-490.984, -615.758, 30.661),
              heading = 178.582,
            },
          },
        },
      },
      {
        pos = vec3(38.61308, -868.686, 29.47962 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(50.558, -873.547, 29.920),
              heading = 158.740,
            },
            {
              spawnCoords = vec3(47.393, -872.413, 29.937),
              heading = 158.740,
            },
            {
              spawnCoords = vec3(43.978, -871.081, 29.953),
              heading = 158.740,
            },
          },
        },
      },
      {
        pos = vec3(1230.518, -435.85, 66.73052 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(1237.964, -432.830, 67.259),
              heading = 192.755,
            },
            {
              spawnCoords = vec3(1234.602, -431.986, 67.259),
              heading = 192.755,
            },
            {
              spawnCoords = vec3(1231.147, -430.892, 67.191),
              heading = 189.921,
            },
          },
        },
      },
      {
        pos = vec3(-72.08506, 6335.254, 30.59034 + 1),
        data = {
          coords = {
            {
              spawnCoords = vec3(-71.894, 6341.775, 30.981),
              heading = 226.771,
            },
            {
              spawnCoords = vec3(-74.584, 6339.138, 30.981),
              heading = 226.771,
            },
            {
              spawnCoords = vec3(-77.459, 6336.329, 30.981),
              heading = 226.771,
            },
          },
        },
      },
      {
        pos = vec3(-803.678, -1306.213, 5.000),
        data = {
          coords = {
            {
              spawnCoords = vec3(-801.626, -1313.367, 4.493),
              heading = 350.600,
            },
            {
              spawnCoords = vec3(-804.751, -1312.734, 4.493),
              heading = 350.600,
            },
            {
              spawnCoords = vec3(-807.771, -1312.232, 4.493),
              heading = 350.600,
            },
          },
        },
      },
      {
        pos = vec3(1365.125, -578.965, 74.380),
        data = {
          coords = {
            {
              spawnCoords = vec3(1355.947, -584.723, 73.843),
              heading = 37.440,
            },
            {
              spawnCoords = vec3(1367.160, -568.396, 73.854),
              heading = 85.892,
            },
            {
              spawnCoords = vec3(1340.671, -571.279, 73.696),
              heading = 62.520,
            },
          },
        },
      },
      {
        pos = vec3(363.044, 2641.873, 44.492),
        data = {
          coords = {
            {
              spawnCoords = vec3(367.196, 2632.095, 44.130),
              heading = 29.273,
            },
            {
              spawnCoords = vec3(360.972, 2629.604, 44.129),
              heading = 31.308,
            },
            {
              spawnCoords = vec3(374.315, 2634.100, 44.129),
              heading = 30.708,
            },
          },
        },
      },
      {
        pos = vec3(-1472.601, -658.099, 29.213),
        data = {
          coords = {
            {
              spawnCoords = vec3(-1477.717, -658.164, 28.574),
              heading = 214.536,
            },
            {
              spawnCoords = vec3(-1480.550, -660.092, 28.575),
              heading = 214.439,
            },
            {
              spawnCoords = vec3(-1483.284, -662.037, 28.574),
              heading = 215.041,
            },
          },
        },
      },
    },
    label = "Garaż",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby otworzyć listę pojazdów, lub naciśnij <k>G</k>, aby wyświetlić hologram pojazdów.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować pojazd.",
    },
    blip = {
      label = "Garaż",

      color = 3,
      scale = 0.9,
      sprite = 50,
      shortRange = true,
      display = 4,
    },
  },
  { -- property enter
    type = "property-enter",
    name = "property-enter",
    onCreateCb = {

      name = "owned-property",
    },
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {},
    label = "mieszkanie",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wejść.",
    },
    blip = {
      label = "Mieszkanie",
      autoLabel = true,
      category = 143,
      color = 0,
      scale = 0.9,
      sprite = 350,
      shortRange = true,
      display = 4,
    },
    ownedBlip = {
      label = "Mieszkanie",

      color = 2,
      scale = 0.9,
      sprite = 40,
      shortRange = true,
      display = 4,
    },
    singleBlip = {
      label = "Mieszkanie własne dostępne",

      color = 5,
      scale = 0.45,
      sprite = 350,
      shortRange = true,
      display = 4,
    },
    ownedSingleBlip = {
      label = "Mieszkanie własne",

      color = 2,
      scale = 0.45,
      sprite = 40,
      shortRange = true,
      display = 4,
    },
  },
  { -- property enter
    type = "property-exit",
    name = "property-exit",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 1,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {},
    label = "mieszkanie",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wejść.",
    },
  },
  { -- property enter
    type = "property-room",
    name = "property-room",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    noBlip = true,
    coords = {},
    label = "mieszkanie",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wejść.",
    },
  },
  { -- harvest
    type = "drug-harvest",
    noBlip = true,
    name = "drug-harvest",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
      trackEnter = true,
      trackLeave = true,
    },
    marker = {
      type = 32,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(471.88, -2995.11, 6.1),
        heading = 180.0,
        data = {
          type = "weed",
          items = {
            ["weed"] = 1,
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 1,
            },
          },
        },
      },

      {
        pos = vec3(-724.89, 5822.92, 18.80),
        data = {
          type = "mefedron",
          items = {
            ["mef"] = 1,
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 1,
            },
          },
        },
      },

      {
        pos = vec3(-1179.359, 4925.346, 223.344 - 0.9),
        heading = 180.0,
        data = {
          type = "coke",
          items = {
            ["coke"] = 1,
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 2,
            },
          },
        },
      },
    },
    label = "drug-harvest",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby rozpocząć zbiory.",
    },
  },
  { --  packing
    type = "drug-packing",
    name = "drug-packing",
    noBlip = true,
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
      trackEnter = true,
      trackLeave = true,
    },
    marker = {
      type = 32,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(1501.73, 6496.43, 6.96),
        data = {
          type = "weed",
          label = "Przeróbka marihuany",
          notEnough = "Nie masz wystarczająco marihuany %s",
          exchangeItems = {
            {
              giveItem = "weed_pooch",
              removeItem = "weed",
              amountToGive = 5,
              amountToRemove = 20,
            },
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 1,
            },
          },
        },
      },
      {
        pos = vec3(1501.78, 6503.18, 6.9),
        data = {
          type = "mefedron",
          label = "Przeróbka mefedronu",
          notEnough = "Nie masz wystarczająco mefedronu %s",
          exchangeItems = {
            {
              giveItem = "mef_pooch",
              removeItem = "mef",
              amountToGive = 5,
              amountToRemove = 20,
            },
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 1,
            },
          },
        },
      },
      {
        pos = vec3(2752.507, 1510.361, 30.791 - 0.9),
        heading = 180.0,
        data = {
          type = "coke",
          label = "Przeróbka kokainy",
          notEnough = "Nie masz wystarczająco kokainy %s",
          exchangeItems = {
            {
              giveItem = "coke_pooch",
              removeItem = "coke",
              amountToGive = 5,
              amountToRemove = 20,
            },
          },
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 2,
            },
          },
        },
      },
    },
    label = "drug-packing",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby rozpocząć pakowanie.",
    },
  },
  { -- police cloakroom
    type = "cloakroom",
    name = "lspd_cloakroom",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(603.424, -8.859, 87.817),
      },
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(1838.408, 3677.169, 38.929),
      },
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 105,
        b = 168,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Szatnia",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "police", "sheriff", "fbi" },
    },
    blip = {
      label = "Szatnia",

      color = 3,
      scale = 0.6,
      sprite = 366,
      shortRange = true,
      display = 4,
    },
  },
  { -- police armory
    type = "shop",
    name = "lspd_armory",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(609.916, 1.635, 87.816),
      },
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(1840.391, 3683.366, 38.917),
      },
    },
    data = {
      items = {
        {
          name = "weapon_combatpistol",
          label = "Combat Pistol",
          license = "PD",
        },
        {
          name = "weapon_heavypistol",
          label = "Heavy Pistol",
          license = "SWAT",
        },
        {
          name = "weapon_stungun",
          label = "Taser",
          license = "PD",
        },
        {
          name = "weapon_nightstick",
          label = "Pałka PD",
          license = "PD",
        },
        {
          name = "weapon_knife",
          label = "Nóż",
          license = "PD",
        },
        {
          name = "weapon_flashlight",
          label = "Latarka",
          license = "PD",
        },
        {
          name = "weapon_flare",
          label = "Flara",
          license = "PD",
        },
        {
          name = "handcuffs",
          label = "Kajdanki",
          license = "PD",
        },
        {
          name = "binoculars",
          label = "Lornetka",
          license = "PD",
        },
        {
          name = "radio",
          label = "Radio",
          license = "PD",
        },
        {
          name = "gps",
          label = "GPS",
          license = "PD",
        },
        {
          name = "pistol_ammo",
          label = "9 mm Ammo",
          license = "PD",
        },
        {
          name = "flashlight",
          label = "Latarka do pistoletu",
          license = "PD",
        },
        {
          name = "ifak",
          label = "IFAK",
          license = "MED",
        },
        {
          name = "weapon_flashbang",
          label = "Flashbang",
          license = "SWAT",
        },
        {
          name = "shield",
          label = "Tarcza",
          license = "SWAT",
        },
      },
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 105,
        b = 168,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Zbrojownia",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby otworzyć zbrojownie.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "police", "sheriff", "fbi" },
    },
    blip = {
      label = "Zbrojownia",

      color = 3,
      scale = 0.6,
      sprite = 567,
      shortRange = true,
      display = 4,
    },
  },
  { -- vehicle
    type = "vehicle",
    name = "lspd_vehicle",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(607.714, -13.569, 70.629),
        spawns = {
          {
            coords = vec3(596.386, -16.668, 70.376),
            heading = 340.157,
          },
        },
      },
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(1855.912, 3692.518, 34.098),
        spawns = {
          {
            coords = vec3(1856.808, 3700.008, 33.542),
            heading = 212.598,
          },
        },
      },
    },
    marker = {
      type = 36,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 105,
        b = 168,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Pojazd",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wyciagnąć pojazd.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować pojazd.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "police", "sheriff", "fbi" },
    },
    blip = {
      label = "Pojazdy",

      color = 3,
      scale = 0.6,
      sprite = 225,
      shortRange = true,
      display = 4,
    },
  },
  { -- helipad ems
    type = "helipad",
    name = "lspd_helipad",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(1833.481, 3668.940, 38.917),
        spawns = {
          {
            coords = vec3(1833.481, 3668.940, 38.917),
            heading = 215.433,
          },
        },
      },
      {
        data = {
          jobs = {
            "police",
          },
        },
        pos = vec3(579.916, 12.421, 103.216),
        spawns = {
          {
            coords = vec3(579.916, 12.421, 103.216),
            heading = 0.0,
          },
        },
      },
    },
    marker = {
      type = 34,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 105,
        b = 168,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "helipad",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wyciagnąć helikopter.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować helikopter.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "police", "sheriff", "fbi" },
    },
    blip = {
      label = "Helipad",

      color = 3,
      scale = 0.6,
      sprite = 64,
      shortRange = true,
      display = 4,
    },
  },
  { -- ambulance cloakroom
    type = "cloakroom",
    name = "ems_cloakroom",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(311.444, -591.462, 43.265),
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(352.985, -1409.604, 32.504),
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(1784.505, 3652.203, 34.852),
      },
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 235,
        g = 19,
        b = 19,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Szatnia",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "ambulance" },
    },
    -- blip = {
    --     label = "#1 Szatnia",
    --
    --     color = 1,
    --     scale = 0.6,
    --     sprite = 366,
    --     shortRange = true,
    --     display = 4,
    -- },
  },
  { -- ambulance armory
    type = "shop",
    name = "ems_armory",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(315.107, -592.648, 43.265),
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(356.026, -1411.894, 32.504),
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(1789.491, 3651.025, 34.852),
      },
    },
    data = {
      items = {
        {
          name = "medbag",
          label = "Torba medyczna",
        },
        {
          name = "radio",
          label = "Radio",
        },
        {
          name = "gps",
          label = "gps",
        },
        {
          name = "binoculars",
          label = "Lornetka",
        },
        {
          name = "weapon_stungun",
          label = "Taser",
          license = "TASER",
        },
        {
          name = "hydrochloric_acid",
          label = "hydrochloric_acid",
          license = "TASER",
        },
        {
          name = "ephedrine",
          label = "Efedryna",
          license = "ephedrine",
        },
      },
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 235,
        g = 19,
        b = 19,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Magazyn",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby otworzyć szafke.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "ambulance" },
    },
    -- blip = {
    --     label = "#2 Magazyn",
    --
    --     color = 1,
    --     scale = 0.6,
    --     sprite = 567,
    --     shortRange = true,
    --     display = 4,
    -- },
  },
  { -- vehicle
    type = "vehicle",
    name = "ems_vehicle",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      --- resp aut
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(304.575, -1448.558, 29.970),
        spawns = {
          {
            coords = vec3(319.701, -1450.417, 29.566),
            heading = 229.606,
          },
        },
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(330.356, -555.692, 28.740),
        spawns = {
          {
            coords = vec3(338.043945, -548.320862, 28.504761),
            heading = 269.291,
          },
        },
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(1765.305, 3666.501, 34.250),
        spawns = {
          {
            coords = vec3(1756.443, 3666.224, 34.267),
            heading = 303.307,
          },
        },
      },
    },
    marker = {
      type = 36,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 235,
        g = 19,
        b = 19,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Pojazdy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wyciagnąć pojazd.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować pojazd.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "ambulance" },
    },
    blip = {
      label = "#3 Pojazdy",

      color = 1,
      scale = 0.6,
      sprite = 225,
      shortRange = true,
      display = 4,
    },
  },
  { -- helipad ems
    type = "helipad",
    name = "ems_helipad",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(313.305, -1465.094, 46.500),
        spawns = {
          {
            coords = vec3(313.305, -1465.094, 46.500),
            heading = 136.062,
          },
        },
      },
      {
        data = {
          jobs = {
            "ambulance",
          },
        },
        pos = vec3(352.035, -588.184, 74.150),
        spawns = {
          {
            coords = vec3(352.035, -588.184, 74.150),
            heading = 263.622,
          },
        },
      },
    },
    marker = {
      type = 34,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 235,
        g = 19,
        b = 19,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "helipad",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wyciagnąć helikopter.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować helikopter.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "ambulance" },
    },
    blip = {
      label = "#4 helipad",

      color = 1,
      scale = 0.6,
      sprite = 64,
      shortRange = true,
      display = 4,
    },
  },

  { -- local medic
    type = "local_medic",
    name = "local_medic",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        pos = vec3(308.914, -579.314, 43.265),
        price = 3000,
        data = {
          spawns = {
            {
              coords = vec3(314.133, -582.304, 44.265),
              heading = 159.516,
            },
          },
          price = 3000,
          time = 30,
          messages = {
            onEnter = "Naciśnij <k>E</k>, aby otworzyć pomoc. Koszt: 3000$",
          },
        },
        blip = {
          label = "Szpital",

          color = 1,
          scale = 0.9,
          sprite = 61,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 29,
          scale = vec3(1.0, 1.0, 1.0),
          color = {
            r = 50,
            g = 168,
            b = 82,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
      },
      {
        pos = vec3(354.755, -1397.091, 32.504),
        data = {
          spawns = {
            {
              coords = vec3(358.754, -1402.097, 33.504),
              heading = 318.0,
            },
          },
          price = 3000,
          time = 30,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby otworzyć pomoc. Koszt: 3000$",
        },
        blip = {
          label = "Szpital",

          color = 1,
          scale = 0.9,
          sprite = 61,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 29,
          scale = vec3(1.0, 1.0, 1.0),
          color = {
            r = 50,
            g = 168,
            b = 82,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
      },
      {
        pos = vec3(1767.663, 3639.893, 34.852),
        data = {
          spawns = {
            {
              coords = vec3(1741.452, 3624.801, 35.694),
              heading = 120.0,
            },
          },
          price = 1500,
          time = 30,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby otworzyć pomoc. Koszt: 1500$",
        },
        blip = {
          label = "Szpital",

          color = 1,
          scale = 0.9,
          sprite = 61,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 29,
          scale = vec3(1.0, 1.0, 1.0),
          color = {
            r = 50,
            g = 168,
            b = 82,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
      },
      {
        pos = vec3(-341.585, 3745.192, 69.970),
        data = {
          price = 5500,
          time = 30,
          blackMoney = true,
        },
        noBlip = true,
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby otworzyć pomoc. Koszt: 5500$ brudnej gotówki",
        },
        marker = {
          type = 29,
          scale = vec3(1.0, 1.0, 1.0),
          color = {
            r = 168,
            g = 50,
            b = 50,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
      },
    },
    label = "local medic",
  },
  { -- odholownik
    type = "pound",
    name = "odholownik",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        pos = vec3(409.319, -1622.973, 29.291),
        data = {
          pos = vec3(409.873, -1638.181, 28.79),
          heading = 190.55,
          price = 5500,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby odholować pojazd. Koszt: 5500$",
        },
      },
      {
        pos = vec3(-1541.404, -437.762, 35.596),
        data = {
          pos = vec3(-1525.937, -434.228, 35.061),
          heading = 211.218,
          price = 5500,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby odholować pojazd. Koszt: 5500$",
        },
      },
      {
        pos = vec3(1737.749, 3709.713, 34.137),
        data = {
          pos = vec3(1733.191, 3725.175, 33.606),
          heading = 5.031,
          price = 1500,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby odholować pojazd. Koszt: 1500$",
        },
      },
      {
        pos = vec3(106.673, 6612.474, 31.978),
        data = {
          pos = vec3(126.028, 6606.238, 31.350),
          heading = 224.734,
          price = 1500,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby odholować pojazd. Koszt: 1500$",
        },
      },
      -- {
      --     pos = vec3(2762.1740, 1333.648, 24.523),
      --     data = {
      --         pos = vec3(2756.847, 1344.524, 24.025),
      --         heading = 2.684,
      --         blackMoney = true,
      --         price = 500,
      --     },
      --     messages = {
      --         onEnter = "Naciśnij <k>E</k>, aby odholować pojazd. Koszt: 500$ brudnej gotówki"
      --     },

      -- },
    },
    marker = {
      type = 39,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 255,
        g = 154,
        b = 24,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Odholownik",
    blip = {
      label = "Odholownik",

      color = 47,
      scale = 0.9,
      sprite = 67,
      shortRange = true,
      display = 4,
    },
  },
  {
    type = "gang-zone",
    name = "gang-zone",
    marker = {
      type = 1,
      scale = vec3(300.0, 500.0, 500.0),
      color = {
        r = 255,
        g = 154,
        b = 24,
        a = 222,
      },
      animate = false,
      faceCam = false,
      animRotate = false,
      rotation = vec3(0.0, 1.0, 90.0),
    },
    settings = {
      drawDist = 505.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = false,
      trackEnter = true,
      trackLeave = true,
    },
    coords = {
      {
        name = "ballas",
        pos = vec3(51.737, -1818.825, 25.016),
        marker = {
          rectangleCheck = true,
          type = 1,
          scale = vec3(253.5, 359.0, 100.0),
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 5.0),
        },
        blip = {
          blipType = "area",
          width = 253.5,
          height = 359.0,
          label = "Ballas",
          color = 27,
          alpha = 200,
          rotation = 230.0,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
      {
        name = "vagos",
        pos = vec3(323.749, -2047.252, 20.838),
        marker = {

          rectangleCheck = true,
          type = 1,
          scale = vec3(253.5, 351.0, 100.0),
          -- scale = vec3(300.0, 500.0, 500.0),
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 90.0),
        },
        blip = {
          blipType = "area",
          width = 253.5,
          height = 351.0,
          label = "Vagos",
          color = 5,
          alpha = 200,
          rotation = 230.0,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
        attackBlip = {
          blipType = "area",
          width = 253.5,
          height = 351.0,
          label = "Vagos",
          color = 5,
          alpha = 200,
          rotation = 230.0,
          flash = true,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
      {
        name = "aztecas",
        -- pos = vec3(323.749+190, -2047.252+190, 20.838),
        pos = vec3(487.35, -1853.3, 27.25),
        marker = {
          type = 1,
          scale = vec3(253.5, 351.0, 100.0),
          rectangleCheck = true,
          -- scale = vec3(300.0, 500.0, 500.0),
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 90.0),
        },
        blip = {
          blipType = "area",
          width = 253.5,
          height = 351.0,
          label = "Los Aztecas",
          color = 53,
          alpha = 200,
          rotation = 230.0,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
      {
        name = "marabunta",
        pos = vec3(1343.419, -1623.006, 52.431),
        marker = {
          type = 1,
          rectangleCheck = true,
          scale = vec3(270.0, 450.0, 100.0),
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 90.0),
        },
        blip = {
          blipType = "area",
          width = 270.0,
          height = 450.0,
          label = "Marabunta",
          color = 3,
          alpha = 200,
          rotation = 107.0,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
      {
        pos = vec3(452.967, -1512.105, 29.279),
        marker = {
          rectangleCheck = true,
          type = 1,
          scale = vec3(207.5, 207.5, 100.0),
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 90.0),
        },
        blip = {
          blipType = "area",
          width = 207.5,
          height = 207.5,
          label = "Bloods",
          color = 49,
          alpha = 200,
          rotation = 49.0,

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
      {
        pos = vec3(-81.817, -1566.350, 31.756),
        marker = {
          type = 1,
          scale = vec3(170.5, 400.0, 500.0), -- x,y,z
          rectangleCheck = true,
          color = {
            r = 255,
            g = 154,
            b = 24,
            a = 222,
          },
          animate = false,
          faceCam = false,
          animRotate = false,
          rotation = vec3(0.0, 1.0, 146.0), -- ostatnie rotaca = heading
        },
        blip = {
          blipType = "area",
          width = 170.5, -- szerokosc blipa
          height = 469.0, -- wysokosc blipa
          label = "Grove Street",
          color = 2,
          alpha = 200,
          rotation = 320.0, -- rotacja blipa  do headingu

          -- color = 47,
          -- -- scale = 0.9,
          sprite = 30,
          shortRange = false,
          display = 4,
        },
      },
    },
    label = "Gang",
  },
  { -- rob
    type = "rob",
    name = "rob",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        pos = vec3(1736.32, 6419.47, 35.03),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "24/7. (Paleto Bay)",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1961.24, 3749.46, 32.34),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-1479.155, -374.693, 39.163),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1126.513, -980.647, 45.415),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(378.052, 332.710, 103.566),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Sklep | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-2959.290, 387.578, 14.043),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-3047.157, 585.550, 7.908),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Sklep | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(546.313, 2663.398, 42.156),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Sklep | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1168.731, 2717.978, 37.157),
        data = {
          time = 300,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1959.535, 3748.321, 32.343),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Sklep | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1395.199, 3613.307, 34.980),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | 24/7. (Sandy Shores)",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-43.016, -1749.207, 29.421),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | LTDgasoline",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1160.333, -314.220, 69.205),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | LTDgasoline",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-709.109, -904.557, 19.215),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | LTDgasoline",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-1828.491, 799.004, 138.177),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | LTDgasoline",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(1707.267, 4920.083, 42.063),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | LTDgasoline",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(28.254, -1339.459, 29.497),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-1220.003, -915.943, 11.326),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | RobsLiquor",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(-3249.487, 1004.408, 12.830),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(2549.771, 384.870, 108.622),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },
      {
        pos = vec3(2672.980, 3286.438, 55.241),
        data = {
          time = 450,
          requiredItems = {
            ["drill"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 400000, 600000 },
            },
            {
              name = "tablet",
              count = 1,
            },
          },
          label = "Skelp | TwentyFourSeven",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 3,
            },
          },
        },
      },

      {
        pos = vec3(146.027, -1044.655, 29.377),
        data = {
          time = 550,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
      {
        pos = vec3(-2957.549, 480.417, 15.706),
        data = {
          time = 500,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
      {
        pos = vec3(-1212.403, -336.220, 37.790),
        data = {
          time = 500,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
      {
        pos = vec3(-354.828, -53.864, 49.046),
        data = {
          time = 500,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
      {
        pos = vec3(310.361, -283.102, 54.174),
        data = {
          time = 500,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
      {
        pos = vec3(1177.325, 2711.931, 38.097),
        data = {
          time = 500,
          requiredItems = {
            ["drill"] = 2,
            ["tablet"] = 1,
          },
          rewardItems = {
            {
              name = "black_money",
              count = { 1000000, 1200000 },
            },
          },
          label = "Bank | Fleeca",
          requiredJobs = {
            {
              job = { "police", "sheriff" },
              count = 6,
            },
          },
        },
      },
    },
    blip = {
      label = "Napad",

      color = 1,
      scale = 0.3,
      sprite = 771,
      shortRange = true,
      display = 4,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Napad",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby rozpaczać napad.",
    },
  },
  { -- Złodziej samochodow
    type = "carthief",
    name = "carthief",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    secondClick = true,
    noBlip = true,
    coords = {
      {
        pos = vec3(374.901, 3592.443, 33.290 - 0.9),
        marker = {
          type = 27,
          scale = vec3(2.0, 2.0, 2.0),
          color = {
            r = 168,
            g = 50,
            b = 50,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        data = {
          type = "sell",
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby sprzedać pojazd.",
        },
      },
      {
        pos = vec3(387.468, 3584.887, 33.290),
        data = {
          vehicles = {
            {
              model = "2015s3",
              price = 120000,
            },
            {
              model = "c7z06",
              price = 830000,
            },
            {
              model = "chr20",
              price = 515000,
            },
            {
              model = "m2f22",
              price = 500000,
            },
            {
              model = "m3f80",
              price = 730000,
            },
            {
              model = "m135iwb",
              price = 699090,
            },
            {
              model = "pts21",
              price = 535000,
            },
            {
              model = "raptor150",
              price = 830000,
            },
            {
              model = "rs7",
              price = 790000,
            },
            {
              model = "rs318",
              price = 890000,
            },
            {
              model = "s500w222",
              price = 850000,
            },
            {
              model = "terzo",
              price = 820000,
            },
            {
              model = "z4alchemist",
              price = 820000,
            },
            {
              model = "merc63s",
              price = 820000,
            },
            {
              model = "488lb",
              price = 820000,
            },
            {
              model = "rs4avant",
              price = 820000,
            },
            {
              model = "a90sh",
              price = 820000,
            },
            {
              model = "mh3330",
              price = 820000,
            },
            {
              model = "4444",
              price = 820000,
            },
            {
              model = "c8",
              price = 820000,
            },
            {
              model = "nissantitan17",
              price = 820000,
            },
            {
              model = "rs6",
              price = 820000,
            },
            {
              model = "xxxxx",
              price = 820000,
            },
            {
              model = "panamera17turbo",
              price = 820000,
            },
            {
              model = "20trailboss",
              price = 820000,
            },
            {
              model = "sti12",
              price = 820000,
            },
          },
          type = "spawn",
          coords = {
            {
              vec3(612.801, 114.786, 92.411),
              69.459,
            },
            {
              vec3(-1492.925, -504.944, 32.308),
              213.890,
            },
            {
              vec3(-807.446, -1275.667, 4.501),
              170.092,
            },
            {
              vec3(179.127, -694.905, 32.627),
              69.134,
            },
            {
              vec3(1009.083, -2291.908, 30.010),
              174.015,
            },
            {
              vec3(162.111, -1508.804, 28.642),
              134.810,
            },
            {
              vec3(-612.288, 331.296, 84.619),
              355.700,
            },
            {
              vec3(-1887.828, 2031.981, 140.229),
              160.069,
            },
            {
              vec3(2681.276, 1330.011, 24.013),
              359.800,
            },
            {
              vec3(-619.826, -2197.846, 5.496),
              356.59,
            },
            {
              vec3(-976.6232, -2710.524, 12.90278),
              351.18,
            },
            {
              vec3(-780.046631, -2394.434, 13.6116247),
              150.09,
            },
            {
              vec3(-990.8843, -2556.87378, 20.684391),
              141.18,
            },
            {
              vec3(-1245.6615, -1419.91223, 3.4362824),
              120.57,
            },
            {
              vec3(-1546.14282, -995.1249, 12.1118174),
              200.76,
            },
            {
              vec3(-1617.37256, -806.5312, 9.164679),
              132.94,
            },
            {
              vec3(-935.371155, -176.464462, 40.9903526),
              21.61,
            },
            {
              vec3(-209.34874, 288.143951, 92.01333),
              87.,
            },
            {
              vec3(186.9827, 380.488556, 107.539207),
              355.64,
            },
            {
              vec3(924.9104, -46.36954, 77.95271),
              242.27,
            },
            {
              vec3(1144.88074, -475.177734, 65.45373),
              259.25,
            },
            {
              vec3(1203.08569, -1557.77185, 38.44906),
              58.35,
            },
            {
              vec3(224.92543, 1190.22864, 224.542145),
              282.98,
            },
            {
              vec3(-399.653778, 1197.76074, 324.708374),
              342.28,
            },
            {
              vec3(-2336.17847, 271.478119, 168.51683),
              20.68,
            },
            {
              vec3(-801.356567, 5412.43652, 32.93213),
              57.14,
            },
            {
              vec3(-771.854553, 5575.357, 32.53702),
              80.60,
            },
            {
              vec3(-703.878, 5782.83154, 16.4044075),
              152.72,
            },
            {
              vec3(-337.2222, 6134.777, 30.543623),
              39.68,
            },
            {
              vec3(54.1218758, 6367.982, 30.27095),
              210.60,
            },
            {
              vec3(195.874161, 6630.69873, 30.6036739),
              166.67,
            },
            {
              vec3(1686.21265, 6431.28955, 31.4694023),
              197.80,
            },
            {
              vec3(1704.39429, 4803.831, 40.8177719),
              137.57,
            },
            {
              vec3(3574.05273, 3759.68823, 28.97149),
              349.18,
            },
          },
        },
      },
    },
    marker = {
      type = 36,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby przyjąć zlecenie na kradzież pojazdu. Naciśnij <k>G</k>, aby anulować zlecenie.",
    },
    label = "Złodziej samochodów",
  },
  { -- blip
    type = "blip",
    name = "blip",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = false,
    },
    coords = {
      {
        pos = vec3(-1042.668, -2745.758, 21.343 - 9),
        blip = {
          label = "Lotnisko międzynarodowe",

          color = 3,
          scale = 0.9,
          sprite = 16,
          shortRange = true,
          display = 4,
        },
      },
      {
        pos = vec3(1846.035, 2585.854, 45.657 - 9),
        blip = {
          label = "Więzienie Stanowe",

          color = 22,
          scale = 0.9,
          sprite = 188,
          shortRange = true,
          display = 4,
        },
      },
      {
        pos = vec3(628.707, 5.367, 84.378 - 9),
        blip = {
          label = "Posterunek Policji",

          color = 3,
          scale = 0.9,
          sprite = 60,
          shortRange = true,
          display = 4,
        },
      },
      {
        pos = vec3(1830.989, 3675.613, 34.317 - 9),
        blip = {
          label = "Posterunek Szeryfa",

          color = 5,
          scale = 0.9,
          sprite = 58,
          shortRange = true,
          display = 4,
        },
      },
      {
        pos = vec3(875.116, -2102.202, 30.459 - 9),
        blip = {
          label = "Los Santos Customs",

          color = 5,
          scale = 0.9,
          sprite = 446,
          shortRange = true,
          display = 4,
        },
      },
      {
        pos = vec3(585.035, 2784.820, 42.192 - 9),
        blip = {
          label = "Los Santos Customs",

          color = 5,
          scale = 0.9,
          sprite = 446,
          shortRange = true,
          display = 4,
        },
      },
    },
  },
  {
    type = "prison_work",
    name = "prison_work",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    noBlip = true,
    coords = {
      {
        pos = vec3(1775.357, 2552.033, 45.564),
        type = "pick",
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby odebrać towar.",
        },
      },
      {
        pos = vec3(1741.810, 2502.683, 45.806),
        type = "give",
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby zwrócić towar.",
        },
        time = 2,
        price = 15,
      },
    },
    label = "wiezienna praca",
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
  },
  { -- flag
    type = "flags",
    noBlip = true,
    name = "flags",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = false,
    },
    coords = {
      {
        pos = vec3(-1175.811, 4922.273, 223.078),
        liveText = true,
        text = {
          {
            font = 7,
            label = "Flaga:",
            size = 4,
            offset = 0.3,
            color = {
              r = 255,
              g = 255,
              b = 255,
            },
          },
        },
        time = 30,
        rewardItems = {
          {
            name = "black_money",
            count = { 120000, 300000 },
          },
        },
      },
      {
        pos = vec3(2752.125, 1514.229, 30.791),
        time = 30,
        rewardItems = {
          {
            name = "black_money",
            count = { 120000, 300000 },
          },
        },
      },
    },
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wywiesić flage.",
    },
    marker = {
      type = 21,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 168,
        g = 50,
        b = 50,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    text = {
      {
        font = 7,
        label = "Flaga:",
        size = 4,
        offset = 0.3,
        color = {
          r = 255,
          g = 255,
          b = 255,
        },
      },
    },
  },
  -- { -- jobs sadownik
  --     type = "company",
  --     name = "company",
  --     settings = {
  --         drawDist = 55.0,
  --         -- radius = 55.0,
  --         overrideCoords = true,
  --         drawMarker = true,
  --         trackEnter = true,
  --         trackLeave = true,

  --     },
  --     requiredDutyJob = 'lumberjack',
  --     caution = 2000,
  --     blackMoney = false,
  --     coords = {
  --         {
  --             pos = vec3(-689.07, 5788.94, 17.33),
  --             type = 'cloakroom',
  --             blip = {
  --                 label = "#1 Szatnia",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 502,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby się przebrać."
  --             },
  --         },
  --         {
  --             pos = vec3(-679.77, 5833.83, 17.33),
  --             blip = {
  --                 label = "#2 Wyjmowanie ciężarówki",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 503,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, wyjąć tira."
  --             },

  --             type = 'spawn-vehicle',
  --             vehicle = "phantom",
  --             spawnCoords = {
  --                 coords = vec3(-663.40, 5823.29, 17.33),
  --                 heading = 85.39
  --             },
  --         },

  --         {
  --             pos = vec3(-830.3, 5415.0, 34.37),
  --             blip = {
  --                 label = "#3 Wyjmij naczepe",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 504,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby wyjąć naczepe."
  --             },

  --             type = 'spawn-vehicle',
  --             vehicle = "trailerlogs",
  --             spawnCoords = {
  --                 coords = vec3(-803.1, 5409.05, 33.89),
  --                 heading = 56.33
  --             },
  --         },

  --         {
  --             pos = vec3(-806.55, 5432.9, 34.34),
  --             type = 'collect',

  --             blip = {
  --                 label = "#4 Zbieranie drewna",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 505,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby zbierać drewno."
  --             },

  --             rewardItems = {
  --                 {
  --                     name = 'woodlog',
  --                     count = 5
  --                 }
  --             },

  --             check = {
  --                 {
  --                     name = 'has-trailer',
  --                     [false] = {
  --                         type = "info",
  --                         title = "Tir",
  --                         message = "Nie masz naczepy"
  --                     }
  --                 }
  --             }
  --         },

  --         {
  --             pos = vec3(2741.670, 4412.469, 48.623),
  --             type = 'collect',
  --             blip = {
  --                 label = "#5 Przerobka na deski",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 505,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby przerobic drewno na deski."
  --             },
  --             exchangeItems = {
  --                 {
  --                     giveItem = "woodplank",
  --                     removeItem = "woodlog",
  --                     amountToGive = 10,
  --                     amountToRemove = 5
  --                 }
  --             }
  --         },

  --         {
  --             pos = vec3(709.93, 4177.3, 40.7),
  --             type = 'collect',
  --             blip = {
  --                 label = "#6 Sprzedaz desek",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 505,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby przerobic drewno na deski."
  --             },
  --             exchangeItems = {
  --                 {
  --                     giveItem = "cash",
  --                     removeItem = "woodplank",
  --                     amountToGive = 100,
  --                     amountToRemove = 5
  --                 }
  --             },
  --             check = {
  --                 {
  --                     name = 'remove-trailer',
  --                     [false] = {
  --                         type = "info",
  --                         title = "Tir",
  --                         message = "Nie masz naczepy"
  --                     }
  --                 }
  --             }
  --         },

  --         {
  --             pos = vec3(424.868, 6472.146, 27.871),
  --             type = 'vehicle-delete',
  --             blip = {
  --                 label = "#7 Schowaj pojazd",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 506,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             marker = {
  --                 type = 27,
  --                 scale = vec3(1.5, 1.5, 1.5),
  --                 color = {
  --                     r = 196,
  --                     g = 115,
  --                     b = 39,
  --                     a = 222
  --                 },
  --                 animate = false,
  --                 faceCam = true
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby schować pojazd."
  --             },
  --         },
  --     },
  --     label = "Sadownik",
  --     marker = {
  --         type = 20,
  --         scale = vec3(1.0, 1.0, 1.0),
  --         color = {
  --             r = 196,
  --             g = 115,
  --             b = 39,
  --             a = 222
  --         },
  --         animate = false,
  --         faceCam = true
  --     },
  --     onCreateCb = {
  --         name = "has-job",
  --         data = { "grower" }
  --     }
  -- },

  { -- lsc cloakroom
    type = "cloakroom",
    name = "lsc_cloakroom",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(883.041, -2100.830, 30.459),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(562.587, 2777.787, 42.210),
      },
    },
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 76,
        g = 76,
        b = 76,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Szatnia",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
    },
    onCreateCb = {
      name = "has-job",
      data = { "mechanic" },
    },
    blip = {
      label = "Szatnia",

      color = 40,
      scale = 0.6,
      sprite = 366,
      shortRange = true,
      display = 4,
    },
  },
  { -- lsc_vehicle
    type = "vehicle",
    name = "lsc_vehicle",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(867.520, -2117.709, 30.493),
        spawns = {
          {
            coords = vec3(860.518, -2124.857, 30.307),
            heading = 357.165,
          },
        },
      },
      {
        data = { --new
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(573.600, 2803.164, 41.991),
        spawns = {
          {
            coords = vec3(566.736, 2808.534, 42.112),
            heading = 357.165,
          },
        },
      },
    },
    marker = {
      type = 36,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 76,
        g = 76,
        b = 76,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "Pojazdy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wyciagnąć pojazd.",
      onEnterInVehicle = "Naciśnij <k>E</k>, aby schować pojazd.",
    },
    blip = {
      label = "Pojazdy",

      color = 40,
      scale = 0.6,
      sprite = 225,
      shortRange = true,
      display = 4,
    },
    onCreateCb = {
      name = "has-job",
      data = { "mechanic" },
    },
  },
  { -- tune
    type = "tune",
    name = "tune",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    coords = {
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(875.881, -2125.622, 30.054 - 0.4),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(887.116, -2126.584, 30.054 - 0.4),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(897.771, -2127.534, 30.054 - 0.4),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(909.098, -2128.509, 30.054 - 0.4),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(887.960, -2101.582, 29.953 - 0.4),
      },
      {
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(895.938, -2102.268, 29.953 - 0.4),
      },

      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(601.456, 2752.781, 42.209 - 0.5),
      },
      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(595.323, 2752.256, 42.209 - 0.5),
      },
      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(589.097, 2751.673, 42.209 - 0.5),
      },
      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(577.195, 2750.966, 42.209 - 0.5),
      },
      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(582.854, 2771.908, 41.829 - 0.5),
      },
      { --new
        data = {
          jobs = {
            "mechanic",
          },
        },
        pos = vec3(583.784, 2762.787, 41.829 - 0.5),
      },
    },
    marker = {
      type = 27,
      scale = vec3(1.5, 1.5, 1.5),
      color = {
        r = 76,
        g = 76,
        b = 76,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    label = "tune",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby zmodyfikować pojazd.",
    },
    blip = {
      label = "Stanowiska",

      color = 40,
      scale = 0.6,
      sprite = 72,
      shortRange = true,
      display = 4,
    },
    onCreateCb = {
      name = "has-job",
      data = { "mechanic" },
    },
  },

  -- -- -- -- { -- work center
  -- -- -- --     type = "gang-room",
  -- -- -- --     name = "gang-room",
  -- -- -- --     settings = {
  -- -- -- --         drawDist = 55.0,
  -- -- -- --         -- radius = 55.0,
  -- -- -- --         overrideCoords = true,
  -- -- -- --         drawMarker = true
  -- -- -- --     },
  -- -- -- --     marker = {
  -- -- -- --         type = 20,
  -- -- -- --         scale = vec3(1.0, 1.0, 1.0),
  -- -- -- --         color = {
  -- -- -- --             r = 178,
  -- -- -- --             g = 102,
  -- -- -- --             b = 25,
  -- -- -- --             a = 222
  -- -- -- --         },
  -- -- -- --         animate = false,
  -- -- -- --         faceCam = true
  -- -- -- --     },
  -- -- -- --     coords = {
  -- -- -- --         {
  -- -- -- --             gang = "ballas",
  -- -- -- --             pos = vec3(81.97, -1931.4, 20.7),
  -- -- -- --         },
  -- -- -- --     },
  -- -- -- --     label = "Siedziba gangu",
  -- -- -- --     messages = {
  -- -- -- --         onEnter = "Naciśnij <k>E</k>, aby otworzyć szafkę."
  -- -- -- --     },
  -- -- -- --     blip = {
  -- -- -- --         label = "Siedziba gangu",
  -- -- -- --
  -- -- -- --         color = 3,
  -- -- -- --         scale = 0.9,
  -- -- -- --         sprite = 682,
  -- -- -- --         shortRange = true,
  -- -- -- --         display = 4,
  -- -- -- --     },
  -- -- -- -- },

  -- { -- work center
  --     type = "company-room",
  --     name = "company-room",
  --     settings = {
  --         drawDist = 55.0,
  --         -- radius = 55.0,
  --         overrideCoords = true,
  --         drawMarker = true
  --     },
  --     marker = {
  --         type = 20,
  --         scale = vec3(1.0, 1.0, 1.0),
  --         color = {
  --             r = 178,
  --             g = 102,
  --             b = 25,
  --             a = 222
  --         },
  --         animate = false,
  --         faceCam = true
  --     },
  --     coords = {
  --         {
  --             company = "lumberjack",
  --             pos = vec3(-582.1, 5306.05, 70.2),
  --         },
  --     },
  --     label = "Siedziba firmy",
  --     messages = {
  --         onEnter = "Naciśnij <k>E</k>, aby otworzyć szafkę."
  --     },
  --     blip = {
  --         label = "Siedziba firmy",
  --
  --         color = 3,
  --         scale = 0.9,
  --         sprite = 682,
  --         shortRange = true,
  --         display = 4,
  --     },
  -- },

  -- { --
  --     type = "jobs-company",
  --     name = "jobs-lumberjack",
  --     settings = {
  --         drawDist = 55.0,
  --         -- radius = 55.0,
  --         overrideCoords = true,
  --         drawMarker = true,
  --         trackEnter = true,
  --         trackLeave = true,

  --     },
  --     requiredDutyJob = 'lumberjack',
  --     caution = 2000,
  --     blackMoney = false,
  --     coords = {
  --         {
  --             pos = vec3(-689.07, 5788.94, 17.33),
  --             type = 'cloakroom',
  --             blip = {
  --                 label = "#1 Szatnia",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 502,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby się przebrać."
  --             },
  --         },
  --         {
  --             pos = vec3(-679.77, 5833.83, 17.33),
  --             blip = {
  --                 label = "#2 Odbieranie ciężarówki",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 503,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, wyjąć tira."
  --             },

  --             type = 'add-vehicle',
  --             plate = "LUMBER%s",
  --             vehicle = "phantom",
  --             spawnCoords = {
  --                 coords = vec3(-663.40, 5823.29, 17.33),
  --                 heading = 85.39
  --             },
  --         },

  --         {
  --             pos = vec3(-830.3, 5415.0, 34.37),
  --             blip = {
  --                 label = "#3 Wyjmij naczepe",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 504,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby wyjąć naczepe."
  --             },

  --             type = 'spawn-vehicle',
  --             vehicle = "trailerlogs",
  --             spawnCoords = {
  --                 coords = vec3(-803.1, 5409.05, 33.89),
  --                 heading = 56.33
  --             },
  --         },

  --         {
  --             pos = vec3(-806.55, 5432.9, 34.34),
  --             type = 'collect',

  --             blip = {
  --                 label = "#4 Zbieranie drewna",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 505,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby zbierać drewno."
  --             },

  --             rewardItems = {
  --                 {
  --                     name = 'woodlog',
  --                     count = 5
  --                 }
  --             },

  --             check = {
  --                 {
  --                     name = 'has-trailer',
  --                     [false] = {
  --                         type = "info",
  --                         title = "Tir",
  --                         message = "Nie masz naczepy"
  --                     }
  --                 }
  --             }
  --         },

  --         {
  --             pos = vec3(352.3, 4452.3, 63.3),
  --             type = 'collect',
  --             blip = {
  --                 label = "#5 Przerobka na deski",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 506,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby przerobic drewno na deski."
  --             },
  --             exchangeItems = {
  --                 {
  --                     giveItem = "woodplank",
  --                     removeItem = "woodlog",
  --                     amountToGive = 10,
  --                     amountToRemove = 5
  --                 }
  --             }
  --         },

  --         {
  --             pos = vec3(709.93, 4177.3, 40.7),
  --             type = 'collect',
  --             blip = {
  --                 label = "#6 Sprzedaz desek",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 507,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby sprzedac deski."
  --             },
  --             pay = {
  --                 amount = 5000,
  --                 companyPercent = 10,
  --                 item = 'cash'
  --             },
  --             check = {
  --                 {
  --                     name = 'remove-trailer',
  --                     [false] = {
  --                         type = "info",
  --                         title = "Tir",
  --                         message = "Nie masz naczepy"
  --                     },
  --                     [true] = {
  --                         type = "info",
  --                         title = "Tir",
  --                         message = "Sprzedajesz drewno, zaczekaj"
  --                     }
  --                 }
  --             }
  --         },
  --         {
  --             pos = vec3(-689.74, 5773.3, 17.33),
  --             type = 'vehicle-delete',
  --             blip = {
  --                 label = "#7 Schowaj pojazd",
  --
  --                 color = 47,
  --                 scale = 0.5,
  --                 sprite = 508,
  --                 shortRange = true,
  --                 display = 4
  --             },
  --             marker = {
  --                 type = 27,
  --                 scale = vec3(1.5, 1.5, 1.5),
  --                 color = {
  --                     r = 196,
  --                     g = 115,
  --                     b = 39,
  --                     a = 222
  --                 },
  --                 animate = false,
  --                 faceCam = true
  --             },
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby schować pojazd."
  --             },
  --         },
  --     },
  --     label = "Drwal",
  --     marker = {
  --         type = 20,
  --         scale = vec3(1.0, 1.0, 1.0),
  --         color = {
  --             r = 196,
  --             g = 115,
  --             b = 39,
  --             a = 222
  --         },
  --         animate = false,
  --         faceCam = true
  --     },
  --     onCreateCb = {
  --         name = "has-job",
  --         data = { "lumberjack" }
  --     }
  -- },

  -- { -- lsc cloakroom
  --     type = "soccer",
  --     name = "soccer",
  --     settings = {
  --         drawDist = 55.0,
  --         -- radius = 55.0,
  --         overrideCoords = true,
  --         drawMarker = true
  --     },
  --     coords = {
  --         {
  --             pos = vec3(779.9, -216.27, 66.1),
  --         },
  --     },
  --     marker = {
  --         type = 20,
  --         scale = vec3(1.0, 1.0, 1.0),
  --         color = {
  --             r = 76,
  --             g = 76,
  --             b = 76,
  --             a = 222
  --         },
  --         animate = false,
  --         faceCam = true
  --     },
  --     label = "Piłka nożna",
  --     messages = {
  --         onEnter = "Naciśnij <k>E</k>, aby zagrać."
  --     },
  --     blip = {
  --         label = "Piłka nożna",
  --
  --         color = 40,
  --         scale = 0.6,
  --         sprite = 366,
  --         shortRange = true,
  --         display = 4,
  --     },
  -- },

  -- { -- lsc cloakroom
  --     type = "pacific-start-rob",
  --     name = "pacific-start-rob",
  --     settings = {
  --         drawDist = 55.0,
  --         -- radius = 55.0,
  --         overrideCoords = true,
  --         drawMarker = true,

  --         trackEnter = true,
  --         trackLeave = true,
  --     },
  --     coords = {
  --         {
  --             pos = vec3(235.29, 216.85, 106.28),
  --             action = 'start'
  --         },
  --         {
  --             pos = vec3(261.47, 204.77, 110.287),
  --             action = 'hack-alarm',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby wyłączyć alarm."
  --             },
  --         },
  --         {
  --             pos = vec3(247.7, 209.3, 110.3),
  --             action = 'hack-doors',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby otworzyć drzwi."
  --             },
  --         },
  --         {
  --             pos = vec3(261.7, 223.274, 106.284073),
  --             action = 'enter-code-doors',
  --             doors = 'gate',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby wpisać kod."
  --             },
  --         },

  --         {
  --             pos = vec3(253.4, 228.3, 101.7),
  --             action = 'enter-code-doors',
  --             doors = 'vault',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby wpisać kod."
  --             },
  --         },

  --         {
  --             pos = vec3(265.09, 210.97, 110.29),
  --             action = 'get-doors-code',
  --             doors = 'gate',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby znaleźć kod."
  --             },
  --         },

  --         {
  --             pos = vec3(243.7, 230.7, 106.39),
  --             action = 'get-doors-code',
  --             doors = 'vault',
  --             messages = {
  --                 onEnter = "Naciśnij <k>E</k>, aby znaleźć kod."
  --             },
  --         },
  --     },
  --     marker = {
  --         type = 20,
  --         scale = vec3(1.0, 1.0, 1.0),
  --         color = {
  --             r = 76,
  --             g = 76,
  --             b = 76,
  --             a = 222
  --         },
  --         animate = false,
  --         faceCam = true
  --     },
  --     label = "Pacyfik Bank",
  --     messages = {
  --         onEnter = "Naciśnij <k>E</k>, aby rozpocząć napad."
  --     },
  --     blip = {
  --         label = "Pacyfik Bank",
  --
  --         color = 40,
  --         scale = 0.6,
  --         sprite = 366,
  --         shortRange = true,
  --         display = 4,
  --     },
  -- },
  { -- Faggio
    type = "freeveh",
    name = "freeveh",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-1038.25, -2731.3, 20.3),
        data = {
          coords = vec3(-1034.45, -2728.1845, 20.145),
          heading = 333.0,
          model = "faggio",
        },
      },
    },
    data = {},
    label = "Skutery",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wypożyczyć pojazd.",
    },
    blip = {
      label = "Skutery",

      color = 0,
      scale = 0.9,
      sprite = 523,
      shortRange = true,
      display = 4,
    },

    keepUI = true,
  },
  { -- Faggio
    type = "race",
    name = "race",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
    },
    marker = {
      type = 29,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 50,
        g = 168,
        b = 82,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {

        pos = vec3(977.403, -1487.885, 31.4373),
        data = {
          race = 1,
        },
      },
    },
    data = {},
    label = "Wyścigi",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby otworzyć wyścig.",
    },
    blip = {
      label = "Wyścigi",

      color = 0,
      scale = 0.9,
      sprite = 523,
      shortRange = true,
      display = 4,
    },

    keepUI = true,
  },
}
