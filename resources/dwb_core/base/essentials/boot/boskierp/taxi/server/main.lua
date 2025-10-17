


-- -- -- -- User:OnCustomEvent('fraction-action', function(self, data, data2)
-- -- -- --     if data2.value == 'taxi-search' then
-- -- -- --         Event:TriggerNet('dwb:taxi:search', self.source)
-- -- -- --     end
-- -- -- -- end)
-- -- -- -- Event:Register('dwb:taxi:pay', function(source, xPlayer,count) xPlayer.inventory:AddItem({ name = 'cash', count = count }) end, true)