
-- Event:Register('dwb:player:state:spawned', function()

--     Log:Info("[Loadingscreen callback]", "loadMeIn")
--     ShutdownLoadingScreenNui()
--     ShutdownLoadingScreen()
--     DoScreenFadeIn(500)

--     -- SendLoadingScreenMessage(json.encode({
--     --     type = 'Loadingscreen',
--     --     name = 'loadingscreen',
--     --     action = 'playerLoaded',
--     --     data = {}
--     -- }))
--     -- UI:Action('Loadingscreen', 'loadingscreen', 'playerLoaded', {

--     -- })
--     -- ShutdownLoadingScreenNui()
-- end, false)

-- Event:Register('dwb:player:loaded', function()

--     Log:Info("[Loadingscreen callback]", "loadMeIn")
--     ShutdownLoadingScreenNui()
--     ShutdownLoadingScreen()
--     DoScreenFadeIn(500)

--     -- SendLoadingScreenMessage(json.encode({
--     --     type = 'Loadingscreen',
--     --     name = 'loadingscreen',
--     --     action = 'playerLoaded',
--     --     data = {}
--     -- }))
--     -- UI:Action('Loadingscreen', 'loadingscreen', 'playerLoaded', {

--     -- })
--     -- ShutdownLoadingScreenNui()
-- end, true)

-- RegisterNUICallback('loadMeIn', function(data, cb)
--     Log:Info("[Loadingscreen callback]", "loadMeIn")
--     ShutdownLoadingScreenNui()
--     ShutdownLoadingScreen()
--     DoScreenFadeIn(500)
--     UI:Action('INIT', 'INIT', 'shutLoadingscreen', {})
--     cb({})
-- end)

-- UI:Action('Loadingscreen', 'loadingscreen', 'loadMeIn', {

-- })

-- AddEventHandler('onClientResourceStart', function(res)
--     if res == GetCurrentResourceName() then
--         Wait(4000)
--         UI:Action('Loadingscreen', 'loadingscreen', 'loadMeIn', {

--         })
--     end
-- end)

