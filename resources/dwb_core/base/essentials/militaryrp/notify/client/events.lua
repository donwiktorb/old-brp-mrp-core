Event:Register('dwb:notify:show', function(type, title, description)
    Notification:ShowCustom(type, title, description)
end, true)