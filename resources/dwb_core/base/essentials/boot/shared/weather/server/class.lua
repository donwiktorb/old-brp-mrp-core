TimeSync = class(CustomEvents)

TimeSync.state = Config.TimeSync.Default

function TimeSync:Start()
  Thread:Create(function()
    while true do
      TimeSync.state.min = (TimeSync.state.min + 1) % 60

      if TimeSync.state.min == 0 then
        TimeSync.state.hour = (TimeSync.state.hour + 1) % 24
        TimeSync:Trigger("hour", TimeSync.state.hour)
        if TimeSync.state.hour == 0 then
          TimeSync:Trigger("day")
        end
      end

      GlobalState.hour = TimeSync.state.hour
      GlobalState.min = TimeSync.state.min
      Wait(Config.TimeSync.TimeUpdate)
    end
  end)
end

TimeSync:On("hour", function(hour)
  local prevHour = hour - 1
  print("hour", hour, prevHour)
end)
