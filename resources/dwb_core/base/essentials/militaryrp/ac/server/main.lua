
AddEventHandler('explosionEvent', function(sender, ev)
	-- -- dbg('explosionEvent ' .. sender .. ' ' .. ev.explosionType)
    print(sender, ev.explosionType)
    print(json.encode(ev))
end)