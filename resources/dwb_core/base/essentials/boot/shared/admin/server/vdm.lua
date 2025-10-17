


local vmd = {
    [-1553120962] = true,
    [2741846334] = true,
}

User:OnKilledByPlayer(function(self, data)
    if vmd[data.killerWeapon] then
        self:Revive()


        -- Event:TriggerNet('dwb:ambulance:revive2', self.source)
        local zPlayer = DWB.Players[data.killerServerId]
        if zPlayer then
            zPlayer.vdm = zPlayer.vdm and zPlayer.vdm + 1 or 1
            if zPlayer.vdm >= 3 then
                DropPlayer(zPlayer.source, 'dwb_antivdm: Zostales wyrzucony z serwera')
            end
        end

    end
end)