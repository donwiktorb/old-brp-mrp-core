function Scaleform:RaceCountdown(time, cb)
    local scaleform = Scaleform:Request('countdown')
    Scaleform:Add('race', scaleform, true)
    local count = 0
    while count < time do
        Wait(1000)
        count = count + 1
        BeginScaleformMovieMethod(scaleform, "SET_COUNTDOWN_LIGHTS")
        ScaleformMovieMethodAddParamInt(count or time)
        EndScaleformMovieMethod()
        PlaySoundFrontend( -1 --[[ integer ]], "SELECT"	 --[[ string ]], "HUD_FRONTEND_DEFAULT_SOUNDSET"	 --[[ string ]], true --[[ boolean ]])
    end
    BeginScaleformMovieMethod(scaleform, "FADE_MP")
    ScaleformMovieMethodAddParamTextureNameString("XDJj")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(255)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(255)
    EndScaleformMovieMethod()
    Wait(500)
    Scaleform:Remove('race')
    if cb then cb() end
end