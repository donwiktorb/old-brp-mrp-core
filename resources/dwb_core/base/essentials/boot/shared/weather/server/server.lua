TimeSync:Start()
local hour = 1
local blackout = false

local lastWather

Thread:Create(function()
  local time = os.date("*t")
  time.hour = time.hour + 6
  local weather

  if time.hour > 23 then
    time.hour = 0
  end

  if time.hour ~= hour then
    weather =
      Config.TimeSync.AllowedWeatherTypes[math.random(1, #Config.TimeSync.AllowedWeatherTypes)]
    hour = time.hour
  end

  --GlobalState.hour = time.hour
  --GlobalState.min = time.min

  --Event:TriggerNet("dwb:ws:update", -1, time, weather, blackout)
  --Event:Trigger("dwb:weather:changed", weather)
end)
--
Event:Register("dwb:tick:minute", function(minute)
  local time = os.date("*t")
  local weather

  time.hour = time.hour + 6

  if time.hour > 23 then
    time.hour = 0
  end

  if time.hour ~= hour then
    weather =
      Config.TimeSync.AllowedWeatherTypes[math.random(1, #Config.TimeSync.AllowedWeatherTypes)]
    hour = time.hour
  end

  lastWather = weather

  -- GlobalState.hour = time.hour
  -- GlobalState.min = time.min

  -- Event:TriggerNet("dwb:ws:update", -1, time, weather, lastWather, blackout)
  -- Event:Trigger("dwb:weather:changed", weather)
end)

Command:Register("blackout", { "blackout" }, function(xPlayer, a)
  blackout = not blackout
end, { "superadmin", "admin" })
