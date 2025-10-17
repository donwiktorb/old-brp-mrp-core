


local Revive = Item:Register({
    type = 'revive' -- name = 'water'
})

function Revive:OnUse(xPlayer, item) 
    local zPlayer, dist = Core:GetClosestPlayer(xPlayer:GetPedCoords(), 3, false, xPlayer.source)
    if zPlayer then
        Timeout:Clear(xPlayer.revTimeout)


        xPlayer.inventory:RemoveItem(item.slot, 'slot', 1, true)
		local lib, anim = 'missheistfbi3b_ig8_2', 'cpr_loop_paramedic'
        xPlayer:PlayAnim(item.extra[1] or lib,item.extra[2] or anim, {duration = 10000}) 
        xPlayer.ui:Open('Bar', {
            name = 'bar',
            time = item.extra[3] or 30,
            task = "Podnosisz gracza",
            autoClose = true
        }, {
            submitCb = true,
            closeAfterSubmit = true
        }, function()


            zPlayer:Revive()
        end)
    end
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

