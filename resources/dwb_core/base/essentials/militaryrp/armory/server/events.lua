function buyItem(xPlayer, item, itemData)
    if not itemData.license or xPlayer:HasLicense(itemData.license) then
        local money = xPlayer:GetInventoryItem('money')
        if itemData.price == 0 or (money and  (money.count >= itemData.price)) then
            xPlayer:RemoveInventoryItem('money', itemData.price)
            xPlayer:AddInventoryItem(item.newslot, itemData.name, itemData.ammo or itemData.count)
        end
    else
        xPlayer:ShowNotify('info', 'Bronie', 'Nie masz licencji '..itemData.license..' na ten typ broni!')
    end
end

Event:Register('dwb:inventory:change', function(data)
    local xPlayer = DWB.Players[source]

    local quantity = data.quantity
    local oldslot = data.oldslot
    local newslot = data.newslot
    local oldInv = data.oldInv
    local newInv = data.newInv
    local type = data.type
    local name = data.name
    if newInv == "inventory" then
        local team = xPlayer:GetChar('team')
        for k,v in pairs(Armory.Weapons[team]) do
            for k2,v2 in pairs(v.weapons) do 
                if v2.slot == oldslot and v2.name == name then
                    return buyItem(xPlayer, data, v2)
                end
            end
        end
    end
end, true)