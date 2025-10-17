Event:Register('dwb:bank:open', function(data, open)
    if open and UI:IsOpen('bank') then
        UI:Open('Bank', data, function()
        
        end)
    else
        UI:Open('Bank', data, function()
        
        end)
    end
end, true)

RegisterNUICallback('bank_close', function(data, cb)
    Menu:CloseAll()
    cb({})
end)

RegisterNUICallback('bank_withdraw', function(data, cb)
    Event:TriggerNet('dwb:banking:withdraw', data)
    cb({})
end)

RegisterNUICallback('bank_deposit', function(data, cb)
    Event:TriggerNet('dwb:banking:deposit', data)
    cb({})
end)

RegisterNUICallback('bank_transfer', function(data, cb)
    Event:TriggerNet('dwb:banking:transfer', data)
    cb({})
end)