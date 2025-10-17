


Event:Register('dwb:status:sync', function(source, xPlayer,water, hunger)
    xPlayer.char.data.status = {
        water = water,
        hunger = hunger
    }
end, true)





function User:SyncStatus()
    self:SyncChar('data')
end


function User:AddStatus(name, value)
    if not self.char.data.status then
        self.char.data.status = {
            water = 50,
            hunger = 50
        }
    end



    self.char.data.status[name] = self.char.data.status[name] + value
    self:SyncStatus()
end

-- -- -- -- User:OnLoadedChar(function(self)
-- -- -- --     -- -- -- -- self:SyncChar('status', self.char.data.status)
-- -- -- -- end)

-- -- -- -- for k,v in pairs(Config.Usable.Items) do
-- -- -- --     Item:RegisterUsable(k, function(source)
-- -- -- --         local xPlayer = DWB.Players[source]
-- -- -- --         xPlayer.inventory:RemoveItem(k, 'name', 1)
-- -- -- --         -- xPlayer.inventory:Sync()
-- -- -- --         if v.water then
-- -- -- --             xPlayer:AddStatus('water', v.water)
-- -- -- --         else
-- -- -- --             xPlayer:AddStatus('hunger', v.hunger)
-- -- -- --         end
-- -- -- --         Event:TriggerNet('dwb:item:used', xPlayer.source,v)
-- -- -- --     end)
-- -- -- -- end