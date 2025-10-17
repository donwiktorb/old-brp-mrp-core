Event:Register('dwb:banking:deposit', function(source, xPlayer,data)
    local value = math.abs(tonumber(data.value))
    
    if xPlayer.bank:Deposit(value) then
        xPlayer.bank:Open()
    end

end, true)

Event:Register('dwb:banking:withdraw', function(source, xPlayer,data)
    local value = math.abs(tonumber(data.value))

    if xPlayer.bank:Withdraw(value) then
        xPlayer.bank:Open()
    end


end, true)

Event:Register('dwb:banking:transfer', function(source, xPlayer,data)
    local bankId = tonumber(data.bankId)
    local value = math.abs(tonumber(data.value))
    local player, id = Core:GetPlayerBy('charId', bankId)
    local balance = xPlayer.bank.account.balance
    local dist = balance-value

    if dist >= 0 then
        xPlayer.bank:Transaction(0, 'Przelew', 'Przelew do '..bankId, value)
        if id then
            player.bank:Transaction(1, 'Przelew', 'Przelew od '..xPlayer.charId, value)
        else
            Database.Async:Execute('UPDATE bank_accounts SET balance = balance + ? WHERE bankId = ?', {
                value,
                bankId
            }, function(rowsChanged)
                Log:Info('Update bank for ', id)
            end)
        end
    end

    xPlayer.bank:Open()

    if id then
        player.bank:Open(true)
    end
end, true)

User:OnCustomEvent('bank', function(self, zoneData, posData)

    self.bank:Open()
end)