Thread:Create(function()
    while true do
        local allCam = Scaleform:GetAll()
        local sleep = 500
        for k,v in pairs(allCam) do
            if v.fullscreen then
                sleep = 0
            DrawScaleformMovieFullscreen(v.scaleform, 255, 255, 255, 255, 0)
            end
        end
        Wait(sleep)
    end
end)