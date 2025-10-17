
AddEventHandler('onResourceStop', function(resName)
    if GetCurrentResourceName() == resName then
        return SavePlayers()
    end
end)