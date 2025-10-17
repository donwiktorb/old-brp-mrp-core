Config.Admin = {}
Config.Admin.Permissions = {
  ["991373226238300170"] = {
    modes = { "boskierp", "militaryrp" },
    menu = {
      players = true,
      server = true,
      options = true,
      tpm = true,
      ban = true,
      kick = true,
      report = true,
      unban = true,
      check = true,
      freeze = true,
      spectate = true,
      teleportto = true,
      teleporttome = true,
      noclip = true,
      inv = true,
      photo = true,
      noclipspeed = true,
    },
    commands = {
      ["revive"] = true,
      ["revdist"] = true,
      ["skin"] = true,
      ["unban"] = true,
      ["ban"] = true,
      ["kick"] = true,
      ["car"] = true,
      ["dv"] = true,
      ["dvall"] = true,

      ["setjob"] = true,
      ["remjob"] = true,
      ["system"] = true,
      ["call"] = true,
      ["event"] = true,
      ["restart"] = true,
      ["odkuj"] = true,
      ["gitem"] = true,
      ["additem"] = true,
      ["clearinv"] = true,
      ["invclear"] = true,
      ["ritem"] = true,
      ["unjail"] = true,
      ["blackout"] = true,
      ["coords"] = true,
      ["saveall"] = true,
    },
  },
}
Config.Admin.Actions = {
  {
    label = "Zbanuj gracza",
    value = "ban",
  },
  {
    label = "Wyrzuc gracza",
    value = "kick",
  },
  {
    label = "Spectuj gracza",
    value = "spectate",
  },
  {
    label = "Teleportuj do gracza",
    value = "teleportto",
  },
  {
    label = "Teleportuj gracza do siebie",
    value = "teleporttome",
  },
  {
    label = "Freeze",
    value = "freeze",
  },
  {
    label = "Sprawdz eq",
    value = "check",
  },
}
