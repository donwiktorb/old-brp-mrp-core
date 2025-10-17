local isOpen = false

Key:onPressed('Y', 'Kompas', function()
    
    if not isOpen then
        UI:Action('Compass', 'compass', 'open', {})
        isOpen = true
    end

    local heading = GetGameplayCamRot(0)
    heading = 360.0-((heading.z+36.0) % 360.0)
    UI:Action('Compass', 'compass', 'update', {
        heading = heading
    })

end, function()
    UI:Action('Compass', 'compass', 'close', {})
    isOpen = false
end)