



Interior = class()

function Interior:Load(name, coords)
    RequestIpl(name)
    local int = GetInteriorAtCoords(coords or DWB.PlayerData.Coords)
    SetInteriorActive(int, true)
    PinInteriorInMemory(int) 
    RefreshInterior(int)
    DisableInterior(int, false)
end

function Interior:Unload(name, coords)
    local int = GetInteriorAtCoords(coords or DWB.PlayerData.Coords)
    DisableInterior(int, true)
    RemoveIpl(name)
    SetInteriorActive(int, false)

end

function LoadIpl(coords, props, propColors)
    for k,coords in pairs(coords) do
		local interiorID = GetInteriorAtCoords(coords[1], coords[2], coords[3])

		if IsValidInterior(interiorID) then
			PinInteriorInMemory(interiorID)

			for index,propName in pairs(props) do
				ActivateInteriorEntitySet(interiorID, propName)
			end

			if propColors then
				for i=1, #propColors, 1 do
					SetInteriorEntitySetColor(interiorID, propColors[i][1], propColors[i][2])
				end
			end

			RefreshInterior(interiorID)
		end
	end
end

Thread:Create(function()
    for k,v in pairs(Config.Ipls.Init) do
        if IsIplActive(v) then
            RemoveIpl(v)
            -- DeactivateInteriorEntitySet(v.id, v.style.normal)
            -- DeactivateInteriorEntitySet(v.id, v.shutter.opened)
        end


        RequestIpl(v) 
        -- ActivateInteriorEntitySet(v.id, v.style.normal)
        -- ActivateInteriorEntitySet(v.id, v.shutter.opened)
    end

    if Config.Ipls.LoadCustom then
        for k,v in pairs(Config.Ipls.Custom) do
            LoadIpl(v.coords, v.interiorsProps, v.interiorsPropColors)
        end
    end
end)