


local Food = Item:Register({ type = 'food' })
function Food:OnUse(xPlayer, item) 
    xPlayer:PlayAnim("mp_player_inteat@burger", "mp_player_int_eat_burger_fp")
    xPlayer:AddStatus('water', item.extra[2])
    xPlayer:AddStatus('hunger', item.extra[1])
end