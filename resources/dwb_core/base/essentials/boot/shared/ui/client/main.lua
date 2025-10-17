Event:Register('dwb:ui:open' ,function(type, uiData, data2)
    UI:Open(type, uiData, function(data,menu)
        -- submit
        if data2.submitCb then
            Event:TriggerNet('dwb:ui:submit', data, menu)
        end
        if data2.closeAfterSubmit then
            menu.close()
        end
    end, function(data,menu)
        -- cancel
        if data2.cancelCb then
            Event:TriggerNet('dwb:ui:cancel', data, menu)
        end
        if data2.closeAfterCancel then
            menu.close()
        end
    end, function(data, menu)
        if data2.changedCb then
            Event:TriggerNet('dwb:ui:changed', data, menu)
        end
    end)
end, true)