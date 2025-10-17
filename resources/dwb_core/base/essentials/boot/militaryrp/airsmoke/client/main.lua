local particleDict = "core"
local particleName = "exp_grd_grenade_smoke"
local particleNameStart = "ent_brk_sparking_wires"
local flarehash = GetHashKey("weapon_flaregun")
local launched = false
local times = 4

Event:Register('dwb:airsmoke:start', function(front, coords)
    Particles:StartLoopCoord(particleDict, particleNameStart, front, function()
        Particles:StartLoopCoord(particleDict, particleName, coords, false, 5)
    end, 5)
end, true)

local shots = {
    {
        offset = vector3(-6.0, -4.0, -0.2),
    },
    {
        offset = vector3(-3.0, -4.0, -0.2)
    },
    {
        offset = vector3(6.0, -4.0, -0.2)
    },
    {
        offset = vector3(3.0, -4.0, -0.2)
    }
}

function openBar2()
    UI:Open('Bar', {
        name = 'airsmoke',
        task = 'Ładowanie flar',
        time = 40
    }, function(data,menu)
        launched =  false      
    end)
end

Key:onJustPressed('Y', 'Wyrzuć flary (samolot)', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
	local model = GetEntityModel(veh)
    
    if veh ~= 0 and (IsThisModelAHeli(model) or IsThisModelAPlane(model))  and not launched then
        launched = true
        Stream:RequestWeapon(flarehash, function()
            SetPlayerHomingRocketDisabled(PlayerId(), true)
            for i=0, 4 do
                Wait(500)
                for k,v in pairs(shots) do
                    local coords = GetEntityCoords(veh)
                    local offset = GetOffsetFromEntityInWorldCoords(veh, v.offset)
                    ShootSingleBulletBetweenCoordsWithExtraParams(coords, offset, 0, true, flarehash, ped, true, true, -4.0, veh, false, false, false, true, true, false)
                end
            end
            Wait(5000)
            SetPlayerHomingRocketDisabled(PlayerId(), false)
            openBar2()
        end)
        -- local front = (coords+forward*2.0)+vector(0,0,2)
        -- local fixed = coords+forward*20.0
        -- Event:TriggerNet('dwb:airsmoke:start', front, fixed)
    end

end)