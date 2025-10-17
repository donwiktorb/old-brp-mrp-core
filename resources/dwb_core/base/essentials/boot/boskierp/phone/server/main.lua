User:OnLoadedChar(function(self)
    self.phone = Phone(self)
end)

User:OnUnloadedChar(function(self)
    self.phone = nil
end)

local chatMsgs = {
    ['twitter'] = {},
    ['darkweb'] = {}
}

Event:RegisterCb('dwb:phone:check:available', function(source, cb, numb)
    local xPlayer = DWB.Players[source]
    local player, id = xPlayer.phone:GetPlayerByNumber(numb)
    if not player then
        xPlayer.phone:SaveCall(numb, 'tried')
        cb(false)
    else
        cb(true)
    end
end)

Event:RegisterCb('dwb:phone:get:last:messages', function(source, cb)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetLastMessages())
end)

Event:RegisterCb('dwb:phone:get:contacts', function(source, cb)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetContacts())
end)

Event:RegisterCb('dwb:phone:get:images', function(source, cb)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetImages())
end)

Event:RegisterCb('dwb:phone:get:calls', function(source, cb)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetCalls())
end)

Event:RegisterCb('dwb:phone:get:number', function(source, cb, number)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetNumber())
end)

Event:RegisterCb('dwb:phone:get:chat:messages', function(source, cb, type)
    local xPlayer = DWB.Players[source]
    cb(chatMsgs[type])
end)

Event:RegisterCb('dwb:phone:get:number:messages', function(source, cb, number)

    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetNumberMessages(number))
end)

Event:RegisterCb('dwb:phone:get:notifies', function(source, cb, number)
    local xPlayer = DWB.Players[source]
    cb(xPlayer.phone:GetNotifies())
end)

Event:Register('dwb:phone:image:save', function(source, xPlayer,url)
    xPlayer.phone:SaveImage(url)
end, true)

Event:Register('dwb:phone:manage:contact', function(source, xPlayer,name, number)
    xPlayer.phone:SaveContact(number, name)
end, true)

Event:Register('dwb:phone:contact:delete', function(source, xPlayer,data)
    xPlayer.phone:RemoveContact(data.id)
end, true)

Event:Register('dwb:phone:call:start', function(source, xPlayer,number, sdp)
    xPlayer.phone:Call(number, sdp)
end, true)

Event:Register('dwb:phone:new:candidate', function(source, xPlayer,number, candidate)
    xPlayer.phone:NewCandidate(number, candidate)
end, true)

Event:Register('dwb:phone:call:accept', function(source, xPlayer,number, sdp)
    xPlayer.phone:AnswerCall(number, sdp)
end, true)

Event:Register('dwb:phone:call:stop', function(source, xPlayer,number)
    xPlayer.phone:StopCall(number)
end, true)

Event:Register('dwb:phone:send:offer', function(source, xPlayer,number, offer)
    xPlayer.phone:SendOffer(number, offer)
end, true)

Event:Register('dwb:phone:send:answer', function(source, xPlayer,number, answer)
    xPlayer.phone:SendAnswer(number, answer)
end, true)

Event:Register('dwb:phone:message:send', function(source, xPlayer,message, number, msgdata, actions)
    if not actions then
        xPlayer.phone:HandleMessage(number, message, msgdata)
    else
        Event:Trigger('dwb:phone:action', xPlayer, number, message, msgdata, actions)
    end
end, true)

Event:Register('dwb:phone:message:send:chat', function(source, xPlayer,message, type, msgdata, actions)
    if #message > 300 then return end
    local xPlayer = DWB.Players[source]
    local name = xPlayer:GetCharName() .. '#' .. source
    if type == 'darkweb' then
        if not xPlayer.tempName then
            xPlayer.tempName = math.random(1, 999)
        end
        name = xPlayer.tempName .. "#" .. xPlayer.source
    end
    table.insert(chatMsgs[type], {



        author = name,
        content = message,
        data = msgdata,
        time = os.time() * 1000
    })

    local input = message
    local pattern = "@(%w+)%#(%d+)"
    local matches = {}
    local foundOne = false

    for name, number in input:gmatch(pattern) do
        if name and number then
            matches[name .. '#' .. number] = true
            foundOne = true
        end
    end

    if foundOne then
        for k, v in pairs(DWB.Players) do
            if type == 'darkweb' then
                if v.tempName and matches[v.tempName .. '#' .. k] then
                    Event:TriggerNet('dwb:phone:notify', k, 'chat')
                end
            else
                local firstname,lastname = v:GetCharNames()
                local firstName = firstname .. '#' .. k
                local lastName = lastname .. '#' .. k
                if matches[firstName] or matches[lastName] then
                    Event:TriggerNet('dwb:phone:notify', k, 'twitter')
                end
            end
        end
    end

    if actions then
        Event:Trigger('dwb:phone:action', source, message, type, msgdata, actions)
    end

    Event:TriggerNet('dwb:phone:chat:update:messages', -1, chatMsgs[type], type)
end, true)


Item:RegisterUsable('phone', function(source, itemData)
    local xPlayer = DWB.Players[source]
    local item = xPlayer.inventory:GetItem('phone', 'name')
    local number = item.data.number
    if number then
        xPlayer.phone:SetNumber(number)
        xPlayer.phone:LoadAll(function()
            xPlayer.phone:Open()
        end)
    else
        xPlayer:ShowNotify('info', TR("phone"), TR("no_sim_card"))
    end
end)

Inventory:OnChangedItem('sim', 'phone', function(self, invItem, targetInvItem)
    self:RemoveItem(invItem.slot, 'slot', 1)
    self:SetItemData(targetInvItem.slot, 'slot', {
        key = 'number',
        value = math.random(99, 99999)
    })
end)

