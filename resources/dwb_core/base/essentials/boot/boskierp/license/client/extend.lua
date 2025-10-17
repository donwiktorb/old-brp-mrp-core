function User:HasLicense(license)
    if not DWB.PlayerData.char then return end
    if not DWB.PlayerData.char.data.licenses then return end
    if type(license) == 'string' then
        for k,v in pairs(DWB.PlayerData.char.data.licenses) do
            if v == license then
                return true
            end
        end
    else
        for k,v2 in pairs(license) do
            for k2,v in pairs(DWB.PlayerData.char.data.licenses) do
                if v == v2 then
                    return true  
                end
            end
        end
    end
end