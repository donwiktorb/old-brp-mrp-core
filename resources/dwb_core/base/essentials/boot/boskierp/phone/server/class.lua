Phone = class(false, false, false, User)

function Phone:GetPlayerByNumber(number)
    for k,v in pairs(DWB.Players) do
        local item = v.inventory:GetItem('phone', 'name')

        if item and item.data and tostring(item.data.number) == number then
            return v,k
        end
    end
end


function Phone:GetNumber()
   return self.number
end

function Phone:SetNumber(number)
    self.number = tostring(number)
end

function Phone:Call(number, sdp)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end

    self:SaveCall(number, 'tried')
    Event:TriggerNet('dwb:phone:call:start', xPlayer.source, self.number, sdp)
end

function Phone:AnswerCall(number, sdp)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end
    self:UpdateCall('answered', number)
    Event:TriggerNet('dwb:phone:call:accept', xPlayer.source, self.number, sdp)
end

function Phone:StopCall(number)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end
    Event:TriggerNet('dwb:phone:call:stop', xPlayer.source, number)
end

function Phone:NewCandidate(number, candidate)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end
    Event:TriggerNet('dwb:phone:new:candidate', xPlayer.source, self.number, candidate)
    -- Event:TriggerNet('dwb:phone:new:candidate', self.source, number, candidate)
end

function Phone:SendAnswer(number, offer)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end
    self:UpdateCall('answered', number)
    Event:TriggerNet('dwb:phone:call:accept', xPlayer.source, self.number, offer)
end

function Phone:SendOffer(number, offer)
    local xPlayer = self:GetPlayerByNumber(number)
    if not xPlayer then
        return
    end
    self:UpdateCall('answered', number)
    Event:TriggerNet('dwb:phone:call:start', xPlayer.source, self.number, offer)
end

function Phone:LoadMessages(cb)
    self.messages = {}
    Mysql.Async:fetchAll('SELECT *, unix_timestamp(time)*1000 as time FROM phone_messages WHERE transmitter = ? OR receiver = ? ORDER BY time', {
        self.number, self.number
    }, function(res)
        for k,v in pairs(res or {}) do
            v.number = self.number == v.transmitter and v.receiver or v.transmitter
            v.data = json.decode(v.data or {})
            if v.transmitter == self.number then
                local chat = self.messages[v.receiver]
                if not chat then
                    self.messages[v.receiver] = {}
                    chat = self.messages[v.receiver]
                    
                end
                table.insert(chat, v)
            else
                local chat = self.messages[v.transmitter]
                if not chat then
                    self.messages[v.transmitter] = {}
                    chat = self.messages[v.transmitter]
                end
                v.owned = true
                table.insert(chat, v)
            end
        end

        if cb then
            cb()
        end
    end)
end

function Phone:LoadContacts(cb)
    self.contacts = {}
    self.contactsPair = {}
    Mysql.Async:fetchAll('SELECT *, unix_timestamp(time)*1000 FROM phone_contacts WHERE owner = ? ORDER BY name', {
        self.number
    }, function(res)
        self.contacts = res or {}
        for k,v in pairs(res) do
            self.contactsPair[v.number] = v.name
        end
        if cb then
            cb()
        end
    end)
end

function Phone:LoadCalls(cb)
    self.calls = {}

    Mysql.Async:fetchAll('SELECT *, unix_timestamp(time)*1000 as time FROM phone_calls WHERE transmitter = ? OR receiver = ? ORDER BY time DESC', {
        self.number, self.number
    }, function(res)

        for k, v in pairs(res or {}) do
            if v.receiver == self.number then
                v.number = v.transmitter
                if v.type == 'tried' then
                    v.type = 'missed'
                end
                -- if v.type == 'answered' then
                --     v.type = 'answer'
                -- end
            else
                v.number = v.receiver
            end
        end

        self.calls = res

        if cb then
            cb()
        end
    end)
end

function Phone:LoadImages(cb)
    self.images = {}

    Mysql.Async:fetchAll('SELECT *, unix_timestamp(time)*1000 as time FROM phone_images WHERE owner= ? ORDER BY time DESC', {
        self.number
    }, function(res)
        self.images = res or {}

        if cb then
            cb()
        end
    end)
end

function Phone:LoadAll(cb)
    local _cb = cb
    self:LoadMessages(function()
        self:LoadContacts(function()
            self:LoadCalls(function()
                self:LoadImages(function()
                    _cb()
                end)
            end)
        end)
    end)
end

function Phone:GetUnreadMessagesCount()
    local count = 0
    for k,v in pairs(self.messages) do
        if v[1] then
            if v[1].receiver == self.number and not v[1].isRead then
                count = count + 1
            end
        end
    end
    return count
end

function Phone:GetContacts()
    return self.contacts
end

function Phone:GetImages()
    return self.images
end

function Phone:GetCalls()
    for k,v in pairs(self.calls) do
        v.name = self.contactsPair[v.number]
    end
    return self.calls
end

function Phone:GetLastMessages()
    local lastMsgs = {}
    for k,v in pairs(self.messages) do
        local lastMsg = v[#v]
        if lastMsg then
            -- -- print(k, json.encode(lastMsg))
            local isRead = lastMsg.isRead
            if lastMsg.transmitter == self.number then
                isRead = 1
            end
            local number = lastMsg.transmitter == self.number and lastMsg.receiver or lastMsg.transmitter
            table.insert(lastMsgs, {
                number = lastMsg.transmitter == self.number and lastMsg.receiver or lastMsg.transmitter,
                content = lastMsg.content,
                time = lastMsg.time,
                isRead = isRead,
                name = self.contactsPair[number] or tostring(number)
            })
        end
    end
    table.sort(lastMsgs, function(a,b)
        return a.time > b.time
    end)
    return lastMsgs
end

function Phone:GetUnreadCallsCount()
    local count = 0
    for k,v in pairs(self.calls) do
        if v.receiver == self.number and not v.isRead then
            count = count + 1
        end
    end
    return count
end

function Phone:GetNotifies()
    local notifies = {
        notifies = 0,
        messages = self:GetUnreadMessagesCount(),
        calls = self:GetUnreadCallsCount()
    }

    return notifies
end

function Phone:LoadNumber(number, cb)
    if not self.number or self.number ~= number then
        self.number = number
        self:LoadAll(function()
            cb()
        end)
    else
        cb()
    end
end

function Phone:Open()
    Event:TriggerNet('dwb:phone:show', self.source)
end

function Phone:SetNumberMessagesRead(number)
    if not self.messages[number] then return end
    for k,v in pairs(self.messages[number]) do
        v.isRead = 1
    end
end

function Phone:GetNumberMessages(number)
    self:SetNumberMessagesRead(number)
    if self.messages[number] then
        for k,v in pairs(self.messages[number]) do
            v.name = self.contactsPair[v.number]
            v.isOwner = v.receiver ~= self.number
        end
    end
    return self.messages[number] or {}
end

function Phone:SaveImage(url)
    Mysql.Async:Insert('INSERT INTO phone_images SET ?', {
        owner = self.number,
        img = url
    }, function()
        table.insert(self.images, {
            img = url,
            owner = self.number
        })
    end)
end

function Phone:SaveMessage(transmitter, receiver, msg, data, cb)
    Mysql.Async:Insert('INSERT INTO phone_messages SET ?', {
        transmitter = transmitter or self.number,
        receiver = receiver or self.number,
        content = msg,
        data = json.encode(data)
    }, function()
        if cb then
            cb()
        end
    end)
end

function Phone:SaveContact(number, name)
    Mysql.Async:Insert('INSERT INTO phone_contacts SET ?', {
        owner = self.number,
        number = number,
        name = name
    }, function(insertId)
        self.contactsPair[number] = name
        table.insert(self.contacts, {
            id = insertId,
            number = number,
            name = name,
        })
    end)
end

function Phone:RemoveContact(data)
    Mysql.Async:Execute('DELETE FROM phone_contacts WHERE id = ?', {
        data.id
    }, function()
        for k,v in pairs(self.contacts) do
            if v.id == data.id then
                table.remove(self.contacts, k)
                self.contactsPair[v.number] = v.name
            end
        end
    end)
end

function Phone:SaveCall(number, type)
    Mysql.Async:Insert('INSERT INTO phone_calls SET ?', {
        transmitter = self.number,
        receiver = number,
        type = type
    }, function()
        table.insert(self.calls, {
            transmitter = self.number,
            receiver = number,
            type = type
        })
    end)
end

function Phone:UpdateCall(type, number)
    Mysql.Async:Execute('UPDATE phone_calls SET type = ? WHERE transmitter = ? AND receiver = ? ORDER BY time LIMIT 1', {
        type,
        self.number,
        tostring(number)
    })
end

function Phone:CallsRead()
    Mysql.Async:Execute('UPDATE phone_calls SET isRead = 1 WHERE receiver = ?', {
        self.number
    }, function()
        for k,v in pairs(self.calls) do
            if v.receiver == self.number then
                v.isRead = true
            end
        end
    end)
end

function Phone:MessagesRead()
    Mysql.Async:Execute('UPDATE phone_messages SET isRead = 1 WHERE receiver = ?', {
        self.number
    })
end

function Phone:MessagesReadNumber(number)
    Mysql.Async:Execute('UPDATE phone_messages SET isRead = 1 WHERE receiver = ? AND transmitter = ?', {
        self.number, number
    }, function()
        for k,v in pairs(self.messages[number]) do
            v.isRead = true
        end
    end)
end

function Phone:SendMessage(number, msg, data, save)
    if not self.messages[number] then
        self.messages[number] = {}
    end

    local msgData = {
        receiver = number,
        transmitter = self.number,
        content = msg,
        data = data or {},
        time = os.time()*1000,
        isRead = 0,
    }

    table.insert(self.messages[number], msgData)

    if save then
        self:SaveMessage(false, number, msg, data)
    end
end

function Phone:ReceiveMessage(number, msg, data, save)
    if not self.messages[number] then
        self.messages[number] = {}
    end

    local msgData = {
        transmitter = number,
        receiver = self.number,
        content = msg,
        data = data,
        time = os.time()*1000,
        isRead = 0,
        owned = true
    }

    table.insert(self.messages[number], msgData)
end

function Phone:HandleMessage(number, msg, data)
    local xPlayer = self:GetPlayerByNumber(number)
    
    self:SendMessage(number, msg, data, true)

    if xPlayer then
        xPlayer.phone:ReceiveMessage(self.number, msg, data)        
        Event:TriggerNet('dwb:phone:message:sent', xPlayer.source, xPlayer.phone:GetNumberMessages(self.number))
    end

    Event:TriggerNet('dwb:phone:message:sent', self.source, self:GetNumberMessages(number))
end