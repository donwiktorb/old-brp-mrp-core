function User:ShowNotify(type, title, description)
    Event:TriggerNet('dwb:notify:custom', self.source, type, title, description)
end