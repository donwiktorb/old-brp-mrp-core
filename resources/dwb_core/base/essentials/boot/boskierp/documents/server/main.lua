


Event:Register('dwb:ui:image:returned', function(source, xPlayer,data)
    if data.src and type(data.src) == 'string' then
        xPlayer:SetCharData('avatar', data.src)
        xPlayer:SyncChar('data')
    end
end, true)

-- -- Item:RegisterUsable('idcard', function(source)
-- --     local xPlayer = xPlayer
-- --     local item = xPlayer:GetInventoryItem('idcard')
-- --     checkDistance(source, 5.0, function(src, k, v)
-- --         Event:TriggerNet('dwb:documents:show:id', k, {
-- --             name = 'docs',
-- --             show = true,
-- --             avatar = xPlayer.char.avatar,
-- --             docType  =  'id',
-- --             fn = xPlayer.char.firstname,
-- --             ln = xPlayer.char.lastname,
-- --             dob = xPlayer.char.dateofbirth,
-- --             exp = item.data.expire,
-- --             id = xPlayer.charId,
-- --             country = 'PL',
-- --             sex = xPlayer.char.sex,
-- --             hgt = xPlayer.char.height,
-- --             wgt = xPlayer.char.weight or 70
-- --         })
-- --     end)
-- -- end)

Event:Register('dwb:documents:idcard:show', function(source, xPlayer)
    local xPlayer = xPlayer
    local item = {data = {}}
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            avatar = item.data.avatar or xPlayer.char.data.avatar,
            docType  =  'id',
            fn = item.data.fn or xPlayer.char.data.firstname,
            ln = item.data.ln or xPlayer.char.data.lastname,
            dob = xPlayer.char.data.dob,
            exp = item.data.expire or 2033,
            id = item.data.charId or xPlayer.charId,
            country = 'PL',
            sex = xPlayer.char.data.sex.value,
            hgt = xPlayer.char.data.height,
            wgt = xPlayer.char.data.weight or 70,
        })
    end)
end, true)

Event:Register('dwb:documents:badge:show', function(source, xPlayer)
    local xPlayer = xPlayer
    local item = {data = {}}
    local badge = xPlayer.char.data.badge
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            badge = badge or 4,
            docType  =  'badge'
        })
    end)
end, true)

Event:Register('dwb:documents:show:driving', function(source, xPlayer)
    local xPlayer = xPlayer
    local item = {data = {}}
    local licenses = {}
    for k,v in pairs(xPlayer.char.data.licenses or {}) do
        if v == 'driving_a' then
            table.insert(licenses, 'A', 1)
        elseif v == 'driving_b' then
            table.insert(licenses, 'B', 2)
        elseif v == 'driving_c' then
            table.insert(licenses, 'C', 3)
        end
    end
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            avatar = item.data.avatar or xPlayer.char.data.avatar,
            docType  =  'drive',
            fn = item.data.fn or xPlayer.char.data.firstname,
            ln = item.data.ln or xPlayer.char.data.lastname,
            dob = xPlayer.char.data.dob,
            exp = item.data.expire or 2033,
            id = item.data.charId or xPlayer.charId,
            country = 'PL',
            sex = xPlayer.char.data.sex.value,
            hgt = xPlayer.char.data.height,
            wgt = xPlayer.char.data.weight or 70,
            licenses = licenses
        })
    end)
end, true)

Item:RegisterUsable('idcard', function(source)
    local xPlayer = xPlayer
    local item = xPlayer:GetInventoryItem('idcard')
    local firstname,lastname = xPlayer:GetCharNames()
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            avatar = item.data.avatar or xPlayer.char.data.avatar,
            docType  =  'id',
            fn = item.data.fn or firstname,
            ln = item.data.ln or lastname,
            dob = xPlayer.char.data.dateofbirth,
            exp = item.data.expire or 2033,
            id = item.data.charId or xPlayer.charId,
            country = 'PL',
            sex = xPlayer.char.data.sex.value,
            hgt = xPlayer.char.data.height,
            wgt = xPlayer.char.data.weight or 70,
        })
    end)
end)

Item:RegisterUsable('badge', function(source)
    local xPlayer = xPlayer
    local item = xPlayer:GetInventoryItem('badge')
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            badge = item.data.badge,
            docType  =  'badge'
        })
    end)
end)

Item:RegisterUsable('driving_license', function(source)
    local xPlayer = xPlayer
    local item = xPlayer:GetInventoryItem('driving_license')
    local firstname,lastname = xPlayer:GetCharNames()
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            avatar = item.data.avatar or xPlayer.char.data.avatar,
            docType  =  'drive',
            fn = item.data.fn or firstname,
            ln = item.data.ln or lastname,
            dob = xPlayer.char.dateofbirth,
            exp = item.data.expire or 2033,
            id = item.data.charId or xPlayer.charId,
            country = 'PL',
            sex = xPlayer.char.data.sex.value,
            hgt = xPlayer.char.data.height,
            wgt = xPlayer.char.data.weight or 70,
            licenses = item.data.licenses or {}
        })
    end)
end)

Event:Register('dwb:documents:show:legit', function(source, xPlayer)
    local xPlayer = xPlayer
    local job = xPlayer:GetJobByType('fraction')
    checkDistance(source, 5.0, function(src, k, v)
        Event:TriggerNet('dwb:documents:show:id', k, {
            name = 'docs',
            show = true,
            avatar = xPlayer.char.data.avatar,
            docType  =  'badge2',
            fullName = xPlayer.char.data.firstname..' '..xPlayer.char.data.lastname,
            job = job.label,
            grade = job.grade_label,
            badge = xPlayer:GetBadge(job.name) or 0
        })
    end)
end, true)