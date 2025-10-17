function User:ApplyClothes(clothes, ignore)
    Event:TriggerNet('dwb:skin:apply:clothes', self.source, clothes, ignore)
end

function User:RestoreClothes()
    Event:TriggerNet('dwb:skin:restore:clothes', self.source)
end