local prox = 0
local talk = "normalnie"
local lasttalk
local voice = 0
local muted = {}
NetworkSetTalkerProximity(6.0) -- default

Thread:Create(function()
  while true do
    Citizen.Wait(0)
    if NetworkIsPlayerTalking(DWB.PlayerData.Player) then
      --local posPlayer = GetEntityCoords(GetPlayerPed(-1))
      SetTextFont(0)
      SetTextScale(0.4, 0.4)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextDropShadow()
      SetTextOutline()
      BeginTextCommandDisplayText("TWOSTRINGS")
      AddTextComponentSubstringPlayerName(TR("talk", talk))
      EndTextCommandDisplayText(1.2 - 1 / 2, 1.34 - 1 / 2 + 0.005)
    end
  end
end)

Key:onJustPressed("OEM_3", "Zmiana głośności", function()
  voice = (voice + 1) % 3
  LocalPlayer.state.voice = voice
  if voice == 0 then
    NetworkSetTalkerProximity(6.0) -- default
    MumbleSetTalkerProximity(6.0)
    talk = "normalnie"
    Notification:ShowCustom("info", TR("talking"), TR("talking_normal"))
  elseif voice == 1 then
    NetworkSetTalkerProximity(14.0) -- shout
    MumbleSetTalkerProximity(14.0)
    talk = "głośno"
    Notification:ShowCustom("info", TR("talking"), TR("talking_loud"))
  elseif voice == 2 then
    NetworkSetTalkerProximity(2.0) -- whisper
    MumbleSetTalkerProximity(2.0)
    talk = "cicho"
    Notification:ShowCustom("info", TR("talking"), TR("talking_silent"))
  end
end)

local connected = {}
local isConnected = false

Event:Register("dwb:voice:mute", function(player)
  if muted[player] then
    muted[player] = nil
  else
    muted[player] = true
    if connected[player] then
      MumbleRemoveVoiceTargetPlayer(2, player)
      connected[player] = nil
    end
  end
end, true)

Thread:Create(function()
  if Config.Voice.useServer then
    MumbleSetServerAddress(Config.Voice.host, Config.Voice.port)
  end

  -- while not MumbleIsConnected() do
  --   Wait(0)
  --   print("unconnected")
  -- end

  MumbleClearVoiceChannel()
  MumbleSetVoiceTarget(2)
  MumbleClearVoiceTarget(2)
  MumbleClearVoiceTargetPlayers(2)
  MumbleClearVoiceTargetChannels(2)
  isConnected = true
end)

RegisterCommand("mumble", function()
  while not MumbleIsConnected() do
    Wait(0)
    print("unconnected")
  end

  MumbleClearVoiceChannel()
  MumbleSetVoiceTarget(2)
  MumbleClearVoiceTarget(2)
  MumbleClearVoiceTargetPlayers(2)
  MumbleClearVoiceTargetChannels(2)
  isConnected = true
end, restricted)

local isTalkingRadio = false
local radio = 0
local radioTargets = {}
local radioConnected = {}

Thread:Create(function()
  -- print(retval)
  -- SetAudioSubmixEffectRadioFx(retval, 0)
  -- SetAudioSubmixEffectParamInt(submix, 0, `default`, 1)
  -- SetAudioSubmixEffectParamInt(submix, 0, `enabled`, 1)

  -- SetAudioSubmixEffectParamFloat(
  --     retval --[[ integer ]],
  --     0 --[[ integer ]],
  --     `o_freq_lo` --[[ integer ]],
  --     1.0 --[[ number ]]
  -- )

  -- SetAudioSubmixEffectParamFloat(
  --     retval --[[ integer ]],
  --     0 --[[ integer ]],
  --     `freq_low` --[[ integer ]],
  --     1.0 --[[ number ]]
  -- )

  -- SetAudioSubmixEffectParamFloat(
  --     retval --[[ integer ]],
  --     0 --[[ integer ]],
  --     `rm_mod_freq` --[[ integer ]],
  --     1.0 --[[ number ]]
  -- )

  -- -- SetAudioSubmixEffectParamFloat(
  -- --     retval --[[ integer ]],
  -- --     0 --[[ integer ]],
  -- --     `fudge` --[[ integer ]],
  -- --     0.5 --[[ number ]]
  -- -- )
  -- AddAudioSubmixOutput(retval, 0)

  -- we want to change the master output

  SetAudioSubmixEffectRadioFx(0, 0)

  SetAudioSubmixEffectParamInt(0, 0, `freq_low`, 0.0)
  SetAudioSubmixEffectParamInt(0, 0, `o_freq_lo`, 0.0)
  SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
  SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)

  local submix --[[ integer ]] = CreateAudioSubmix("radio" --[[ string ]])

  -- add a RadioFX effect to slot 0

  SetAudioSubmixEffectRadioFx(submix, 0)
  -- -- -- set the default values
  -- -- local values = {
  -- --     -- [`freq_low`] =100.0,
  -- --     -- [`freq_hi`] = 10.0,
  -- --     -- [`fudge`] = 40.0,
  -- --     -- [`rm_mod_freq`] = 40.0
  -- --     -- [`rm_mix`] = 70.0,
  -- --     -- [`o_freq_lo`] = 50.0,
  -- --     -- [`o_freq_hi`] = 50.0
  -- -- }
  SetAudioSubmixEffectParamInt(submix, 0, `default`, 1)

  -- SetAudioSubmixEffectParamInt(submix, 0, `freq_low`, 50.0)
  -- SetAudioSubmixEffectParamInt(submix, 0, `freq_low`, 0.1)
  -- SetAudioSubmixEffectParamInt(submix, 0, `o_freq_lo`, 2.5)
  -- SetAudioSubmixEffectParamInt(submix, 0, `o_freq_hi`, 40.5)
  --     for k,v in pairs(values) do
  -- SetAudioSubmixEffectParamInt(submix, 0, k, v)
  --     end

  -- SetAudioSubmixEffectParamInt(submix, 0, `enabled`, 1)

  -- SetAudioSubmixEffectParamInt(submix, 0, `freq_low`, 30.0)
  -- SetAudioSubmixEffectParamInt(submix, 0, `o_freq_lo`, 30.0)

  -- SetAudioSubmixEffectParamInt(submix, 0, `freq_low`, 30.0)

  AddAudioSubmixOutput(submix, 0)
  -- SetAudioSubmixOutputVolumes(
  -- 	submix --[[ integer ]],
  -- 	0 --[[ integer ]],
  -- 	1.0 --[[ number ]],
  -- 	1.0 --[[ number ]],
  -- 	1.0 --[[ number ]],
  -- 	1.0 --[[ number ]],
  -- 	1.0 --[[ number ]],
  -- 	1.0 --[[ number ]]
  -- )

  while true do
    Wait(300)
    if isConnected then
      local ped = PlayerPedId()
      local coords = GetEntityCoords(ped)
      -- local chunk = GetCurrentChunk(coords)
      -- MumbleSetVoiceChannel(chunk)
      for k, v in pairs(GetActivePlayers()) do
        if v ~= PlayerId() and not muted[v] then
          if not connected[v] then
            local pPed = GetPlayerPed(v)
            local pCoords = GetEntityCoords(pPed)
            local dist = #(coords - pCoords)

            if dist <= 20.0 then
              MumbleAddVoiceTargetPlayer(2, v)
              connected[v] = true
            end
          end
        end
      end
      local volume = DWB.UISettings["radio-volume"] or 1.0
      for k, v in pairs(radioTargets) do
        if v then
          if not radioConnected[k] then
            radioConnected[k] = true
            MumbleAddVoiceTargetPlayerByServerId(2, k)
            MumbleSetVolumeOverrideByServerId(k, volume)

            MumbleSetSubmixForServerId(k --[[ integer ]], submix --[[ integer ]])
          end
        elseif radioConnected[k] then
          radioConnected[k] = nil
          MumbleRemoveVoiceTargetPlayerByServerId(2, k)
          MumbleSetVolumeOverrideByServerId(k, -1.0)

          MumbleSetSubmixForServerId(k --[[ integer ]], -1 --[[ integer ]])
        end
      end

      for k, v in pairs(connected) do
        local pCoords = GetEntityCoords(GetPlayerPed(k))
        local dist = #(pCoords - coords)
        if dist > 20.0 then
          MumbleRemoveVoiceTargetPlayer(2, k)
          connected[k] = nil
        end
      end
    end
  end
end)

-- -- Thread:Create(function()
-- --     while true do
-- --         Wait(0)
-- --         Text:Draw('(0004) Micheal Jackson', {
-- --             x = 0.93,
-- --             y = 0.03
-- --         })
-- --     end
-- -- end)

Thread:Create(function()
  while true do
    Wait(0)
    if isTalkingRadio and radio > 0 then
      SetControlNormal(0, 249, 1.0)
      SetControlNormal(1, 249, 1.0)
      SetControlNormal(2, 249, 1.0)
    end
  end
end)

Key:onJustPressedAndReleased("CAPITAL", "Radio", function()
  if radio <= 0 then
    return
  end
  isTalkingRadio = true
  lasttalk = talk
  talk = TR("on_radio")
  local volume = DWB.UISettings["radio-volume"] or 1.0
  MumbleSetVolumeOverride(PlayerId(), volume)
  SetPlayerTalkingOverride(PlayerId(), true)
  Event:TriggerNet("dwb:voice:radio:toggle", radio, true)
  Sound:Play("ron", 0.5)
  -- if User:HasJob({'police'}) then
  Animation:Play(
    PlayerPedId(),
    "amb@code_human_police_investigate@idle_a",
    "idle_b",
    1.5,
    1.5,
    -1,
    51,
    1.0
  )
  -- else
  --     Animation:Play(PlayerPedId(), "random@arrests", "generic_radio_enter", 1.5, 1.5, -1, 50, 1.0)
  -- end
end, function()
  if radio <= 0 then
    return
  end
  MumbleSetVolumeOverride(PlayerId(), -1.0)
  SetPlayerTalkingOverride(PlayerId(), false)
  isTalkingRadio = false
  Event:TriggerNet("dwb:voice:radio:toggle", radio, false)
  talk = lasttalk
  Sound:Play("roff", 0.5)
  ClearPedTasks(PlayerPedId())
end)

Event:Register("dwb:radio:show", function()
  UI:CloseAll()
  local count = 0
  for k, v in pairs(radioTargets) do
    count = count + 1
  end
  Animation:Play(PlayerPedId(), "cellphone@", "cellphone_text_in", 4.0, 1.5, -1, 50, 1.0)

  UI:Open("Radio", {
    name = "radio",
    show = true,
    ppl = count,
    hz = radio,
  }, function(data, menu)
    menu.close()
    -- local job = User:GetJob({'police', 'ambulance', 'mechanic'})
    if data.hz ~= "" or data.hz == 0 then
      -- if tonumber(data.hz) ~= 0 and tonumber(data.hz) <= 10 and not job then
      --     return Notification:ShowCustom('info', 'Radio', 'Kanały zabezpieczone')
      -- end
      radio = tonumber(data.hz)
      MumbleSetVoiceChannel(radio)
      MumbleAddVoiceTargetChannel(2, radio)
      Event:TriggerNet("dwb:voice:radio:set", radio)
    else
      radio = tonumber(0)
      MumbleSetVoiceChannel(radio)
      MumbleAddVoiceTargetChannel(2, radio)

      Event:TriggerNet("dwb:voice:radio:set", radio)
    end
    ClearPedTasks(PlayerPedId())
  end, function(data, menu)
    ClearPedTasks(PlayerPedId())

    menu.close()
  end)
end, true)

local talkingTargets = {}

Event:Register("dwb:voice:radio:sync", function(ppl, toggle, data)
  if toggle == nil then
    radioTargets = {}
    for k, v in pairs(ppl) do
      radioTargets[v] = false
    end
    -- radioTargets[player] = false
  else
    radioTargets[ppl] = toggle
    if data then
      if toggle then
        talkingTargets[ppl] = data
        local content = {}
        for k, v in pairs(talkingTargets) do
          table.insert(content, {
            text = v.name,
          })
        end
        -- -- -- -- print(json.encode(content))
        UI:Open("Text", {
          name = "text",
          show = true,
          containerClass = "w-full h-3/4 flex justify-start items-end flex-col gap-2 p-2 overflow-auto max-h-3/4",
          defaultClass = "bg-black rounded-lg p-0.5 text-white",
          content = content,
        })
      else
        talkingTargets[ppl] = nil
        local one = false
        local content = {}
        for k, v in pairs(talkingTargets) do
          one = true
          table.insert(content, {
            text = v.name,
          })
        end
        if not one then
          UI:Close("Text", {
            name = "text",
            show = true,
            containerClass = "w-full h-1/4 flex justify-start items-end flex-col gap-2 p-2 overflow-auto max-h-1/4",
            defaultClass = "bg-black rounded-lg p-0.5 text-white",
            content = content,
          })
        else
          UI:Open("Text", {
            name = "text",
            show = true,
            containerClass = "w-full h-1/4 flex justify-start items-end flex-col gap-2 p-2 overflow-auto max-h-1/4",
            defaultClass = "bg-black rounded-lg p-0.5 text-white",
            content = content,
          })
        end
      end
    end
  end
end, true)

-- AddStateBagChangeHandler("radioChannel", nil, function(bagName, key, value)
--     local player = GetPlayerFromStateBagName(bagName)
--     if value == radio then
--         player = GetPlayerServerId(player)
--         radioTargets[player] = false
--     end
-- end)

-- AddStateBagChangeHandler("radioToggle", nil, function(bagName, key, value)
--     local player = GetPlayerFromStateBagName(bagName)
--     player = GetPlayerServerId(player)
--     local radioCh = Player(player).state.radioChannel
--     if radioCh ~= radio then return end
--     radioTargets[player] = value
-- end)
