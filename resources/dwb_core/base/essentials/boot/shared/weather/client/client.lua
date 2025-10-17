local lastWeather
local hour = 0
local min = 0
local seconds = 0

Thread:Create(function()
  SetWeatherOwnedByNetwork(true)
  SetRainLevel(0)
  NetworkOverrideClockMillisecondsPerGameMinute(1000 * 60)
  while true do
    Wait(1000)

    NetworkOverrideClockTime(hour, min, seconds)
  end
end)

Event:Register("dwb:ws:update", function(time, weather, last, blackout)
  if time then
    hour = time.hour
    min = time.min
    seconds = time.sec
  end

  if weather or not lastWeather then
    weather = weather or last
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    Wait(2000)
    if not lastWeather or lastWeather ~= weather then
      lastWeather = weather
      SetWeatherTypeOvertimePersist(weather, 2.0)
      Citizen.Wait(2000)
    end
    SetBlackout(blackout)
    SetWeatherTypePersist(lastWeather)
    SetWeatherTypeNow(lastWeather)
    SetWeatherTypeNowPersist(lastWeather)
    if lastWeather == "XMAS" then
      SetForceVehicleTrails(true)
      SetForcePedFootstepsTracks(true)
    else
      SetForceVehicleTrails(false)
      SetForcePedFootstepsTracks(false)
    end
  end
end, true)

-- local CurrentWeather = 'EXTRASUNNY'
-- local lastWeather = CurrentWeather
-- local blackout = false

-- Event:Register('dwb:ws:updateWeather', function(NewWeather, newblackout)
--     CurrentWeather = NewWeather
--     blackout = newblackout
-- end, true)

-- Event:Register('dwb:ws:updateTime', function(hour, minute)
--     NetworkOverrideClockTime(hour, minute, 0)

-- end, true)

-- Thread:Create(function()
--     while true do
--         if lastWeather ~= CurrentWeather then
--             lastWeather = CurrentWeather
--             SetWeatherTypeOverTime(CurrentWeather, 15.0)
--             Citizen.Wait(15000)
--         end
--         Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
--         SetBlackout(blackout)
--         ClearOverrideWeather()
--         ClearWeatherTypePersist()
--         SetWeatherTypePersist(lastWeather)
--         SetWeatherTypeNow(lastWeather)
--         SetWeatherTypeNowPersist(lastWeather)
--         if lastWeather == 'XMAS' then
--             SetForceVehicleTrails(true)
--             SetForcePedFootstepsTracks(true)
--         else
--             SetForceVehicleTrails(false)
--             SetForcePedFootstepsTracks(false)
--         end
--     end
-- end)

-- Event:Register('dwb:player:loaded', function(xPlayer)
--     Event:TriggerNet('dwb:ws:requestSync')
-- end,true)

-- AddEventHandler('onClientResourceStart', function(resourceName)
--     if resourceName == GetCurrentResourceName() then
--         Event:TriggerNet('dwb:ws:requestSync')

--     end
-- end)
