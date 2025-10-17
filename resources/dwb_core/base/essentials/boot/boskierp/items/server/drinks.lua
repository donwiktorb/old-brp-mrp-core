


local Drinks = Item:Register({
    type = 'drink' -- name = 'water'
})
function Drinks:OnUse(xPlayer, item) 
    xPlayer:PlayAnim("mp_player_intdrink", "loop_bottle" )
    xPlayer:AddStatus('water', item.extra[2])
    xPlayer:AddStatus('food', item.extra[1])
end



-- function Drinks:OnAdd(xPlayer, data) 
--     print(json.encode(data)) 
-- end

-- function Drinks:OnRemove(xPlayer, data) 
--     print(json.encode(data)) 
-- end

-- function Drinks:OnUseItem(xPlayer, data, data4) 
--     print(json.encode(data)) 
-- end