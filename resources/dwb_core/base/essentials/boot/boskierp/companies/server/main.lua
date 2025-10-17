Event:Register("dwb:company:open:locker", function(source, xPlayer)
    local job = xPlayer:GetJobByType("company")
    if job then
        xPlayer.inventory:OpenSimple({
            name = "company",
            label = "Szafka",
            items = DWB.Jobs[job.name].items,
        }, function(data, inv)
            Job:SaveJob(job.name)
        end)
    end
end, true)

User:OnCustomEvent("company-room", function(self, zoneData, posData)
    local job = self:GetJobByType("company")
    if job then
        local users = Users:GetAllByElements(function(k, v)
            return v:GetJob(job.name)
        end)

        if posData.company == job.name then
            Event:TriggerNet(
                "dwb:company:open",
                self.source,
                posData,
                job,
                DWB.Jobs[posData.company].clothes,
                users,
                DWB.Jobs[posData.company].data
            )
        end
    end
end)
Event:Register('dwb:company:save:skin', function(source, xPlayer,name, skin)
    local job = self:GetJobByType('company')
    if job then
        table.insert(DWB.Jobs[job.name].clothes, {
            label = name,
            skin = skin
        })
        Job:SaveJob(job.name)
    end
end, true)
Event:Register('dwb:company:remove:skin', function(source, xPlayer,id)
    local job = self:GetJobByType('company')
    if job then
        table.remove(DWB.Jobs[job.name].clothes, id)
        Job:SaveJob(job.name)
    end
end, true)
Event:Register("dwb:company:deposit", function(source, xPlayer, value)
    local job = xPlayer:GetJobByType("company")
    if job then
        local item = xPlayer.inventory:GetItem(Config.Items.Money, 'name')
        if item.count >= value then
            if Job:AddMoney(job.name, value) then
                xPlayer.inventory:RemoveItem(item.slot, 'slot', value)
                Job:SaveData(job.name)
            end
        end
    end
end, true)
Event:Register("dwb:company:withdraw", function(source, xPlayer, value)
    local job = xPlayer:GetJobByType("company")
    if job then
        local item = xPlayer.inventory:GetItem(Config.Items.Money, 'name')
        if item.count >= value then
            if Job:RemoveMoney(job.name, value) then
                xPlayer.inventory:AddItem({
                    name = Config.Items.Money,
                    count = value
                })
                Job:SaveData(job.name)
            end
        end
    end
end, true)

Event:Register("dwb:company:add:user", function(source, xPlayer, id)
    local job = xPlayer:GetJobByType("company")
    if job then
        DWB.Players[id]:SetJob(job.name, 1)
    end
end, true)

Event:Register("dwb:company:remove:user", function(source, xPlayer, id)
    local job = xPlayer:GetJobByType("company")
    if job then
        DWB.Players[id]:RemoveJob(job.name, 1)
    end
end, true)

local workin = {}

User:OnCustomEvent("jobs-company", function(self, zoneData, posData)
    if posData.type == "cloakroom" then
        if self:IsOnDuty(zoneData.requiredDutyJob) then
            self:ShowNotify("info", TR("job_duty"), TR("job_duty_off"))
            self:RestoreClothes()
        else
            self:ApplyClothes(zoneData.requiredDutyJob)
            self:ShowNotify("info", TR("job_duty"), TR("job_duty_on"))
        end
        self:ToggleDuty(zoneData.requiredDutyJob)
    elseif self:IsOnDuty(zoneData.requiredDutyJob) then
        if posData.type == "spawn-vehicle" then
            local _self = self
            if
                self.inventory:RemoveItem(
                    zoneData.blackMoney and Config.Items.BlackMoney or Config.Items.Money,
                    "name",
                    zoneData.caution or 2000
                )
            then
                Vehicle:Spawn(posData.vehicle, posData.spawnCoords.coords, posData.spawnCoords.heading, function(veh)
                    _self.jobVeh = veh
                    TaskWarpPedIntoVehicle(GetPlayerPed(_self.source), veh, -1)
                end)
            else
                self:ShowNotify("info", TR("job_caution"), TR("not_enough_money"))
            end
        elseif posData.type == "vehicle-delete" then
            local veh = GetVehiclePedIsIn(GetPlayerPed(self.source))
            if DoesEntityExist(veh) and self.jobVeh and self.jobVeh == veh then
                DeleteEntity(veh)
                self.inventory:AddItem({
                    name = zoneData.blackMoney and Config.Items.BlackMoney or Config.Items.Money,
                    count = zoneData.caution or 2000,
                })
            end
        elseif posData.type == "collect" then
            if posData.anim then
                self:PlayAnim(posData.anim.lib, posData.anim.anim, posData.anim.data)
            end
            workin[self.source] = {
                posData = posData,
                xPlayer = self,
            }
        elseif posData.type == 'add-vehicle' then
            local plate = posData.plate:format(self.charId)
            if not self.garage:HasVehicleByPlate(plate) then
                self.garage:AddVehicle({
                    vehicle = {
                        model = GetHashKey(posData.vehicle),
                        plate = plate
                    }
                })
            else
                self:ShowNotify("info", TR("vehicle_garage"), TR("already_owned"))
            end
        end
    else
        self:ShowNotify("info", TR("cloakroom"), TR("no_duty_clothes"))
    end
end)

Thread:Create(function()
    while true do
        Wait(5000)
        for k5, v5 in pairs(workin) do
            local self = v5.xPlayer
            if not v5.xPlayer.posData then
                workin[k5] = nil
                self:ClearTask()
                goto continue
            end
            if v5.posData.rewardItems then
                for k, v in pairs(v5.posData.rewardItems) do
                    self.inventory:AddItem(v)
                end
            elseif v5.posData.exchangeItems then
                for k, v in pairs(v5.posData.exchangeItems) do
                    if self.inventory:RemoveItem(v.removeItem, "name", v.amountToRemove) then
                        self.inventory:AddItem({
                            name = v.giveItem,
                            count = v.amountToGive,
                        })
                    else
                        self:ClearTask()
                        workin[k5] = nil
                    end
                end
            elseif v5.posData.pay then
                local payData = v5.posData.pay
                local job = self:GetJobByType("company")
                local companyPercent = job.data and job.data.percent or 10
                local companyAmount = payData.amount/companyPercent
                local userAmount = payData.amount-companyAmount
                self.inventory:AddItem({
                    name = payData.item,
                    count = userAmount,
                })
                Job:AddMoney(job.name, companyAmount)
                Job:SaveData(job.name)
                workin[k5] = nil
            end
            ::continue::
        end
    end
end)

