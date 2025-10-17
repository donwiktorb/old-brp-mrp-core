


local Ammo = Item:Register({
    type = 'ammo' -- name = 'water'
})

function Ammo:OnUse(xPlayer, item) 
    local currentWeapon = xPlayer.currentWeapon
    if currentWeapon then
        if currentWeapon.ref and currentWeapon.ref.clipType then


            if currentWeapon.ref.clipType == item.name then
                xPlayer.inventory:SetItemData(currentWeapon.slot, 'slot', {
                    key = 'ammo',
                    value = data4.data and data4.data.ammo or data.extra
                })

                xPlayer.inventory:RemoveItem(item.slot, 'slot', 1)
            end
        end
    end
end



function Ammo:OnUseItem(xPlayer, data, data4) 
    if data4.ref and data4.ref.clipType then
        if data4.ref.clipType == data.name then
            


            xPlayer.inventory:SetItemData(data4.slot, 'slot', {
                key = 'ammo',
                value = (data4.data and data4.data.ammo or 0) + data.extra
            })
            
            xPlayer.inventory:RemoveItem(data.slot, 'slot', 1, true)
        end
    end
end

-- -- -- -- Inventory:OnChangedItem('pistol_ammo', 'weapon', function(self, invItem, targetInvItem)
-- -- -- --     self:RemoveItem(invItem.slot, 'slot', 1)
-- -- -- --     -- local targetData = targetInvItem.data
-- -- -- --     self:SetItemData(targetInvItem.slot, 'slot', {
-- -- -- --         key = 'ammo',
-- -- -- --         value = 200
-- -- -- --     })
-- -- -- -- end)