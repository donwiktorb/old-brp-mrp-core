Text = class()

Text.DrawThese3d = {}

function Text:DrawMission(msg, time)
  ClearPrints()
  BeginTextCommandPrint("STRING")
  AddTextComponentSubstringPlayerName(msg)
  EndTextCommandPrint(time, true)
end

function Text:AddDraw3d(name, coords, maxDist, text, data)
  table.insert(self.DrawThese3d, {
    name = name,
    text = text,
    data = data,
    coords = coords,
    maxDist = maxDist,
  })
end

function Text:RemoveDraw3d(name)
  for k, v in pairs(self.DrawThese3d) do
    if v.name == name then
      table.remove(self.DrawThese3d, k)
    end
  end
end

function Text:Draw(text, data)
  local font = data.font or 4

  SetTextFont(font)
  SetTextProportional(0)

  SetTextScale(data.scale and data.scale.x or 0.0, data.scale and data.scale.y or 0.5)

  local r, g, b, a = data.r or 255, data.g or 255, data.b or 255, data.a or 255

  SetTextColour(r, g, b, a)

  SetTextEdge(1, 0, 0, 0, 255)

  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(true)

  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(data.x or 0.5, data.y or 0.8)
end

function Text:Draw3D(coords, text, data)
  local data = data or {}
  local camCoords = GetGameplayCamCoords()
  local distance = #(coords - camCoords)

  local size = data.size
  local font = data.font

  if not size then
    size = 1
  end
  if not font then
    font = 0
  end

  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = ((size / distance) * 2) * fov

  SetTextScale(0.0 * scale, 0.55 * scale)
  SetTextFont(font)

  local r, g, b, a = data.r or 255, data.g or 255, data.b or 255, data.a or 255

  SetTextColour(r, g, b, a)

  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(true)

  SetDrawOrigin(coords, 0)
  BeginTextCommandDisplayText("STRING")
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText(0.0, 0.0)
  ClearDrawOrigin()
end
