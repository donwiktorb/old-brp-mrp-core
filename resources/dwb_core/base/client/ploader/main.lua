
-- local scripts = {}
-- local threads = {}
-- local currentResource = "none"
-- local makeThread = Thread:Create

-- function startThread(f, ...)
--     local th = coroutine.create(f)
--     table.insert(threads, {
--         th = th,
--         name = currentResource,
--         stopped = false
--     })
--     return coroutine.resume(th, ...)
-- end

-- Thread:Create(function()
--     while true do
--         Citizen.Wait(0)

--         -- Here is more or less the actual scheduling
--         for k,v in pairs(threads) do
--             local th = v.th
--             local stopped = v.stopped
--             if stopped or coroutine.status(th) == "dead" then
--                 -- The thread has ended (error or function returned)
--                 threads[k] = nil
--             else
--                 -- Thread is still alive, let's resume it
--                 local s,e = coroutine.resume(th)
--                 if not s then
--                     error("Thread error:",e)
--                 end
--             end
--         end
--     end
-- end)

-- Thread:Create = startThread

-- function setHook(f, key, quota)
--     if type(debug) ~= 'table' or type(debug.sethook) ~= 'function' then return end
--     debug.sethook(f, key, quota)
-- end

-- function runSandbox(name, code)
--     local _env = _ENV
--     currentResource = name
--     local f = assert(load(code, nil, 't', _env))
--     local t = table.pack(pcall, f)
--     if not t[1] then error(t[2]) end
--     return table.unpack(t, 2, t.n)()
-- end

-- RegisterNetEvent('dwb:scripts:receive')
-- AddEventHandler('dwb:scripts:receive', function(data)
--     for k,v in pairs(data) do
--         runSandbox(v.sName, v.code)
--     end
-- end)

-- TriggerServerEvent('dwb:scripts:request')

-- RegisterNetEvent('dwb:scripts:stop')
-- AddEventHandler('dwb:scripts:stop', function(name)
--     for k,v in pairs(threads) do
--         if v.name == name then
--             v.stopped = true
--             print('Resource', v.name, 'has been stopped')
--         end
--     end
-- end)

-- RegisterNetEvent('dwb:scripts:reset')
-- AddEventHandler('dwb:scripts:reset', function(names, cache)
--     for k,v in pairs(threads) do
--         for n,m in pairs(names) do
--             if v.name == m then
--                 v.stopped = true
--             end
--         end
--     end
--     Wait(200)
--     for k,v in pairs(cache) do
--         for n,m in pairs(names) do
--             print(v.sName, m)
--             if m == v.sName then
--                 runSandbox(v.sName, v.code)
--             end
--         end
--     end
-- end)

-- RegisterNetEvent('dwb:scripts:reset:all')
-- AddEventHandler('dwb:scripts:reset:all', function(data)
--     for k,v in pairs(threads) do
--         v.stopped = true
--     end
--     Wait(200)
--     for k,v in pairs(data) do
--         runSandbox(v.sName, v.code)
--     end
-- end)
