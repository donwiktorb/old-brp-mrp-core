
-- function User:GetPedCoords()
--     local ped = GetPlayerPed(self.source)
--     return GetEntityCoords(ped), GetEntityHeading(ped)
-- end

-- local lastobj

-- Event:Register('dwb:mine:spawn', function(forward)
--     local xPlayer = DWB.Players[source]
--     local coords = xPlayer:GetPedCoords()
--     local name = 'prop_snow_oldlight_01b'
--     local id = Math:GetUniqueId(8)
--     local coords = coords-vector3(0,0,1.5)
--     local coords = (coords+forward*1.0)
--     Object:Create(name, coords, function(obj)
--         print(id)
--         print(obj )
--         Event:TriggerNet('dwb:mines', -1, obj, id, coords)
--     end)
-- end, true)

-- Event:Register('dwb:mine:remove', function(obj)
--     DeleteEntity(obj)
-- end, true)

-- -- Command:Register('mine', {'Spawn mine', {name = 'name'}}, function(xPlayer, args)
-- --     local coords, heading = xPlayer:GetPedCoords()
-- --     local name = args[1] or 'prop_snow_oldlight_01b'
-- --     local id = Math:GetUniqueId(8)
-- --     local coords = coords-vector3(0,0,1.5)
-- --     Object:Create(name, coords, function(obj)
-- --         lastobj = obj
-- --         Event:TriggerNet('dwb:mines', -1, obj, id, coords)
-- --     end)
-- -- end, {'superadmin', 'admin'})

-- Command:Register('delall', {'del mine'}, function(xPlayer, args)
--     local objs = GetAllObjects()
--     for k,v in pairs(objs) do
--         DeleteEntity(v)
--     end
-- end, {'superadmin', 'admin'})

