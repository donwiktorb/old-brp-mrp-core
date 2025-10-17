local special = {
  {
    type = "jail",
    name = "jail",
    onCreateCb = {

      name = "has-char-data",
      data = "jailTime",
    },
    onExitCb = { name = "teleportback" },

    onCreatedCb = {

      name = "teleport",
      data = {
        coords = vector3(1689.44, 2597.47, 45.55),
      },
    },
    settings = {
      drawDist = 500.0,
      --radius = 500.0,
      overrideCoords = true,
      drawMarker = false,
      trackEnterClient = true,
      trackLeaveClient = true,
    },
    marker = {
      type = 1,
      scale = vec3(340.0, 340.0, 10.0),
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
        pos = vector3(1689.44, 2597.47, 45.55),
      },
    },
    label = "Lotnisko międzynarodowe",
    blip = {
      label = "Lotnisko międzynarodowe",
      category = 20,
      color = 0,
      scale = 0.9,
      sprite = 350,
      shortRange = true,
      display = 4,
    },
  },
}

--merge(Config.Zones["boskierp"], special)
