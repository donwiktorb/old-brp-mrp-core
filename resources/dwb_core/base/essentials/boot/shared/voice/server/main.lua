
Item:RegisterUsable('radio', function(source)
    Event:TriggerNet('dwb:radio:show', source)
end)


Event:Register('dwb:cursor:submit', function(source, xPlayer,action, entityId, data, entData)
    if action.name == 'player' and data.current.value == 'mute' then
        Event:TriggerNet('dwb:voice:mute', source, entData.player)
    end
end, true)


local globalThis=  {}
local channels = {}

Thread:Create(function()
    SetConvarReplicated("voice_useNativeAudio", "true")
	SetConvarReplicated("voice_use3dAudio", "true")	
	SetConvarReplicated("voice_useSendingRangeOnly", "true")	

	for i = 1, GetMaxChunkId() do
		MumbleCreateChannel(i)
	end
end)

User:OnUnloaded(function(self)
    for k,v in pairs(channels) do
        if type(v) == 'table' then
            for k2,v2 in pairs(v) do
                if v2 == self.source then
                    table.remove(v, tostring(k2))
                    if #v <= 0 then
                        channels[k] = nil
                    end
                end
            end
        end
    end
end)

Event:Register('dwb:voice:radio:set', function(source, xPlayer,radio)
    globalThis = {}
    if radio > 0 then
        if not channels[radio] then
            channels[radio] = {}
        end

        table.insert(channels[radio], source)

        xPlayer.radio = source

        for k,v in pairs(channels[radio]) do
            Event:TriggerNet('dwb:voice:radio:sync', v, channels[radio])
        end
    end
end, true)

Event:Register('dwb:voice:radio:toggle', function(source, xPlayer,radio, toggle)
    if radio > 0 then
        local data = {
            name = string.format('(%s) %s %s', source, xPlayer.char.data.firstname, xPlayer.char.data.lastname) 
        }

        for k,v in pairs(channels[radio] or {}) do
            Event:TriggerNet('dwb:voice:radio:sync', v, source, toggle, data)
        end
    end
end, true)