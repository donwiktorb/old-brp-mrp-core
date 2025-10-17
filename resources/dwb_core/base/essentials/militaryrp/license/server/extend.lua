function User:HasLicense(license)
    if not self.char.licenses then return end
    for k,v in pairs(self.char.licenses) do
        if v == license then
            return true
        end
    end
end

function User:AddLicense(license)
    if self:HasLicense(license) then return end

    if not self.char.licenses then
        self.char.licenses = {}
    end
     
    table.insert(self.char.licenses, license)
end

function User:RemoveLicense(license)
    if not self:HasLicense(license) then return end
    for k,v in pairs(self.char.licenses) do
        if v == license then 
            table.remove(self.char.licenses, k)
        end
    end
end