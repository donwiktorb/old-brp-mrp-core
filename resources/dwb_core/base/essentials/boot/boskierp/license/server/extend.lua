function User:HasLicense(license)
    if not self.char.data.licenses then return end
    if type(license) == 'string' then
    for k,v in pairs(self.char.data.licenses) do
        if v == license then
            return true
        end
    end
    else
        for k,v2 in pairs(license) do
            for k2,v in pairs(self.char.data.licenses) do
                if v == v2 then
                    return true  
                end
            end
        end
    end
end

function User:AddLicense(license, noSync)
    if self:HasLicense(license) then return end

    if not self.char.data.licenses then
        self.char.data.licenses = {}
    end
     
    table.insert(self.char.data.licenses, license)


    self:SetCharData('licenses', self.char.data.licenses)
end

function User:RemoveLicense(license, noSync)
    if not self:HasLicense(license) then return end
    for k,v in pairs(self.char.data.licenses) do
        if v == license then 
            table.remove(self.char.data.licenses, k)
        end
    end

    self:SetCharData('licenses', self.char.data.licenses)
end


