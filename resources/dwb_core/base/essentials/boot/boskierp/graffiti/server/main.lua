
local scaleforms = {}

Item:RegisterUsable('graffiti', function(source)
    local xPlayer = DWB.Players[source]
    local item = xPlayer.inventory:GetItem('graffiti', 'name')
    local ml = item.data.ml and item.data.ml - 200 or 800
    if ml >= 0 then
        xPlayer.inventory:SetItemData(item.slot, 'slot', {
            ml = ml
        })
        Event:TriggerNet('dwb:graffiti:draw', source)
    else
        xPlayer.inventory:RemoveItem(item.slot, 'slot', 1)
    end
end)

Event:Register('dwb:graffiti:new', function(source, xPlayer,coords, scale, text, color, rot)
    table.insert(scaleforms, {
        coords = coords,
        scale = scale,
        text = text,
        color = color,
        rot = rot,
        owner = source,
        time = os.time()
    })

    Event:TriggerNet('dwb:graffiti:sync', -1, scaleforms)
end, true)

Event:Register('dwb:weather:changed', function(source, xPlayer,weather)
    if weather == 'RAIN' then
        scaleforms = {}
        Event:TriggerNet('dwb:graffiti:sync', -1, scaleforms)
    end
end)

User:OnLoaded(function(self)
    Event:TriggerNet('dwb:graffiti:sync', self.source, scaleforms)
end)