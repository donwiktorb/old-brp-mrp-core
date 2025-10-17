Config.Fraction = {}

Config.Fraction.ObjectsTouch = {
    [`p_ld_stinger_s`] = {
        inVehicle = true,
        fn = function()
            for i=0, 7 do

                SetVehicleTyreBurst(DWB.PlayerData.Vehicle, i, false, 200.0)
            end
        end


    },
}

Config.Fraction.Menu = {
        ['police'] = {
            {
                label = "Kajdanki",
                value = 'hands'
            },
            {
                label = "Obiekty",
                value = 'objects',
                elements = {
                    {
                        label = "Pachołek",
                        value = 'prop_roadcone02a'
                    },
                    {
                        label = "Barierka",
                        value = 'prop_barrier_work05'
                    },
                    {
                        label = "Kolczatka", 
                        value = 'p_ld_stinger_s'
                    }
                }
            },
          {
                label = "Pojazd",
                value = 'vehicle',
                clientFn = 'vehicle',
                elements = {
                    {
                        label = "Otwórz pojazd",
                        value = 'open'
                    },
                    {
                        label = "Napraw pojazd",
                        value = 'fix',
                    },
                    {
                        label = "Wyczyść pojazd", 
                        value = 'clean'
                    },
                    {
                        label = "Odholuj pojazd", 
                        value = 'delete'
                    },
                    {
                        label = "Wsadż pojazd na lawete", 
                        value = 'put'
                    },
                    {
                        label = "Odczep pojazd z lawety", 
                        value = 'remove'
                    }
                }
            },
            {
                label = "Zarządzaj uprawnieniami",
                value = 'person',
                elements = {

                    {
                        label = "Sprawdź odciski palców",
                        value = 'id'
                    },
                    {
                        label = "Sprawdź proch na dłoniach",
                        value = 'proch'
                    },
                    {
                        label = "Zabierz licencje na broń",
                        value = 'license-take',
                        license = 'short-weapon'
                    },
                    {
                        label = "Zabierz prawo jazdy", 
                        value = 'license-take',
                        license = 'driving'
                    },
                    {
                        label = "Wyrób licencje na broń",
                        value = 'license-give',
                        license = 'short-weapon'
                    },
                }
            },
        },
        ['ambulance'] = {
            -- -- -- -- {
            -- -- -- --     label = "Czyności Medyczne", value = 'revive',
            -- -- -- --     elements = {
            -- -- -- --         {
            -- -- -- --             label = "Podnieś obywatela",
            -- -- -- --             value = 'revive'
            -- -- -- --         },
            -- -- -- --         {
            -- -- -- --             label = "Ulecz lekkie rany",
            -- -- -- --             value = 'heal'
            -- -- -- --         },
            -- -- -- --         {
            -- -- -- --             label = "Ulecz poważne rany",
            -- -- -- --             value = 'heal'
            -- -- -- --         },
            -- -- -- --     }
            -- -- -- -- },
            {
                label = "Kajdanki",
                value = 'hands'
            },
           {
                label = "Pojazd",
                value = 'vehicle',
                clientFn = 'vehicle',
                elements = {
                    {
                        label = "Otwórz pojazd",
                        value = 'open'
                    },
                    {
                        label = "Napraw pojazd",
                        value = 'fix',
                    },
                    {
                        label = "Wyczyść pojazd", 
                        value = 'clean'
                    },
                    {
                        label = "Odholuj pojazd", 
                        value = 'delete'
                    },
                    {
                        label = "Wsadż pojazd na lawete", 
                        value = 'put'
                    },
                    {
                        label = "Odczep pojazd z lawety", 
                        value = 'remove'
                    }
                }
            },
        },
        ['mechanic'] = {
            {
                label = "Pojazd",
                value = 'vehicle',
                clientFn = 'vehicle',
                elements = {
                    {
                        label = "Otwórz pojazd",
                        value = 'open'
                    },
                    {
                        label = "Napraw pojazd",
                        value = 'fix',
                    },
                    {
                        label = "Wyczyść pojazd", 
                        value = 'clean'
                    },
                    {
                        label = "Odholuj pojazd", 
                        value = 'delete'
                    },
                    {
                        label = "Wsadż pojazd na lawete", 
                        value = 'put'
                    },
                    {
                        label = "Odczep pojazd z lawety", 
                        value = 'remove'
                    }
                }
            },
        },  
        ['taxi'] = {
            {
                label = "Misje",
                elements = {
                    {
                        label = "Szukanie obywatela",
                        value = 'taxi-search'
                    }
                }
            }
        }
}

Config.Fraction.Functions = {
    ['vehicle'] = function(data, data2)
        local veh, dist = Vehicle:GetClosest()
        if veh and dist <= 5.0 then
            UI:Open('Bar', {
                name = 'vehicle',
                time = 30,
                show = true,
                task = data2.label
            }, function(data5,menu5)
                menu5.close()
                ClearPedTasks(PlayerPedId())
                if data2.value == 'fix' then
                    SetVehicleFixed(veh, true)
                elseif data2.value == 'put' then
                    local veh2, dist2 = Vehicle:GetClosest2()
                    if veh2 and dist2 <= 10.0 then
                        AttachEntityToEntity(veh2, DWB.PlayerData.Vehicle, GetEntityBoneIndexByName(DWB.PlayerData.Vehicle, 'chassis_dummy'), 0.0, -2.5, 1.0, 0,0,0, false, false, false, false, 0, true)
                    end
                elseif data2.value == 'remove' then
                    local veh2, dist2 = Vehicle:GetClosestBy(false, function(veh5)
                        return IsEntityAttachedToEntity(veh5, DWB.PlayerData.Vehicle)
                    end)
                    -- local ent = GetEntityAttachedTo(DWB.PlayerData.Vehicle)
                    -- -- DETACH_ENTITY 
                    DetachEntity(veh2, true, false)
                else
                    Event:TriggerNet('dwb:fraction:menu:action', data, data2, NetworkGetNetworkIdFromEntity(veh))
                end
            end)
        end
    end,
    ['handcuffs'] = function()
        Event:TriggerNet('dwb:handcuffs:use')
    end,
    ['get-vehicle'] = function()
        local veh, dist = Vehicle:GetClosest()
        if veh and dist <= 5.0 then
            return veh
        end
    end
}