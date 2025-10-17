Event:Register("dwb:dstat:update", function(players)
  local dc = Config.Discord.Url
  --This is the Application ID (Replace this with you own)
  SetDiscordAppId(Config.Discord.AppId)

  --Here you will have to put the image name for the "large" icon.
  SetDiscordRichPresenceAsset(Config.Discord.Asset)
  local convarValue = GetConvarInt("sv_maxclients", 128)
  --(11-11-2018) New Natives:

  --Here you can add hover text for the "large" icon.
  SetDiscordRichPresenceAssetText(Config.Discord.AssetText)

  SetRichPresence(
    string.format(Config.Discord.Text, players, convarValue, GetPlayerServerId(PlayerId()))
  )
  --Here you will have to put the image name for the "small" icon.
  SetDiscordRichPresenceAssetSmall(Config.Discord.AssetSmall)

  --Here you can add hover text for the "small" icon.
  SetDiscordRichPresenceAssetSmallText(Config.Discord.AssetSmallText, dc)

  for k, v in pairs(Config.Discord.Buttons) do
    SetDiscordRichPresenceAction(k - 1, v.label, v.value)
  end
end, true)
