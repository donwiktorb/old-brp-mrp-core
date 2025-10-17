local particleDict = "core"
local particleName = "exp_grd_grenade_smoke"
local particleNameStart = "ent_brk_sparking_wires"

Event:Register("dwb:smoke:start", function(front, coords)
  Particles:StartLoopCoord(particleDict, particleNameStart, front, function()
    Particles:StartLoopCoord(particleDict, particleName, coords, false, 5)
  end, 5)
end, true)

function openBar()
  UI:Open("Bar", {
    name = "tanksmoke",
    task = "Ładowanie flar dymnych",
    time = 40,
  }, function(data, menu)
    launched = false
  end)
end

Key:onJustPressed("L", "Wyrzuć flary", function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped)
  local model = GetEntityModel(veh)
  if not launched and veh ~= 0 and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) then
    launched = true
    local coords = GetEntityCoords(veh)
    local forward = GetEntityForwardVector(veh)
    local front = (coords + forward * 2.0) + vector(0, 0, 2)
    local fixed = coords + forward * 20.0
    Event:TriggerNet("dwb:smoke:start", front, fixed)
    openBar()
  end
end)

