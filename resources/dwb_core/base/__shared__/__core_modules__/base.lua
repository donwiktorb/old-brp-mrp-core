CustomEvents = class()
CustomEvents.Events = {}

function CustomEvents:On(event, cb)
  if not CustomEvents.Events[event] then
    CustomEvents.Events[event] = {}
  end
  table.insert(CustomEvents.Events[event], cb)
end

function CustomEvents:Trigger(event, ...)
  if not CustomEvents.Events[event] then
    return
  end

  for k, v in pairs(CustomEvents.Events[event]) do
    v(...)
  end
end
