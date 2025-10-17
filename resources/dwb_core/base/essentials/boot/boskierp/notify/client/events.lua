Event:Register("dwb:notify:show", function(type, title, description)
  Notification:ShowCustom(type, title, description)
end, true)

Event:Register("dwb:notify:custom", function(type, title, description)
  Notification:ShowCustom(type, title, description)
end, true)

