Thread:Create(function()
    DisableIdleCamera(true)
	while not DWB.PlayerLoaded do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			Event:TriggerNet('dwb:player:joined')
			return
		end
	end
end)