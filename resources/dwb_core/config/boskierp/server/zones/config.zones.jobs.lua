local jobs = {

  { -- work center
    type = "work_center",
    name = "work center",
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
        r = 178,
        g = 102,
        b = 25,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    coords = {
      {
        pos = vec3(-264.303, -965.221, 31.217),
      },
    },
    label = "Centrum Pracy",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać zatrudnienie.",
    },
    blip = {
      label = "Centrum Pracy",
      category = 20,
      color = 3,
      scale = 0.9,
      sprite = 682,
      shortRange = true,
      display = 4,
    },
  },

  ------------------------------

  { -- Sadownik
    type = "jobs",
    name = "butcher_jobs",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
      trackEnter = true,
      trackLeave = true,
    },
    requiredDutyJob = "grower",
    caution = 2000,
    blackMoney = false,
    coords = {
      {
        pos = vec3(416.663, 6520.760, 27.695),
        type = "cloakroom",
        blip = {
          label = "#1 Szatnia",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 502,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
        },
      },
      {
        type = "collect",
        task = "world_human_gardener_plant",
        anim = {
          lib = "amb@prop_human_movie_bulb@base",
          anim = "base",
          data = {
            loop = true,
          },
        },
        pos = vec3(355.418, 6517.330, 27.450),
        blip = {
          label = "#2 Zbiór pomarańczy",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 503,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(5.5, 5.5, 5.5),
          color = {
            r = 196,
            g = 115,
            b = 39,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        preventVehicle = true,
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby zebrać pomarańcze.",
        },
        time = 3,
        rewardItems = {
          {
            count = 5,
            name = "orange",
          },
        },
      },
      {
        pos = vec3(407.187, 6497.257, 27.827),
        type = "spawn-vehicle",
        vehicle = "bobcatxl",
        spawnCoords = {
          coords = vec3(420.856, 6493.575, 27.887),
          heading = 356.028,
        },
        blip = {
          label = "#3 Wynajem pojazd",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 504,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby wynająć pojazd. Koszt: 2000$",
        },
      },
      {
        pos = vec3(2741.670, 4412.469, 48.623),
        type = "collect",
        blip = {
          label = "#4 Sprzedaż",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 505,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby sprzedać pomarańcze.",
        },
        exchangeItems = {
          {
            giveItem = "cash",
            removeItem = "orange",
            amountToGive = 4500,
            amountToRemove = 5,
          },
        },
      },
      {
        pos = vec3(-440.607, 1595.067, 358.467),
        type = "collect",
        blip = {
          label = "#4 Sprzedaż",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 505,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby sprzedać pomarańcze.",
        },
        exchangeItems = {
          {
            giveItem = "cash",
            removeItem = "orange",
            amountToGive = 6000,
            amountToRemove = 5,
          },
        },
      },
      {
        pos = vec3(424.868, 6472.146, 27.871),
        type = "vehicle-delete",
        blip = {
          label = "#5 Schowaj pojazd",
          category = 20,
          color = 47,
          scale = 0.5,
          sprite = 506,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(1.5, 1.5, 1.5),
          color = {
            r = 196,
            g = 115,
            b = 39,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby schować pojazd.",
        },
      },
    },
    label = "Sadownik",
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 196,
        g = 115,
        b = 39,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    onCreateCb = {
      name = "has-job",
      data = { "grower" },
    },
  },

  ------------------------------

  { -- Tkacz
    type = "jobs",
    name = "waver",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
      trackEnter = true,
      trackLeave = true,
    },
    requiredDutyJob = "weaver",
    caution = 2000,
    blackMoney = false,
    coords = {
      {
        pos = vec3(707.017, -966.665, 30.412),
        type = "cloakroom",
        blip = {
          label = "#1 Szatnia",
          category = 20,
          color = 3,
          scale = 0.5,
          sprite = 502,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
        },
      },
      {
        pos = vec3(692.782, -978.341, 23.765),
        type = "spawn-vehicle",
        vehicle = "bison",
        spawnCoords = {
          coords = vec3(702.899, -986.830, 23.617),
          heading = 274.416,
        },
        blip = {
          label = "#2 Wyjmij pojazd",
          category = 20,
          color = 3,
          scale = 0.5,
          sprite = 503,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby wyjąć pojazd. Koszt: 2000$",
        },
      },
      {
        type = "collect",
        pos = vec3(1968.056, 5179.762, 46.984),
        blip = {
          label = "#2 Zbiór",
          category = 20,
          color = 3,
          scale = 0.5,
          sprite = 504,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(5.5, 5.5, 5.5),
          color = {
            r = 93,
            g = 182,
            b = 229,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby zebrać bawełne.",
        },
        time = 3,
        rewardItems = {
          {
            count = 5,
            name = "cotton",
          },
        },
      },
      {
        pos = vec3(707.134, -960.600, 29.495),
        type = "collect",
        blip = {
          label = "#4 Sprzedaż",
          category = 27,
          color = 3,
          scale = 0.5,
          sprite = 505,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(4.0, 4.0, 4.0),
          color = {
            r = 93,
            g = 182,
            b = 229,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby sprzedać bawełne.",
        },
        exchangeItems = {
          {
            giveItem = "cash",
            removeItem = "cotton",
            amountToGive = 6250,
            amountToRemove = 5,
          },
        },
      },
      {
        pos = vec3(693.040, -999.493, 22.309),
        type = "vehicle-delete",
        blip = {
          label = "#5 Schowaj pojazd",
          category = 20,
          color = 3,
          scale = 0.5,
          sprite = 506,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(2.5, 2.5, 2.5),
          color = {
            r = 93,
            g = 182,
            b = 229,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby schować pojazd.",
        },
      },
    },
    label = "Tkacz",
    marker = {
      type = 20,
      scale = vec3(1.0, 1.0, 1.0),
      color = {
        r = 93,
        g = 182,
        b = 229,
        a = 222,
      },
      animate = false,
      faceCam = true,
    },
    onCreateCb = {
      name = "has-job",
      data = { "weaver" },
    },
  },

  ------------------------------

  { -- Złomiarz
    type = "jobs",
    name = "jobs3",
    settings = {
      drawDist = 55.0,
      -- radius = 55.0,
      overrideCoords = true,
      drawMarker = true,
      trackEnter = true,
      trackLeave = true,
    },
    requiredDutyJob = "",
    caution = 2000,
    blackMoney = false,
    coords = {
      {
        pos = vec3(2340.115, 3124.900, 48.208),
        type = "cloakroom",
        blip = {
          label = "#1 Szatnia",
          category = 20,
          color = 40,
          scale = 0.5,
          sprite = 502,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby się przebrać.",
        },
      },
      {
        type = "collect",
        pos = vec3(2413.315, 3120.946, 48.348),
        blip = {
          label = "#2 Zbiór",
          category = 20,
          color = 40,
          scale = 0.5,
          sprite = 503,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(6.5, 6.5, 6.5),
          color = {
            r = 93,
            g = 182,
            b = 229,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby zbierać złom.",
        },
        time = 3,
        rewardItems = {
          {
            count = 5,
            name = "scrap",
          },
        },
      },
      {
        pos = vec3(2343.704, 3131.004, 48.208),
        type = "spawn-vehicle",
        vehicle = "bison",
        spawnCoords = {
          coords = vec3(2350.663, 3134.652, 47.7447),
          heading = 80.466,
        },
        blip = {
          label = "#3 Wynajem pojazdu",
          category = 20,
          color = 40,
          scale = 0.5,
          sprite = 504,
          shortRange = true,
          display = 4,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby wynająć pojazd. Koszt: 2000$",
        },
      },
      {
        pos = vec3(-194.766, 6296.969, 31.489),
        type = "collect",
        blip = {
          label = "#4 Sprzedaż złomu",
          category = 27,
          color = 40,
          scale = 0.5,
          sprite = 505,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(4.0, 4.0, 4.0),
          color = {
            r = 76,
            g = 76,
            b = 76,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby sprzedać złom.",
        },
        exchangeItems = {
          {
            giveItem = "cash",
            removeItem = "scrap",
            amountToGive = 5750,
            amountToRemove = 5,
          },
        },
      },
      {
        pos = vec3(2350.663, 3134.652, 47.7447),
        type = "vehicle-delete",
        blip = {
          label = "#5 Zwrot pojazdów",
          category = 20,
          color = 40,
          scale = 0.5,
          sprite = 506,
          shortRange = true,
          display = 4,
        },
        marker = {
          type = 27,
          scale = vec3(2.5, 2.5, 2.5),
          color = {
            r = 76,
            g = 76,
            b = 76,
            a = 222,
          },
          animate = false,
          faceCam = true,
        },
        messages = {
          onEnter = "Naciśnij <k>E</k>, aby schować pojazd.",
        },
      },
    },
    label = "Złomiarz",
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
    onCreateCb = {
      name = "has-job",
      data = { "" },
    },
  },
}

merge(Config.Zones["boskierp"], jobs)
