


Event:Register('dwb:ambulance:revive', function(source, xPlayer)
    xPlayer:SetCharData('IsDead', false)
end, true)


Event:Register('dwb:ambulance:revive:pay', function(source, xPlayer, value)
    xPlayer:SetCharData('IsDead', false)



    -- -- -- -- xPlayer.inventory:RemoveRandomItems(2)
    xPlayer.bank:Transaction(0, "EMS", "Lokalny ems", value.pay)
    xPlayer:TeleportToCoords(value.coords, value.heading)
end, true)

Event:Register('dwb:ambulance:revive:local', function(source, xPlayer, value)
    xPlayer:SetCharData('IsDead', false)



    -- -- -- -- xPlayer.inventory:RemoveRandomItems(2)
    xPlayer.bank:Transaction(0, "EMS", "Lokalny ems", value.pay)
end, true)

User:OnCustomEvent('fraction-action', function(self, parent, child, data4)
    if parent.value == 'revive' then
        if child.value == 'revive' then

        elseif child.value == 'heal' then

        end
    end
end)




User:OnCustomEvent('local_medic', function(self, zoneData, posData)
    if not self.char.data.IsDead then
        self:ShowNotify(
            'info',
            TR("local_medic"),
            TR("cant_respawn")
        )
        return
end

    local price = posData.data and posData.data.price or zoneData.data and zoneData.data.price
    local blackMoney = posData.data and posData.data.blackMoney or zoneData.data and zoneData.data.blackMoney
    local item = self.inventory:GetItem(blackMoney and Config.Items.BlackMoney or Config.Items.Money, 'name')
    if not blackMoney or (item and item.count >= price) then
        if posData.data and posData.data.spawns then
            local found = posData.data.spawns[math.random(1, #posData.data.spawns)]

            if found then
                if blackMoney then
                    self.inventory:RemoveItem(blackMoney and Config.Items.BlackMoney or Config.Items.Money, 'name', price)
                else
                    self.bank:Transaction(0, "EMS", "Lokalny ems", price)
                end
                Event:TriggerNet('dwb:ambulance:local', self.source, found, zoneData, posData)

                self:Revive(found, zoneData, posData, 'local')
            else
                self:ShowNotify('info', 'Local', TR("not_enough_beds"))
            end
        else
            if blackMoney then
                self.inventory:RemoveItem(blackMoney and Config.Items.BlackMoney or Config.Items.Money, 'name', price)
            else
                self.bank:Transaction(0, "EMS", "Lokalny ems", price)
            end
            
            Event:TriggerNet('dwb:ambulance:local', self.source, false, zoneData, posData)

            self:Revive(false, zoneData, posData)
        end
    else
        if blackMoney then
            self:ShowNotify('info', 'Local', 
            TR("not_enough_black_money", comma_value(price)) )
        end
    end
end)

