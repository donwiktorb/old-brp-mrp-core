Event:Register('dwb:company:open', function(posData, job, clothes, users, companyData)
    for k,v in pairs(clothes) do
        v.index = k
    end
    local elements = {
            -- {
            --     label = "Ubrania",
            --     value = "clothes",
            --     clothes = clothes
            -- },
            -- {
            --     label = "Zapisz ubranie",
            --     value = "save-clothes"
            -- },
            -- {
            --     label = "Usuń ubranie",
            --     value = "remove-clothes",
            --     clothes = clothes
            -- },
            {
                label = "Otwórz szafkę",
                value = 'open-locker'
            }
    }
    local money = companyData and companyData.money or 0
    if job.isBoss then
        table.insert(elements, {
            label = "Dodaj członka",
            value = "add-user"
        })
        table.insert(elements, {
            label = "Usuń członka",
            value = "remove-user"
        })
        table.insert(elements, {
            label = ("Ilosc gotowki firmy %s"):format(Math:Format(money)),
            value = "info"
        })
        table.insert(elements, {
            label = "Wyplac pieniadze",
            value = "withdraw"
        })
        table.insert(elements, {
            label = "Wplac pieniadze",
            value = "deposit"
        })
    end
    UI:Open('Menu', {
        name = 'company',
        title = "Szafka",
        align = 'center',
        elements = elements
    }, function(data, menu)
        local current = data.current.value
        if current == 'clothes' then
            UI:Open('Menu', {
                name = 'company-clothes',
                title = "Ubrania",
                align = 'right',
                elements = data.current.clothes
            }, function(data2, menu2)
                Skinchanger:Apply(data2.current.skin) 
            end)
        elseif current == 'save-clothes' then
            UI:Open('MenuDialog', {
                name = 'company-clothes-save',
                title = 'Wpisz nazwę'
            }, function(data5, menu5)
                menu5.close()
                local skin = Skinchanger:GetSkin()
                Event:TriggerNet('dwb:company:save:skin', data5.current.value, skin)
            end)
        elseif current == 'remove-clothes' then
            UI:Open('Menu', {
                name = 'company-clothes',
                title = "Ubrania",
                align = 'right',
                elements = data.current.clothes
            }, function(data2, menu2)
                menu2.close()
                Event:TriggerNet('dwb:company:remove:skin', data2.current.index)
            end)
        elseif current == 'open-locker' then
            Event:TriggerNet('dwb:company:open:locker')
        elseif current == 'add-user' then
            UI:Open('MenuDialog', {
                name = 'company-add-user',
                title = 'Wpisz id'
            }, function(data5, menu5)
                menu5.close()
                Event:TriggerNet('dwb:company:add:user', tonumber(data5.current.value))
            end)
            
        elseif current == 'remove-user' then
            UI:Open('Menu', {
                name = 'company-users',
                title = "Członkowie",
                align = 'right',
                elements = users
            }, function(data2, menu2)
                local current = data.current.value
                menu2.close()
                Event:TriggerNet('dwb:company:remove:users', current)
            end)
            
        elseif current == 'withdraw' then
            UI:Open('MenuDialog', {
                name = 'withdraw',
                title = 'Wpisz kwote do wyplaty'
            }, function(data5, menu5)
                menu5.close()
                Event:TriggerNet('dwb:company:withdraw', tonumber(data5.current.value))
            end)
        elseif current == 'deposit' then
            UI:Open('MenuDialog', {
                name = 'withdraw',
                title = 'Wpisz kwote do wplaty'
            }, function(data5, menu5)
                menu5.close()
                Event:TriggerNet('dwb:company:deposit', tonumber(data5.current.value))
            end)
        end
    end)
end, true)