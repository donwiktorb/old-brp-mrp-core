-- -- local playing = false

-- -- Thread:Create(function()
-- --     while true do
-- --         Wait(500)
-- --         for k,v in pairs(DWB.PlayerData.ClosestVehicles) do
-- --             if v.state.radio and not playing then
-- --                 SendNUIMessage({
-- --                     action     = 'startVideo',
-- --                     id = '2lpftnwdZTc' 
-- --                 })
-- --                 playing = true
-- --             elseif not v.state.radio and playing then
-- --                 SendNUIMessage({
-- --                     action     = 'stopVideo',
-- --                     id = '2lpftnwdZTc' 
-- --                 })
-- --                 playing = false
-- --             else
-- --                 local dist = v.dist
-- --                 local volume = math.max( 0, 100 - 100/15 * dist )
-- --                 SendNUIMessage({
-- --                     action     = 'setVolume',
-- --                     volume = volume
-- --                 })
-- --             end
-- --         end
-- --     end
-- -- end)

Key:onJustPressed('M', 'Radio samochod', function()
    if DWB.PlayerData.InVehicle then
        UI:Open('CarRadio', {
            name = 'car-radio'
        }, function(data,menu)
            menu.close()
            if data.type == 'stop' then
                Event:TriggerNet('dwb:vehicle:radio:stop', data.url)
            elseif data.url then
                Event:TriggerNet('dwb:vehicle:radio', data.url)
            end
        end)
    end
end)

RegisterNuiCallback('dwb_ui_youtube_time', function(data, cb)
    local time = data.time 
    if time and time > 0 then
    Event:TriggerNet('dwb:vehicle:radio:sync', time)
    end
    cb({})
end)

-- local playing = false
-- local currentVeh
-- Thread:Create(function()
--     while true do
--         Wait(500)
--         if DWB.PlayerData.InVehicle then
--             if not playing then
--                 local veh = DWB.PlayerData.Vehicle
--                 currentVeh = veh
--                 local radio = Entity(veh).state.radio
--                 local radioTime = Entity(veh).state.radioTime or 0
--                 if radio then
--                     local vol = Entity(veh).state.radioVolume
--                     playing = true
--                     SendNUIMessage({
--                         action     = 'loadVideo',
--                         url = radio,
--                         volume = 100,
--                         seek = radioTime
--                     })
--                 end
--             end
--         elseif playing then
--             playing = false
--             SendNUIMessage({
--                 action     = 'stopVideo'
--             })
--         end
--     end
-- end)
local vehicles = {}

local playing2 = false


RegisterNuiCallback('dwb_ui_youtube_end', function(data, cb)
    playing2 = false
    vehicles = {}
    cb({})
end)


Thread:Create(function()
    while true do
        Wait(1000)
        local coords = DWB.PlayerData.Coords
        for k2,v2 in pairs(vehicles) do
            if not DoesEntityExist(v2.vehicle) and v2.playing then
                playing2 = false
                v2.playing = false                    
                vehicles[k2] = nil
                SendNUIMessage({
                    action     = 'stopVideo',
                    id = '2lpftnwdZTc' ,
                    log = true
                })
                goto continue
            end

            local v = Entity(v2.vehicle)
            local radio = v.state.radio
            local radioTime = v.state.radioTime or 0
            local vol = v.state.radioVolume
            local vehCoords = GetEntityCoords(v2.vehicle)
            local dist = #(vehCoords-coords)
            local volume = math.min(math.max( 0, 100 - 100/15 * dist ), DWB.UISettings['car-radio-volume'] or 70)

            if not radio then
                if playing2 and v2.playing then
                    playing2 = false
                    v2.playing = false                    
                    vehicles[k2] = nil
                    SendNUIMessage({
                        action     = 'stopVideo',
                        id = '2lpftnwdZTc' 
                    })
                    goto continue
                end
            end
            
            if dist <= 15.0 then
                
                if not playing2 then
                    v2.playing = true
                    SendNUIMessage({
                        action     = 'loadVideo',
                        url = radio,
                        volume = volume,
                        seek = radioTime,
                        log = true
                    })
                    playing2 = true
                else
                    SendNUIMessage({
                        action     = 'setVolume',
                        volume = volume
                    })
                end
            elseif v2.playing and playing2 then
                playing2 = false
                v2.playing = false
                vehicles[k2] = nil

                SendNUIMessage({
                    action     = 'stopVideo',
                    id = '2lpftnwdZTc' ,
                        log = true
                })
            end
            ::continue::
        end
    end
end)

Thread:Create(function()
    while true do
        Wait(1000)
        for k,v in pairs(DWB.PlayerData.ClosestVehicles) do
            local radio = v.state.radio
            -- local radioTime = v.state.radioTime or 0
            -- local vol = v.state.radioVolume

            if radio and not vehicles[v.vehicle] then
                vehicles[v.vehicle] = {
                    vehicle = v.vehicle
                }
            end

            -- if radio then
            --     local dist = v.dist
            --     if not playing2 then
            --         if dist <= 10.0 then
            --             local volume = math.max( 0, 100 - 100/15 * dist )
            --             SendNUIMessage({
            --                 action     = 'loadVideo',
            --                 url = radio,
            --                 volume = volume,
            --                 seek = radioTime
            --             })
            --             playing2 = true
            --         end
            --     else
            --         if dist <= 10.0 then
            --             local volume = math.max( 0, 100 - 100/15 * dist )
            --             SendNUIMessage({
            --                 action     = 'setVolume',
            --                 volume = volume
            --             })
            --         else
            --             SendNUIMessage({
            --                 action     = 'stopVideo',
            --                 id = '2lpftnwdZTc' 
            --             })
            --             playing2 = false
            --         end
            --     end
            -- end

            -- if radio and not playing2 then
            --     local dist = v.dist
            --     if dist <= 15.0 then
            --         local volume = math.max( 0, 100 - 100/15 * dist )
            --         SendNUIMessage({
            --             action     = 'loadVideo',
            --             url = radio,
            --             volume = volume,
            --             seek = radioTime
            --         })
            --         playing2 = true
            --     end
            -- -- elseif not radio and playing2 then
            -- --     SendNUIMessage({
            -- --         action     = 'stopVideo',
            -- --         id = '2lpftnwdZTc' 
            -- --     })
            -- --     playing2 = false
            -- elseif playing2 then
            --     local dist = v.dist
            --     if dist <= 15.0 then
            --         local volume = math.max( 0, 100 - 100/15 * dist )
            --         SendNUIMessage({
            --             action     = 'setVolume',
            --             volume = volume
            --         })
            --     else
            --         SendNUIMessage({
            --             action     = 'stopVideo',
            --             id = '2lpftnwdZTc' 
            --         })
            --         playing2 = false
            --     end
            -- end
        end
    end
end)