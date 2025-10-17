
-- local messages = {
--     -- onEnter = 'enter',
--     -- onClose = 'close',
--     -- onExit = 'exit'
-- }

-- UI:newFocus('DefuseMine', true)

-- Key:onJustPressed('M', 'Połóż minę', function()

--     local ped = PlayerPedId()
--     local forward = GetEntityForwardVector(ped)
--     Event:TriggerNet('dwb:mine:spawn', forward)

-- end)

-- local currentObj

-- Key:onJustPressed('O', 'Rozbrój minę', function()
--     local model = GetHashKey('prop_snow_oldlight_01b')
--     local ped = PlayerPedId()
--     local coords = GetEntityCoords(ped)
--     local obj = GetClosestObjectOfType(coords, 2.0, model, false, true, true)
--     print(obj )
--     if obj ~= 0 then
--         UI:Open('DefuseMine', {})
--         currentObj = obj
--     end
-- end)

-- RegisterNUICallback('mine_fail', function(data, cb)
--     -- local result = Marker:GetCoordsByKey('mine', {
--     --     key = 'obj',
--         UI:Close('DefuseMine', {})
    
--     --     value = currentObj
--     -- })
--     local ped = PlayerPedId()
--     local coords = GetEntityCoords(ped)
--     AddExplosion(coords, 4, 0.8, true, false, 8)
--     DeleteEntity(currentObj)
--     Marker:RemoveNonExistantObjects('mine')
--     -- Marker:RemoveCoordsByKey('mine', {
--     --     key = 'obj',
--     --     value = currentObj
--     -- })
--     -- Event:TriggerNet('dwb:mine:remove', currentObj)
--     currentObj = false

--     cb({})
-- end)

-- RegisterNUICallback('mine_success', function(data, cb)
    
--         UI:Close('DefuseMine', {})
--     DeleteEntity(currentObj)
--     Marker:RemoveNonExistantObjects('mine')
--     -- Marker:RemoveCoordsByKey('mine', {
--     --     key = 'obj',
--     --     value = currentObj
--     -- })
--     -- Event:TriggerNet('dwb:mine:remove', currentObj)
--     currentObj = false
--     cb({})
-- end)




-- -- UI:On('mine_success', function(data)
-- --     Marker:RemoveCoordsByKey('mine', {
-- --         key = 'obj',
-- --         value = currentObj
-- --     })
-- --     Event:TriggerNet('dwb:mine:remove', currentObj)
-- --     currentObj = false
-- -- end)

-- -- UI:On('mine_fail', function(data)
-- --     local result = Marker:GetCoordsByKey('mine', {
-- --         key = 'obj',
-- --         value = currentObj
-- --     })

-- --     AddExplosion(result.pos, 4, 0.8, true, false, 8)

-- --     Marker:RemoveCoordsByKey('mine', {
-- --         key = 'obj',
-- --         value = currentObj
-- --     })
-- --     Event:TriggerNet('dwb:mine:remove', currentObj)
-- --     currentObj = false
-- -- end)

-- RegisterCommand('mine', function()
-- end)

-- Event:Register('dwb:mines', function(obj, mineId, coords)
--     print(obj)
--     PlaceObjectOnGroundProperly(obj)
    
--     Marker:Add('mine', {
--         marker = {},
--         -- messages = messages,
--         settings = {
--             drawMarker = false,
--             drawDist = 20,
--             radius = 1.6,
--             overrideCoords = true
--         },
--         coords = {
--             {
--                 obj = obj,
--                 pos = coords
--             }     
--         },
--         functions = {
--             onClickCb = function(zone)
--                 print('clicked')
--             end,
--             onDrawDistEnter = function(zone)
--                 print('draw dist')
--             end,
--             onDrawDistExit = function(zone)
--                 print('exit')
--             end,
--             onCloseDist = function(zone)
--                 print('close')
--             end,
--             onEnterCb = function(zone, pos)
--                 print('enter')
--             end,
--             onExitCb = function(zone, pos)
--                 -- main 40 - mina 4 - rakieta
--                 print(zone, pos)
--                 AddExplosion(pos.pos, 4, 0.8, true, false, 8)
--                 Marker:RemoveCoordsByKey('mine', {
--                     key = 'obj',
--                     value = pos.obj
--                 })
--                 Event:TriggerNet('dwb:mine:remove', pos.obj)
                
--             end
--         }

--     })
-- end, true)

-- local bombs = {
--     DONTCARE = 0xFFFFFFFF,
--     GRENADE = 0,
--     GRENADELAUNCHER = 1,
--     STICKYBOMB = 2,
--     MOLOTOV = 3,
--     ROCKET = 4,
--     TANKSHELL = 5,
--     HI_OCTANE = 6,
--     CAR = 7,
--     PLANE = 8,
--     PETROL_PUMP = 9,
--     BIKE = 10,
--     DIR_STEAM = 11,
--     DIR_FLAME = 12,
--     DIR_WATER_HYDRANT = 13,
--     DIR_GAS_CANISTER = 14,
--     BOAT = 15,
--     SHIP_DESTROY = 16,
--     TRUCK = 17,
--     BULLET = 18,
--     SMOKEGRENADELAUNCHER = 19,
--     SMOKEGRENADE = 20,
--     BZGAS = 21,
--     FLARE = 22,
--     GAS_CANISTER = 23,
--     EXTINGUISHER = 24,
--     _0x988620B8 = 25,
--     EXP_TAG_TRAIN = 26,
--     EXP_TAG_BARREL = 27,
--     EXP_TAG_PROPANE = 28,
--     EXP_TAG_BLIMP = 29,
--     EXP_TAG_DIR_FLAME_EXPLODE = 30,
--     EXP_TAG_TANKER = 31,
--     PLANE_ROCKET = 32,
--     EXP_TAG_VEHICLE_BULLET = 33,
--     EXP_TAG_GAS_TANK = 34,
--     EXP_TAG_BIRD_CRAP = 35,
--     EXP_TAG_RAILGUN = 36,
--     EXP_TAG_BLIMP2 = 37,
--     EXP_TAG_FIREWORK = 38,
--     EXP_TAG_SNOWBALL = 39,
--     EXP_TAG_PROXMINE = 40,
--     EXP_TAG_VALKYRIE_CANNON = 41,
--     EXP_TAG_AIR_DEFENCE = 42,
--     EXP_TAG_PIPEBOMB = 43,
--     EXP_TAG_VEHICLEMINE = 44,
--     EXP_TAG_EXPLOSIVEAMMO = 45,
--     EXP_TAG_APCSHELL = 46,
--     EXP_TAG_BOMB_CLUSTER = 47,
--     EXP_TAG_BOMB_GAS = 48,
--     EXP_TAG_BOMB_INCENDIARY = 49,
--     EXP_TAG_BOMB_STANDARD = 50,
--     EXP_TAG_TORPEDO = 51,
--     EXP_TAG_TORPEDO_UNDERWATER = 52,
--     EXP_TAG_BOMBUSHKA_CANNON = 53,
--     EXP_TAG_BOMB_CLUSTER_SECONDARY = 54,
--     EXP_TAG_HUNTER_BARRAGE = 55,
--     EXP_TAG_HUNTER_CANNON = 56,
--     EXP_TAG_ROGUE_CANNON = 57,
--     EXP_TAG_MINE_UNDERWATER = 58,
--     EXP_TAG_ORBITAL_CANNON = 59,
--     EXP_TAG_BOMB_STANDARD_WIDE = 60,
--     EXP_TAG_EXPLOSIVEAMMO_SHOTGUN = 61,
--     EXP_TAG_OPPRESSOR2_CANNON = 62,
--     EXP_TAG_MORTAR_KINETIC = 63,
--     EXP_TAG_VEHICLEMINE_KINETIC = 64,
--     EXP_TAG_VEHICLEMINE_EMP = 65,
--     EXP_TAG_VEHICLEMINE_SPIKE = 66,
--     EXP_TAG_VEHICLEMINE_SLICK = 67,
--     EXP_TAG_VEHICLEMINE_TAR = 68,
--     EXP_TAG_SCRIPT_DRONE = 69,
--     EXP_TAG_RAYGUN = 70,
--     EXP_TAG_BURIEDMINE = 71,
--     EXP_TAG_SCRIPT_MISSILE = 72,
--     EXP_TAG_RCTANK_ROCKET = 73,
--     EXP_TAG_BOMB_WATER = 74,
--     EXP_TAG_BOMB_WATER_SECONDARY = 75,
--     _0xF728C4A9 = 76,
--     _0xBAEC056F = 77,
--     EXP_TAG_FLASHGRENADE = 78,
--     EXP_TAG_STUNGRENADE = 79,
--     _0x763D3B3B = 80,
--     EXP_TAG_SCRIPT_MISSILE_LARGE = 81,
--     EXP_TAG_SUBMARINE_BIG = 82,
-- }

-- RegisterCommand('test', function()

--     while true do
--         Citizen.Wait(0)
--         local coords = GetEntityCoords(PlayerPedId())
--         for k,v in pairs(bombs) do
--             print('testing', k, v)
--             AddExplosion(coords, v, 0.9, true, false, 2.0)
--             Citizen.Wait(2000)
--         end
--     end

-- end)