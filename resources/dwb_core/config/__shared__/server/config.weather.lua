Config.TimeSync = {}

-- TimeSync.TimeUpdate = 4000
-- TimeSync.WeatherUpdate = 4000
Config.TimeSync.TimeUpdate = 16 * 1000
Config.TimeSync.WeatherChange = 28 * 1000

Config.TimeSync.AllowedWeatherTypes = {
  "EXTRASUNNY",
  "CLEAR",
  "SMOG",
  "FOGGY",
  "OVERCAST",
  "CLOUDS",
  "CLEARING",
  -- 'RAIN',
  -- 'THUNDER',
}

Config.TimeSync.WeatherTypes = {
  "EXTRASUNNY",
  "CLEAR",
  "NEUTRAL",
  "SMOG",
  "FOGGY",
  "OVERCAST",
  "CLOUDS",
  "CLEARING",
  "RAIN",
  "THUNDER",
  "SNOW",
  "BLIZZARD",
  "SNOWLIGHT",
  "XMAS",
  "HALLOWEEN",
}

Config.TimeSync.Default = {
  weather = Config.TimeSync.AllowedWeatherTypes[math.random(
    1,
    #Config.TimeSync.AllowedWeatherTypes
  )],
  hour = math.random(0, 23),
  min = math.random(0, 59),
}
