Config.Cursor.Entities["boskierp"] = {
  {
    bucket = 10,
    ped = {
      model = "mp_m_freemode_01",
    },
    type = "shop",
    name = "top",
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
        pos = vec3(51.47, 19.4, 819.4),
        heading = 144.3,
      },
    },
    data = {},
    label = "Sklep Elektroniczny",
    messages = {
      onEnter = "Naciśnij <k>E</k>, aby wybrać produkty.",
    },
    blip = {
      label = "Sklep Elektroniczny",
      category = 20,
      color = 43,
      scale = 0.9,
      sprite = 459,
      shortRange = true,
      display = 4,
    },
    action = {
      name = "deposit",
      title = "J. S.",
      closeOnSubmit = true,
      elements = {
        {
          label = "Odbierz przedmioty",
          value = "take",
        },
      },
    },
  },
}
