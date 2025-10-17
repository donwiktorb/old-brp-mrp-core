function setUniform(uniform)
    TriggerEvent('dwb_skinchanger:getSkin', function(skin)
        local uniformObject

        if skin.sex == 0 then
            uniformObject = uniform.male
        else
            uniformObject = uniform.female
        end

        if uniformObject then
            TriggerEvent('dwb_skinchanger:loadClothes', skin, uniformObject)
              else
            Notification:Show('Brak ubioru.')
        end
    end)
end

Event:Register('dwb:team:chosen', function(team)
    local coords = {}

    for n,m in pairs(Clothes.Rooms[team]) do
        table.insert(coords, m)
    end

    Marker:Add('clothes', {
        messages = {},
        marker = {
            type = 27,
            color = {
                r = 20,
                g = 222,
                b = 222,
                a = 222
            },
            animate = true
        },
        data = {
            team = team
        },
        settings = {
            drawDist = 50,
            radius = 2.5,
            overrideCoords = true,
            drawMarker = true
        },
        coords = coords,
        functions = {
            onExitCb = function(zoneData, posData)
                Menu:CloseAll() 
            end,
            onClickCb = function(zoneData, posData)
                local type = posData.type
                local zone = posData.zone
                local team = zoneData.data.team
                local spawn = posData.spawn
                local ped = PlayerPedId()
                if type == 'menu' then
                    for k,v in pairs(Clothes.Clothes[team]) do
                        if v.name == zone then
                            UI:Open('Menu', {
                                name = zone,
                                title = v.label,
                                align = 'right',
                                elements = v.categories 
                            }, function(data, menu)
                                local category = data.current.type
                                for k2,v2 in pairs(Clothes.Cat[team]) do
                                    if v2.type == category then
                                        local elements = {}
                                        for m2, n2 in pairs(v2.clothes) do
                                            table.insert(elements, {
                                                label = n2.label,
                                                key = m2
                                            })
                                        end
                                        UI:Open('Menu', {
                                            name = zone..''..posData.index,
                                            title = v2.label,
                                            align = 'right',
                                            elements = elements
                                        }, function(data2, menu2)
                                            local key= data2.current.key  
                                            -- setUniform(Clothes.Cat[team][k2][key].wear)
                                            local obj = Clothes.Cat[team][k2].clothes[key]
                                            if obj then
                                                print(obj.license)
                                                if obj.license then
                                                    Callback:Trigger('dwb:check:license', function(own)
                                                        if own then
                                                            TriggerEvent('dwb_skinchanger:getSkin', function(skin)
                                                                local uniform = Clothes.Cat[team][k2].clothes[key].wear
                                                                local uniformObject
                                                                if not skin or skin.sex == 0 then
                                                                    uniformObject = uniform.male
                                                                else
                                                                    uniformObject = uniform.female
                                                                end

                                                                if uniformObject then
                                                                    TriggerEvent('dwb_skinchanger:loadClothes', skin, uniformObject)
                                                                    TriggerEvent('dwb_skinchanger:getSkin', function(skin)
                                                                        Event:TriggerNet('dwb:skin:save', skin)
                                                                    end)
                                                                else
                                                                    Notification:Show('Brak ubioru.')
                                                                end
                                                            end)
                                                        else
                                                            Notification:ShowCustom('info', 'Licencje','Nie masz licencji '..obj.license)
                                                        end
                                                    end, obj.license)
                                                else
                                                    TriggerEvent('dwb_skinchanger:getSkin', function(skin)
                                                        local uniform = Clothes.Cat[team][k2].clothes[key].wear
                                                        local uniformObject

                                                        if not skin or skin.sex == 0 then
                                                            uniformObject = uniform.male
                                                        else
                                                            uniformObject = uniform.female
                                                        end

                                                        if uniformObject then
                                                            TriggerEvent('dwb_skinchanger:loadClothes', skin, uniformObject)
                                                            TriggerEvent('dwb_skinchanger:getSkin', function(skin)
                                                                Event:TriggerNet('dwb:skin:save', skin)
                                                            end)
                                                        else
                                                            Notification:Show('Brak ubioru.')
                                                        end
                                                    end)
                                                end
                                                end
                                            -- Menu:CloseAll(menu, menu2)
                                        end)
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        }
    })
end, true)