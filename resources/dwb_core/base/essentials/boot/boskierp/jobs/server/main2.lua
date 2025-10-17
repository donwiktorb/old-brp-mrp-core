local workin = {}

User:OnCustomEvent('jobs', function(self, zoneData, posData)
    print(posData.type)
    if posData.type == 'cloakroom' then
        if self:IsOnDuty(zoneData.requiredDutyJob) then
            self:ShowNotify('info', TR("job_duty"), TR("job_duty_off"))
            self:RestoreClothes()
        else
            self:ApplyClothes(zoneData.requiredDutyJob)
            self:ShowNotify('info', TR("job_duty"), TR("job_duty_on"))
        end
        self:ToggleDuty(zoneData.requiredDutyJob)
    elseif self:IsOnDuty(zoneData.requiredDutyJob) then
        if posData.type == 'spawn-vehicle' then
            local _self = self
            if self.inventory:RemoveItem(zoneData.blackMoney and Config.Items.BlackMoney or Config.Items.Money, 'name', zoneData.caution or 2000) then
                Vehicle:Spawn(posData.vehicle, posData.spawnCoords.coords, posData.spawnCoords.heading, function(veh)
                    _self.jobVeh = veh
                    TaskWarpPedIntoVehicle(GetPlayerPed(_self.source), veh, -1)


                end)
            else
                self:ShowNotify('info', TR("job_caution"), TR("not_enough_money", zoneData.caution or 4000))
            end
        elseif posData.type == 'vehicle-delete' then
            local veh = GetVehiclePedIsIn(GetPlayerPed(self.source))
            if DoesEntityExist(veh) and self.jobVeh and self.jobVeh == veh then
                DeleteEntity(veh)
                self.inventory:AddItem({
                    name = zoneData.blackMoney and Config.Items.BlackMoney or Config.Items.Money,
                    count = zoneData.caution or 2000
                })
            end
        elseif posData.type == 'collect' then
            workin[self.source] = {
                posData = posData,
                xPlayer = self
            }
        end
        if posData.anim then
            self:PlayAnim(posData.anim.lib, posData.anim.anim, posData.anim.data)
        elseif posData.task then
            self:PlayTask(posData.task)
        end
    else
        self:ShowNotify('info', TR("cloakroom"), TR("no_duty_clothes"))
    end
end)

Thread:Create(function()
    while true do
        Wait(5000)
        for k5,v5 in pairs(workin) do
            local self = v5.xPlayer
            if not v5.xPlayer.posData then
                workin[k5] = nil
                self:ClearTask()
                goto continue
            end
            if v5.posData.rewardItems then
                for k,v in pairs(v5.posData.rewardItems) do
                    self.inventory:AddItem(v)
                end
            elseif v5.posData.exchangeItems then
                for k,v in pairs(v5.posData.exchangeItems) do
                    if self.inventory:RemoveItem(v.removeItem, 'name', v.amountToRemove) then
                        self.inventory:AddItem({
                            name = v.giveItem,
                            count = v.amountToGive
                        })
                    else
                        self:ClearTask()
                        workin[k5] =nil
                    end
                end
            end
            ::continue::
        end
    end
end)

User:OnCustomEvent('work_center', function(self, zoneData, posData)
    Event:TriggerNet('dwb:jobs:menu', self.source, DWB.Jobs, self.char.jobs)
end)