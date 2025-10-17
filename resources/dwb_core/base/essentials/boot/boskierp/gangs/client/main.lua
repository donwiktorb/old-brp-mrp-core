Event:Register('dwb:gangs:open', function(posData, job, clothes, users)
    for k,v in pairs(clothes) do
        v.index = k
    end
    local elements = {
            {
                label = "Ubrania gangu",
                value = "clothes",
                clothes = clothes
            },
            {
                label = "Zapisz ubranie",
                value = "save-clothes"
            },
            {
                label = "Usuń ubranie",
                value = "remove-clothes",
                clothes = clothes
            },
            {
                label = "Otwórz szafkę",
                value = 'open-locker'
            }
    }

    if job.isBoss then
        table.insert(elements, {
            label = "Dodaj członka",
            value = "add-user"
        })
        table.insert(elements, {
            label = "Usuń członka",
            value = "remove-user"
        })
    end
    UI:Open('Menu', {
        name = 'gang',
        title = "Szafka",
        align = 'center',
        elements = elements
    }, function(data, menu)
        local current = data.current.value
        if current == 'clothes' then
            UI:Open('Menu', {
                name = 'gang-clothes',
                title = "Ubrania",
                align = 'right',
                elements = data.current.clothes
            }, function(data2, menu2)
                Skinchanger:Apply(data2.current.skin) 
            end)
        elseif current == 'save-clothes' then
            UI:Open('MenuDialog', {
                name = 'gang-clothes-save',
                title = 'Wpisz nazwę'
            }, function(data5, menu5)
                menu5.close()
                local skin = Skinchanger:GetSkin()
                Event:TriggerNet('dwb:gangs:save:skin', data5.current.value, skin)
            end)
        elseif current == 'remove-clothes' then
            UI:Open('Menu', {
                name = 'gang-clothes',
                title = "Ubrania",
                align = 'right',
                elements = data.current.clothes
            }, function(data2, menu2)
                menu2.close()
                Event:TriggerNet('dwb:gangs:remove:skin', data2.current.index)
            end)
        elseif current == 'open-locker' then
            Event:TriggerNet('dwb:gangs:open:locker')
        elseif current == 'add-user' then
            UI:Open('MenuDialog', {
                name = 'gang-add-user',
                title = 'Wpisz id'
            }, function(data5, menu5)
                menu5.close()
                Event:TriggerNet('dwb:gangs:add:user', tonumber(data5.current.value))
            end)
            
        elseif current == 'remove-user' then
            UI:Open('Menu', {
                name = 'gang-users',
                title = "Członkowie",
                align = 'right',
                elements = users
            }, function(data2, menu2)
                local current = data.current.value
                menu2.close()
                Event:TriggerNet('dwb:gangs:remove:users', current)
            end)
        end
    end)
end, true)

Event:Register('dwb:gangs:take', function(_data)
    local coords = DWB.PlayerData.Coords
    local data = _data
    local stop = false
    Skills:OpenBar('gang-take', TR("opening_gang_room"), 300, function()
        Event:TriggerNet('dwb:gangs:take', data)
        stop = true
    end)

    while not stop do
        Wait(0)
        if DWB.PlayerData.char.data.IsDead then
            stop = true
            UI:Close('Bar', {
                name = 'gang-take'
            })
        end

        local dist = #(coords-DWB.PlayerData.Coords)

        if dist >= 7.0 then
            stop = true

            UI:Close('Bar', {
                name = 'gang-take'
            })
        end

        if IsControlJustPressed(0, 73) then
            stop = true

            UI:Close('Bar', {
                name = 'gang-take'
            })
        end
    end
end, true)