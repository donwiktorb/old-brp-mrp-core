
-- User:OnCustomEvent('gang-zone', function(self, zoneData, posData)
--     local zone = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
--     local job = self:GetJobByType('gang')
--     if job and job.name ~= posData.name then
--         if not zone.attacked then
--             if zone.graffiti and zone.graffiti >= 2 then
--                 if zone.kills and zone.kills >= 1 then
--                     zone.attacked = true
--                     zone.name = job.name
--                     zone.blip.color = job.zoneColor
--                     zone.kills = 0
--                     zone.graffiti = 0
--                     Event:TriggerNet('dwb:zones:gang:start', -1, posData.name, job)
--                 else
--                     self:ShowNotify('info', 'Ośka', string.format("Musisz zajebac czlonka przeiwnego gangu %s w tym terenie, aby przejąć", 1))
--                 end
--             else
--                 self:ShowNotify('info', 'Ośka', string.format("Musisz jeszcze namalować %s graffiti w tym terenie, aby przejąć", 2))
--             end
--         end
--     end
-- end)

Event:Register('dwb:graffiti:new', function(source, xPlayer,coords, scale, text, color, rot)
    if xPlayer.zoneData then
        local zoneData = xPlayer.zoneData
        local posData = xPlayer.posData
        local zone = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
        zone.graffiti = zone.graffiti and zone.graffiti + 1 or 1
    end
end, true)

User:OnKilledByPlayer(function(self, data)
    local xPlayer = DWB.Players[data.killerServerId]
    if xPlayer and xPlayer.zoneData then
        local zoneData = xPlayer.zoneData
        local posData = xPlayer.posData
        local zone = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
        zone.kills = zone.kills and zone.kills + 1 or 1
        local job = xPlayer:GetJobByType('gang')
        if job and job.name ~= posData.name then
            if not zone.attacked then
                if zone.graffiti and zone.graffiti >= 2 then
                    if zone.kills and zone.kills >= 1 then
                        zone.attacked = true
                        zone.name = job.name
                        zone.blip.color = job.zoneColor
                        zone.kills = 0
                        zone.graffiti = 0
                        self.inventory:AddItem({
                            name = 'black_money',
                            count = 500000
                        })
                        Event:TriggerNet('dwb:zones:gang:start', -1, posData.name, job)
                    else
                        xPlayer:ShowNotify('info', 'Ośka', string.format("Musisz zajebac czlonka przeiwnego gangu %s w tym terenie, aby przejąć", 1))
                    end
                else
                    xPlayer:ShowNotify('info', 'Ośka', string.format("Musisz jeszcze namalować %s graffiti w tym terenie, aby przejąć", 2))
                end
            end
        end
    end
end)

User:OnCustomEvent('flags', function(self, zoneData, posData)
    local zone = Config.Gameplay.Markers[zoneData.index].coords[posData.index]
    local job = self:GetJobByType('gang')
    if job and (not zone.owned or zone.owned ~= job.name) then
        self.inventory:AddItem({
            name = 'black_money',
            count = 500000
        })
        zone.owned = job.name
        MarkerM:EditText('name', 'flags', 'index', posData.index, 1, {
            label = job.label,
            color = job.color
        })
        Event:TriggerNet('dwb:zones:flags:start', -1, posData, job)
    else
        xPlayer:ShowNotify('info', 'Flagi', string.format("Nie możesz przejąc flagi, poniewż nie masz joba organizacji lub twoja organizacja już ją przejęła"))
    end
end)