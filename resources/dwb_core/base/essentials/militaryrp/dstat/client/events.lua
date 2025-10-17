Event:Register("dwb:dstat:update", function(players)
  local dc = GetConvar("Discord", "https://discord.gg/militaryrp")
  --This is the Application ID (Replace this with you own)
  SetDiscordAppId(1045265949957296178)

  --Here you will have to put the image name for the "large" icon.
  SetDiscordRichPresenceAsset("military2")
  local convarValue = GetConvar("sv_maxclients", 128)
  --(11-11-2018) New Natives:

  --Here you can add hover text for the "large" icon.
  SetDiscordRichPresenceAssetText("MilitaryRP")

  SetRichPresence(
    "Żołnierzy: " .. players .. "/" .. convarValue .. " ID: " .. GetPlayerServerId(PlayerId())
  )
  --Here you will have to put the image name for the "small" icon.
  SetDiscordRichPresenceAssetSmall("military2")

  --Here you can add hover text for the "small" icon.
  SetDiscordRichPresenceAssetSmallText("Discord", dc)
  SetDiscordRichPresenceAction(0, "Dołącz na discord!", dc)
  SetDiscordRichPresenceAction(0 + 1, "Dołącz na serwer!", "fivem://connect/miltaryrp.pl")
end, true)
