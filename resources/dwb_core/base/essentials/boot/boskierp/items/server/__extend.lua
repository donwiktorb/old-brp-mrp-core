


Event:Register('dwb:inventory:item:remove', function(xPlayer, data) Item:Remove(DWB.Players[xPlayer.source], data) end)
Event:Register('dwb:inventory:item:add', function(xPlayer, data) Item:Add(DWB.Players[xPlayer.source], data) end)
Event:Register('dwb:inventory:item:change', function(xPlayer, data, data4) Item:Change(DWB.Players[xPlayer.source], data, data4) end)