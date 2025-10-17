


Config.Items.Effects = {
    ['drink'] = {
        animations = {
            putOn = {
                lib = "",
                anim = "",
                flag = 4
            },


            putOff = {
                lib = "",
                anim = "",
                flag = 4
            }
        },
        clientFunction = function(data, item)
            if not item.times then
                item.times = 0
            end
            if not item.times2 then
                item.times2 = 0
            end
            item.times = item.times + item.modifier or 10
            item.times2 = item.times2 + item.modifier2 or 10

            local ped = PlayerPedId()
            RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK")

            while not HasAnimSetLoaded("MOVE_M@DRUNK@MODERATEDRUNK") do
                Citizen.Wait(0)
            end

            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRINKING", 0, true)

            Citizen.Wait(5000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)

            ClearPedTasks(ped)

            SetTimecycleModifier(item.modifierName)

            SetPedMotionBlur(ped, true)

            SetPedMovementClipset(ped, "MOVE_M@DRUNK@MODERATEDRUNK", true)

            SetPedIsDrunk(ped, true)

            SetTimecycleModifierStrength(item.times)

            if item.modifiers then
                for k,v in pairs(item.modifiers) do
                    SetTimecycleModifierVar(v.modifierName, v.varName, v.value1, v.value2)
                end
                SetExtraTimecycleModifierStrength(item.modifier2)
            end

            DoScreenFadeIn(1000)

            Citizen.Wait(item.time)
            
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)

            DoScreenFadeIn(1000)
            
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(ped, 0)
            SetPedIsDrunk(ped, false)
            SetPedMotionBlur(ped, false)
            ResetExtraTimecycleModifierStrength()
        end,
    }
}

Config.Items.Usable = {
        -- {
        --     messages = {
        --         putOn = "Zakładasz kamizelkke",
        --         putOff = "Ściągasz kamizelkę"
        --     },
        --     clientFunction = function()
        --         if Thread:Exists('bino') then
        --             Thread:Remove('bino')
        --             Cam:Destroy('showBin')
        --             ClearPedTasks(PlayerPedId())
        --         else
        --             Thread:Create('bino', function()
        --                 local scaleform = Scaleform:Request('BINOCULARS') 
        --                 BeginScaleformMovieMethod(scaleform, "SET_CAM_LOGO")
        --                 ScaleformMovieMethodAddParamInt(0) -- 0 for nothing, 1 for LSPD logo
        --                 EndScaleformMovieMethod()
        --                 Cam:CreateEntity('showBin', false, true, PlayerPedId(), {
        --                     fovMin = 5.0,
        --                     fovMax = 80.0,
        --                     speedLR = 4.0,
        --                     speedUD = 4.0,
        --                     zoomSpeed=  3.0,
        --                     offsetZ = 1.0,
        --                     rotatePed = true
        --                 })
        --                 TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
        --                 while true do
        --                     Wait(0)
        --                     DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        --                 end
        --             end)
        --         end
        --     end,
        --     serverFunction = function(self)

        --     end,
        --     addItems = {
        --         ['weed'] = 1
        --     },
        --     removeAfterUse = true,
        --     removeAmount = 1,
        --     timer = 30,
        --     trackUsage = true,
        --     items = {
        --         {
        --             name = 'water',
        --             timer = 30,
        --             value = 20
        --         }
        --     },
        --     animations = {
        --         putOn = {
        --             lib = "",
        --             anim = "",
        --             flag = 4
        --         },
        --         putOff = {
        --             lib = "",
        --             anim = "",
        --             flag = 4
        --         }
        --     },
        --     clothes = {
        --         putOn = {
        --             male = {},
        --             female = {}
        --         },
        --         putOff = {
        --             ['bulletproof'] = true
        --         }
        --     }
        -- },
        -- {
        --     clientFunction = function()
        --         if Thread:Exists('bino') then
        --             Thread:Remove('bino')
        --             Cam:Destroy('showBin')
        --             ClearPedTasks(PlayerPedId())
        --         else
        --             Thread:Create('bino', function()
        --                 local scaleform = Scaleform:Request('BINOCULARS') 
        --                 BeginScaleformMovieMethod(scaleform, "SET_CAM_LOGO")
        --                 ScaleformMovieMethodAddParamInt(0) -- 0 for nothing, 1 for LSPD logo
        --                 EndScaleformMovieMethod()
        --                 Cam:CreateEntity('showBin', false, true, PlayerPedId(), {
        --                     fovMin = 5.0,
        --                     fovMax = 80.0,
        --                     speedLR = 4.0,
        --                     speedUD = 4.0,
        --                     zoomSpeed=  3.0,
        --                     offsetZ = 1.0,
        --                     rotatePed = true
        --                 })
        --                 TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
        --                 while true do
        --                     Wait(0)
        --                     DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        --                 end
        --             end)
        --         end
        --     end,
        --     removeAfterUse = false,
        --     timer = 30,
        --     trackUsage = false,
        --     items = {
        --         {
        --             name = 'binoculars'
        --         }
        --     },
        -- },
        -- {
        --     clientFunction = function(data, item)
        --         ClearPedTasks(PlayerPedId())
        --         AddArmourToPed(PlayerPedId(), item.armor)
        --     end,
        --     removeAfterUse = true,
        --     removeAmount = 1,
        --     timer = 30,
        --     trackUsage = false,
        --     items = {
        --         {
        --             name = 'bulletproof',
        --             armor = 200
        --         }
        --     },
        --     animations = {
        --         putOn = {
        --             lib = "",
        --             anim = "",
        --             flag = 4
        --         },
        --         putOff = {
        --             lib = "",
        --             anim = "",
        --             flag = 4
        --         }
        --     },
        -- },
        -- {
        --     clientFunction = function(data, item)
        --         if not item.times then
        --             item.times = 0
        --         end
        --         if not item.times2 then
        --             item.times2 = 0
        --         end
        --         item.times = item.times + item.modifier or 10
        --         item.times2 = item.times2 + item.modifier2 or 10

        --         local ped = PlayerPedId()
        --         RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK")

        --         while not HasAnimSetLoaded("MOVE_M@DRUNK@MODERATEDRUNK") do
        --             Citizen.Wait(0)
        --         end

        --         TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRINKING", 0, true)

        --         Citizen.Wait(5000)
        --         DoScreenFadeOut(1000)
        --         Citizen.Wait(1000)

        --         ClearPedTasks(ped)

        --         SetTimecycleModifier(item.modifierName)

        --         SetPedMotionBlur(ped, true)

        --         SetPedMovementClipset(ped, "MOVE_M@DRUNK@MODERATEDRUNK", true)

        --         SetPedIsDrunk(ped, true)

        --         SetTimecycleModifierStrength(item.times)

        --         if item.modifiers then
        --             for k,v in pairs(item.modifiers) do
        --                 SetTimecycleModifierVar(v.modifierName, v.varName, v.value1, v.value2)
        --             end
        --             SetExtraTimecycleModifierStrength(item.modifier2)
        --         end

        --         DoScreenFadeIn(1000)

        --         Citizen.Wait(item.time)
                
        --         DoScreenFadeOut(1000)
        --         Citizen.Wait(1000)

        --         DoScreenFadeIn(1000)
                
        --         ClearTimecycleModifier()
        --         ResetScenarioTypesEnabled()
        --         ResetPedMovementClipset(ped, 0)
        --         SetPedIsDrunk(ped, false)
        --         SetPedMotionBlur(ped, false)
        --         ResetExtraTimecycleModifierStrength()
        --     end,
        --     removeAfterUse = true,
        --     removeAmount = 1,
        --     -- timer = 30,
        --     trackUsage = true,
        --     items = {
        --         {
        --             name = 'whisky',
        --             armor = 200,
        --             modifierName = 'spectator8',
        --             modifier = 1.0,
        --             modifier2 = 1.0,
        --             time = 50000,
        --             modifiers = {
        --                 {
        --                     modifierName = 'superDARK',
        --                     varName = 'postfx_noise',
        --                     value1 = 1.0,
        --                     value2 = 1.0
        --                 }
        --             }
        --         }
        --     },
        --     -- animations = {
        --     --     putOn = {
        --     --         lib = "",
        --     --         anim = "",
        --     --         flag = 4
        --     --     },
        --     --     putOff = {
        --     --         lib = "",
        --     --         anim = "",
        --     --         flag = 4
        --     --     }
        --     -- },
        -- }
    }



Config.Usable = {}
Config.Usable.Items = { 
    ['water'] = { 
        water = 25,
        type = 'water'
    },
    ['cocacola'] = {
        water = 20,
        type = 'water'
    },
    ['whisky'] = {
        water = 5,
        type = 'water'
    },
    ['beer'] = {
        water = 5,
        type = 'water'
    },
    ['apple'] = {
        water = 15,
        hunger = 15,
        type = 'food'
    },
    ['banana'] = {
        water = 15,
        hunger = 15,
        type = 'food'
    },
    ['donut'] = {
        hunger = 15,
        type = 'food'
    },
    ['sprunk'] = {
        water = 20,
        type = 'water'
    },
    ['sandwich'] = {
        hunger = 25,
        type = 'food'
    },
    ['sandwich2'] = {
        hunger = 25,
        type = 'food'
    },
    ['champagne'] = {
        water = 5,
        type = 'water'
    },
    ['hotdog'] = {
        hunger = 20,
        type = 'food'
    },
    ['drink1'] = {
        water = 5,
        type = 'water'
    },
    ['drink2'] = {
        water = 5,
        type = 'water'
    },
    ['drink3'] = {
        water = 5,
        type = 'water'
    },
    ['drink4'] = {
        water = 5,
        type = 'water'
    },
    ['drink5'] = {
        water = 5,
        type = 'water'
    },
    ['drink6'] = {
        water = 5,
        type = 'water'
    },
    ['shot1'] = {
        water = 5,
        type = 'water'
    },
    ['shot2'] = {
        water = 5,
        type = 'water'
    },
    ['shot3'] = {
        water = 5,
        type = 'water'
    },
    ['shot4'] = {
        water = 5,
        type = 'water'
    },
    ['shot5'] = {
        water = 5,
        type = 'water'
    },
    ['shot6'] = {
        water = 5,
        type = 'water'
    },
    ['shot7'] = {
        water = 5,
        type = 'water'
    },
    ['shot8'] = {
        water = 5,
        type = 'water'
    },
    ['shot9'] = {
        water = 5,
        type = 'water'
    },
    ['shot10'] = {
        water = 5,
        type = 'water'
    },
 }