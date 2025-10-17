User:OnCustomEvent('carthief', function(self, zoneData, posData)
    if posData.data.type == 'spawn' and not self.stealer then
        local posIdx = math.random(1, #posData.data.coords)
        local pos = posData.data.coords[posIdx]

        local vehIdx = math.random(1, #posData.data.vehicles)
        local veh = posData.data.vehicles[vehIdx]

        local _xPlayer = self
        local _source = self.source

        Vehicle:SpawnServer(veh.model, pos[1], pos[2], function(vehEnt, vehId)
            FreezeEntityPosition(vehEnt, true)
            _xPlayer.stealer = vehEnt
            _xPlayer.stealerData = veh
            Entity(vehEnt).state.stealer = _source
            Event:TriggerNet('dwb:stealer:accept', _source, veh, pos, NetworkGetNetworkIdFromEntity(vehEnt))
        end)
    else
        local veh = self.stealerData
        local veh2 = GetVehiclePedIsIn(GetPlayerPed(self.source))
        if self.stealer == veh2 then
            DeleteEntity(self.stealer)
            self.stealer = nil
            self.inventory:AddItem({
                name = Config.Items.BlackMoney,
                count = self.stealerData.price 
            })
        end
    end
end)

User:OnCustomEvent('carthief-g', function(self, zoneData, posData)
    DeleteEntity(self.stealer)
    self.stealer = nil
    Event:TriggerNet('dwb:stealer:deny', self.source)
end)

User:OnUnloaded(function(self)
    if self.stealer then
        DeleteEntity(self.stealer)
    end
end)