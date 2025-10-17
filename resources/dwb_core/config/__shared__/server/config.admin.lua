Config.Admin.Cards = {
  banned = [==[
        {   
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "medium",
                "weight": "bolder",
                "text": "%s"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "width": "stretch",
                        "items": [
                            {
                                "type":"ActionSet",
                                "horizontalAlignment": "Center",
                                "actions": [
                                    {
                                      "type":"Action.OpenUrl",
                                      "title": "Strona",
                                      "url": "https://boskierp.pl",
                                    },
                                    {
                                        "type":"Action.OpenUrl",
                                        "title": "Discord",
                                        "url": "https://discord.gg/n9zytQK7D6",
                
                                    },
                                ]
                            },
                        ],
                    }
                ]
            },
            
        ],
    "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
        "version":"1.5"
    }
    ]==],
}
Config.Admin.Actions = {
  ["player"] = {
    {
      label = "Spectuj gracza",
      value = "spectate",
      requires = "menu.spectate",
    },
    {
      label = "Teleportuj do gracza",
      value = "teleportto",
      requires = "menu.teleportto",
    },
    {
      label = "Teleportuj gracza do siebie",
      value = "teleporttome",
      requires = "menu.teleporttome",
    },
    {
      label = "Freeze",
      value = "freeze",
      requires = "menu.freeze",
    },
    {
      label = "Sprawdz eq",
      value = "check",
      requires = "menu.check",
    },
    {
      label = "Zdjęcie",
      value = "photo",
      requires = "menu.photo",
    },
  },
  ["last_player"] = {
    {
      label = "Zbanuj gracza",
      value = "ban",
    },
  },
}
