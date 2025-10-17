-- Core = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/core')
-- Mysql = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/mysql')
-- Test = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/test')
-- Discord = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/discord')
-- Event = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/event')
-- Command = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/commands')
-- Job = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/job')
-- Item = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/item')
-- Vehicle = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/vehicle')
-- Object = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/object')
-- Logis = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/logis')
-- KNN = use('server', GetCurrentResourceName(), 'base/server/__core_modules__/knn')

-- -- if GetResourceState('dwb_api') ~= 'started' then
-- --     StartResource('dwb_api')

-- -- end

-- -- Thread:Create(function()
-- --     local ped5 = CreatePed("ped", `mp_m_freemode_01`, -44.2, 1817.78, 27.5, 250.0, true,true)

-- --     while not DoesEntityExist(ped5) do
-- --         print(ped5)
-- --         Wait(0)
-- --     end
-- --     SetEntityRoutingBucket(ped5, 0)
    
-- --     print(GetEntityCoords(ped5))
-- --     FreezeEntityPosition(ped5, true)
-- --     -- for i=300,330  do
-- --     --     SetPedConfigFlag(ped5, i, true)
-- --     --     print(i)
-- --     -- end
-- -- end)