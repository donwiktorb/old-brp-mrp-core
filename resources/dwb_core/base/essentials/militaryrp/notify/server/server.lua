function User:ShowNotify(type, title, description)
    Event:TriggerNet('dwb:notify:show', self.source, type, title, description)
end