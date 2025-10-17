User:OnLoadedChar(function(data)
    for k,v in pairs(DWB.PlayerData.char.data.skills or {}) do
        StatSetInt(GetHashKey(k), v, true)
    end
end)

User:OnSyncCharData(function()
    for k,v in pairs(DWB.PlayerData.char.data.skills or {}) do
        StatSetInt(GetHashKey(k), v, true)
    end
end)