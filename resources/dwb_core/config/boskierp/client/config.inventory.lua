Config.Inventory = {}

Config.Inventory.Functions = {
    ['coordsCb'] = function(coords2, radius)
        local ped = DWB.PlayerData.Ped
        local coords = GetEntityCoords(ped)
        local dist = #(coords2- coords) 
        if dist > radius then
            Notification:ShowCustom('info', TR("hunting"), TR("not_in_hunting_zone"))
        end
        return dist <= radius
    end
}

Config.Inventory.ItemCallbacks = {
    ['weapon_sniperrifle'] = {
        cb = 'coordsCb',
        args = {
            vec3(-1338.213013, 4602.840820, 138.716705),
            200.0
        }
    }
}

Config.Inventory.Animations = {
    ['weapon_fraction'] = {
        dict = 'rcmjosh4',
        dictOutro ='reaction@intimidation@cop@unarmed',
        pull = function()
            local ped = DWB.PlayerData.Ped
            Stream:RequestAnimDict(Config.Inventory.Animations.weapon_fraction.dict, function()
                TaskPlayAnim(ped, Config.Inventory.Animations.weapon_fraction.dict, 'josh_leadout_cop2', 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                Wait(500)
                ClearPedTasks(ped)
            end)
        end,
        hide = function()
            local ped = DWB.PlayerData.Ped
            Stream:RequestAnimDict(Config.Inventory.Animations.weapon_fraction.dictOutro, function()
                TaskPlayAnim(ped, Config.Inventory.Animations.weapon_fraction.dictOutro, "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                Wait(500)
                ClearPedTasks(ped)
            end)
        end,
        play = function()
            local played = Config.Inventory.Animations.weapon_fraction.played
            if not played then
                Config.Inventory.Animations.weapon_fraction.pull()
                Config.Inventory.Animations.weapon_fraction.played = true
            else
                Config.Inventory.Animations.weapon_fraction.hide()
                Config.Inventory.Animations.weapon_fraction.played = nil
            end
        end
    },
    ['weapon'] = {
        dict = "reaction@intimidation@1h",
        pull = function()
            local ped = DWB.PlayerData.Ped
            Stream:RequestAnimDict(Config.Inventory.Animations.weapon.dict, function()
                TaskPlayAnim(ped, Config.Inventory.Animations.weapon.dict, "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                Wait(2000)
                ClearPedTasks(ped)
            end)
        end,
        hide = function()
            local ped = DWB.PlayerData.Ped
            Stream:RequestAnimDict(Config.Inventory.Animations.weapon.dict, function()
                TaskPlayAnim(ped, Config.Inventory.Animations.weapon.dict, "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                Wait(2000)
                ClearPedTasks(ped)
            end)
        end,
        play = function()
            local played = Config.Inventory.Animations.weapon.played
            if not played then
                Config.Inventory.Animations.weapon.pull()
                Config.Inventory.Animations.weapon.played = true
            else
                Config.Inventory.Animations.weapon.hide()
                Config.Inventory.Animations.weapon.played = nil
            end
        end
    },
}

Config.Inventory.VehicleSlots = {
    [0] = 10,
    [1] = 15,
    [2] = 45,
    [3] = 15,
    [4] = 10,
    [5] = 10,
    [6] = 10,
    [7] = 10,
    [8] = 3,
    [9] = 25,
    [11] = 35,
    [12] = 60,
    [13] = 1,
    [14] = 35,
    [17] = 15,
    [18] = 15,
    [19] = 15,
}