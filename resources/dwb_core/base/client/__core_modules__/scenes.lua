Scenes = class()

function Scenes:Play(name, music)
    PrepareMusicEvent(music) 
	TriggerMusicEvent(music) 
    local playerId = PlayerPedId()
	RequestCutsceneWithPlaybackList(name, 31, 8)

    while not HasCutsceneLoaded() do Wait(10) end 

	NewLoadSceneStartSphere(GetEntityCoords(playerId), 1000, 0) 
    StartCutscene(0) 
    Wait(31520)
	PrepareMusicEvent("AC_STOP")
	TriggerMusicEvent("AC_STOP")
end

function Scenes:StopInstant()
    StopCutsceneImmediately()
end
