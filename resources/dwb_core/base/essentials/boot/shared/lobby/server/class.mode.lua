Mode = class({ modes = {} })

function Mode:Init()
  for k, v in pairs(Config.Lobby.Modes) do
    if v.data and v.data.mode then
      Mode.modes[v.data.mode] = {
        players = {},
      }
    end
  end
end

function Mode:TriggerEvent(mode, name, ...)
  for k, v in pairs(self.modes[mode].players) do
    print(k)
    Event:TriggerNet(name, k, ...)
  end
end
function Mode:Joined(source, mode)
  self.modes[mode].players[source] = DWB.Players[source]
end

function Mode:Left(source, mode)
  if not mode then
    return
  end
  print(source, mode)
  self.modes[mode].players[source] = nil
end

Mode:Init()
