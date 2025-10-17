local waiting, connecting = {}, {}
local points, maxPlayers, emojis = {}, 128, {}
-- for i=1, 200 do
--     table.insert(waiting, {
--         steam = 'hi',
--         source = 0,
--         points = 20000
--     })
-- end

function getRandomEmojis()
    local emojis = {}
    for i=1, 3 do
        table.insert(emojis, Queue.emojis[math.random(#Queue.emojis)])
    end
    return emojis
end

function refreshPoints()
    points = json.decode(LoadResourceFile(GetCurrentResourceName(), 'base/data/points.json'))
end

refreshPoints()

function getDiscordBonus(data)
    if data and data.isBooster then
        return Queue.discordBonus.booster, 'Darmowe 200 punktów za bycie na discordzie oraz boost'
    else
        return Queue.discordBonus.default, 'Darmowe 100 punktów za bycie na discordzie'
    end
end

function getPlace(identifiers)
    for k,v in pairs(waiting) do
        if v.steam == identifiers.steam then
            return k
        end
    end
end

function removeFromQueue(identifiers, fromConnecting, isConnecting, both)
    
    if both or not fromConnecting  then
        for k,v in pairs(waiting) do
            if v.steam == identifiers.steam then
                if isConnecting then
                    table.insert(connecting, v)
                end
                table.remove(waiting, k)
                return
            end
        end
    else
        for k,v in pairs(connecting) do
            if v.steam == identifiers.steam then
                table.remove(connecting, k)
                return
            end
        end
    end
end

function getPlaceByPoints(points)
    local place = 1
    for k,v in pairs(waiting) do
        if v.points > points then
            place = place + 1
        end
    end
    return place
end

Event:Register('dwb:player:joining', function(source, oldsource)
    local rawIdentifiers = GetPlayerIdentifiers(source)
    local identifiers = Table:GetValues(rawIdentifiers, {
        'steam',
        'discord',
        'license'
    })
    table.insert(connecting, {
        steam = identifiers.steam,
        source = source
    })
end)

function createQueueLoop(source, identifiers, userData, def)
      
    local discord = {
        data = Discord:GetUserData(source),
        msg = 'Nie jesteś na discordzie, więc nie otrzymasz żadnych punktów ;c',
        points = 0
    }
    
    if discord.data and discord.data.inDiscord then
        discord.points, discord.msg = getDiscordBonus(discord.data)
    elseif not discord.data then
        discord.msg = 'Nie załadowano api ;c'
    end

    local points = (points[identifiers.steam] or 0) + discord.points
    
    local place = getPlaceByPoints(points)

    table.insert(waiting, place, {
        steam = identifiers.steam,
        points = points,
        source = source
    })

    SetConvar("dwb_queue", #waiting)


    local waiter = true

    repeat 
        if GetPlayerPing(source) >= 0 then
            def.done("Wystąpił błąd z twoim pingiem")
            waiter = false 
            return removeFromQueue(identifiers, false, true)
        end

        local place = getPlace(identifiers) 

        if place then
            local points = waiting[place].points
            if place == 1 then
                if #GetPlayers() + #connecting < 128 then
                    def.done()
                    Cache:AddTemp(identifiers.steam, userData, 600)
                    removeFromQueue(identifiers, true, false, true)
                    waiter = false                     
                    return
                end
            else
                local emojis = getRandomEmojis()
                local lastEmoji = nil
                local bonus = 0
                for k,v in pairs(emojis) do
                    if not lastEmoji then
                        lastEmoji = v
                    else
                        if lastEmoji == v then
                            bonus = bonus + 1
                        end
                    end
                end

                if bonus > 2 then
                    points = points + 200
                    local newPlace = getPlaceByPoints(points)
                    table.insert(waiting, newPlace, {
                        steam = identifiers.steam,
                        points = points,
                        source = source
                    })
                    table.remove(waiting, place)
                    place = newPlace
                end

                waiting[place].points = points + 1
                def.update(string.format(
                    "Jesteś %s/%s w kolejce (%s %s %s) \n Jeżeli emotki się zatrzymają, zrestartuj kolejkę \n Przejechałeś %s km \n Ogłoszenie: %s \n Discord: %s \n Informacja: %s",
                    place, #waiting, emojis[1], emojis[2], emojis[3], waiting[place].points, Queue.announcement, Queue.discord, discord.msg
                ))


            end
        else
            def.done('Wystąpił błąd z kolejką lub zostałeś wyrzucony')
            waiter = false
            return removeFromQueue(identifiers, false, true)
        end

        Wait(6000)

    until not waiter

    removeFromQueue(identifiers)
end

function verifyNames(firstname, lastname)
    local firstname, lastname = firstname:lower():gsub("^%l", string.upper):gsub( "%W+", "" ):gsub("%d", ""), lastname:lower():gsub("^%l", string.upper):gsub( "%W+", "" ):gsub("%d", "")


    return firstname, lastname
end

function charSystem(playerData, cfg, def)
    local identifiers = playerData.identifiers


    local resData = {}

    local userData = {
        group = 'user',
        chars = {}
    }

    local continue = false

    local count = 0

    local cards = {
        init = json.decode(cfg.cards.init),
        new = json.decode(cfg.cards.new),
        remove = json.decode(cfg.cards.remove),
        warning = json.decode(cfg.cards.warning),
        pos = json.decode(cfg.cards.pos)
    }
    
    local result = Mysql.Sync:fetchAll('SELECT data FROM users WHERE identifier = ?', {
        identifiers.steam
    })

    if result and result[1] then
        local result = result[1]
        local chars = json.decode(result.data).chars
        if not chars then
            return print('handle 198 main.lua queue')
        end
        userData = json.decode(result.data)

        for k,v in pairs(chars) do
            if userData.vip and count < cfg.charLimitVip or not userData.vip and count < cfg.charLimit then
                count = count + 1
                table.insert(cards.init.body[3].choices, { 
                    title = tostring(v.id) .. ' '.. tostring(v.firstname)..' '..tostring(v.lastname),
                    value = tostring(v.id)
                }) 

            end
        end

        if count > 0 and userData.char then
            cards.init.body[3].value = userData.char
        end

        if userData.vip and count >= cfg.charLimitVip or not userData.vip and count >= cfg.charLimit then
            table.remove(cards.init.body[3].choices, 1) 
        end

    else
        local newIdents = playerData.rawIdentifiers

        for k,v in pairs(newIdents) do
            if string.find(v, 'ip:') then
                table.remove(newIdents, k)
            end
        end

        Mysql.Sync:Insert('INSERT INTO users SET ?', {
            identifier = identifiers.steam,
            name = playerData.name,
            identifiers = json.encode(newIdents),
            data = json.encode(userData)
        })

    end

    def.presentCard(json.encode(cards.init), function(data, rawData)
        if data.submitId == 'submit' then
            if data.choice == 'new' then
                def.presentCard(json.encode(cards.new), function(dataNew, rawDataNew)
                    local firstname, lastname = verifyNames(dataNew.firstname, dataNew.lastname)
                    local newD = {
                        firstname = firstname,
                        lastname = lastname,
                        dateofbirth = dataNew.dateofbirth,
                        phone_number = 0,
                        sex = dataNew.sex
                    }

                    if count >= 1 and userData.vip then 
                        newD.team = 'ISIS' 
                        newD.whitelist = true
                    end

                    local insertId = Mysql.Sync:Insert('INSERT INTO characters SET ?', {
                        data = json.encode(newD),
                        accounts = json.encode({
                            bank = Config.Default.bank,
                            money = Config.Default.money,
                            black_money = 0
                        }),
                        jobs = json.encode({{
                            job = 'unemployed',
                            grade = 1
                        }}),
                        position = json.encode(Config.Default.position)
                    })

                    table.insert(userData.chars, {
                        id = insertId,
                        firstname = firstname,
                        lastname = lastname
                    })

                    userData.char = insertId

                    Mysql.Sync:Execute('UPDATE users SET data = ? WHERE identifier = ?', {
                        json.encode(userData),
                        identifiers.steam
                    })

                    continue = true
                end)
            else
                userData.char = data.choice
                Mysql.Sync:Execute('UPDATE users SET data = ? WHERE identifier = ?', {
                    json.encode(userData),
                    identifiers.steam
                })

                continue = true
            end
        else
            if data.choice ~= 'new' then
                def.presentCard(json.encode(cards.remove), function(dataRemove, rawDataRemove)
                    if dataRemove.submitId == 'accept' then
                        Mysql.Sync:Execute('DELETE FROM characters WHERE id = ?', {
                            tonumber(data.choice)
                        })

                        for k,v in pairs(userData.chars) do
                            if tonumber(v.id) == tonumber(data.choice) then
                                table.remove(userData.chars, k)
                            end
                        end

                        Mysql.Sync:Execute('UPDATE users SET data = ? WHERE identifier = ?', {
                            json.encode(userData),
                            identifiers.steam
                        })

                        continue = true

                        def.done('Usunięto postać')
                    else
                        def.done('Anulowano')
                    end
                end)
            else
                def.done('Nie możesz usunąc tej postaci') 
            end
        end
 
    end)

    repeat Wait(1000) until continue

    -- for k,v in pairs(cfg.coords) do
    --     table.insert(cards.pos.body[1].choices, {
    --         title = v.label,
    --         value = tostring(k)
    --     })
    -- end

    -- continue = false

    -- def.presentCard(json.encode(cards.pos), function(data, rawData)
    --     if data.coords ~= 'last' then
    --         userData.pos = cfg.coords[tonumber(data.coords)]
    --     end

    --     continue = true
    -- end)

    -- repeat Wait(1000) until continue

   return userData
    
end

function copyTable(t)
    local newt = {}
    for k,v in pairs(t) do
        newt[k] = v
    end

    return newt
end

function onQueueJoin(source, name, kick, def)
    local source = source
    local cfg = copyTable(Queue)
    local rawIdentifiers = GetPlayerIdentifiers(source)
    local identifiers = Table:GetValues(rawIdentifiers, {
        'steam',
        'discord',
        'license'
    })

    local playerData = {
        name = name,
        rawIdentifiers = rawIdentifiers,
        identifiers = identifiers
    }
    
    def.defer()
    
    Wait(0)
    
    if not identifiers.steam then
        def.done('Nie masz włączonego steama lub wystąpił jakiś błąd') 
    end
     
    if cfg.tech.status then
        if not cfg.tech.allowed[identifiers.steam] then
            def.done(cfg.tech.msg)  
        end
    end
    
    repeat  
        def.update(string.format('Łączenie %s', cfg.time))
        cfg.time = cfg.time -1
        Wait(1000)
    until cfg.time <= 0

    if GetPlayerPing(source) == 0 then
        removeFromQueue(identifiers)
    end

    local userData = charSystem(playerData, cfg, def)

    repeat Wait(1000) until userData

    if userData.char then
        createQueueLoop(source, identifiers, userData, def)
    else
        return def.done("Nie załadowano postaci ;c")
    end


end
    
-- AddEventHandler('playerConnecting', onQueueJoin)
Event:Register('dwb:player:connecting', onQueueJoin)

Event:Register('dwb:player:dropped', function(source, xPlayer, reason)
    local rawIdentifiers = GetPlayerIdentifiers(source)
    local identifiers = Table:GetValues(rawIdentifiers, {
        'steam',
        'discord',
        'license'
    })
    removeFromQueue(identifiers, true)

end)

Event:Register('dwb:player:joined', function()
    local rawIdentifiers = GetPlayerIdentifiers(source)
    local identifiers = Table:GetValues(rawIdentifiers, {
        'steam',
        'discord',
        'license'
    })
    removeFromQueue(identifiers, true)
end, true)