local show = false

local front = {
    plateStyle = "white",
    plate = "",
    speed = 55,
    limit = 50,
    diff = 5,
    locked = false
}




local rear = {
    plateStyle = "white",
    plate = "",
    speed = 55,
    limit = 50,
    diff = 5,
    locked = false
}

function updateRadar()
    UI:Action('PoliceRadar', 'police-radar', 'open', {
        show = show,
        front = front or {
            plateStyle = "white",
            plate = "",
            speed = 55,
            limit = 50,
            diff = 5,
            locked = true
        },
        rear = rear or {
            plateStyle = "yellow",
            plate = "",
            speed = 50,
            limit = 50,
            diff = 5,
            locked = true
        },
        class = DWB.UISettings['radar-main'] or 0
    })
end

function scanFront()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
    local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
    local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
    local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
    local a, b, c, d, j  = GetShapeTestResult(frontcar)

    
    if IsEntityAVehicle(j) then
    
        local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))

        local bvspeed = GetEntitySpeed(j)*3.6

        local bplate = GetVehicleNumberPlateText(j)

        local plateIndex  =GetVehicleNumberPlateTextIndex(j)

        front.plate = bplate
        front.speed = math.ceil(bvspeed)
        front.plateStyle = (plateIndex == 2 or plateIndex == 3) and 'blue' or (plateIndex == 1 or plateIndex == 5) and 'white' or 'yellow'
        front.diff = front.limit - front.speed

        if front.diff > 0 then
            front.diff = 0
        end

        updateRadar()
    end
end

function scanRear()
	local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)

    local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
    local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
    local f, g, h, i, j = GetShapeTestResult(rearcar)
    
    if IsEntityAVehicle(j) then
    
        local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))

        local bvspeed = GetEntitySpeed(j)*3.6

        local bplate = GetVehicleNumberPlateText(j)

        local plateIndex  =GetVehicleNumberPlateTextIndex(j)

        rear.plate = bplate
        rear.speed = math.ceil(bvspeed)
        rear.plateStyle = (plateIndex == 2 or plateIndex == 3) and 'blue' or (plateIndex == 1 or plateIndex == 5) and 'white' or 'yellow'
        rear.diff = rear.limit - rear.speed

        if rear.diff > 0 then
            rear.diff = 0
        end

        updateRadar()
    end
end

function startRadar()
    while show do
        Wait(500)
        if not front.locked then
            scanFront()
        end

        if not rear.locked then
            scanRear()
        end

	    local ispolice = IsPedInAnyPoliceVehicle(PlayerPedId())
        if not ispolice then
            show = false
            updateRadar()
        end
    end
end

Key:onJustPressed("L", 'Radar (NUMPAD5) (LSPD)' ,function()
	local ispolice = IsPedInAnyPoliceVehicle(PlayerPedId())
    if ispolice then
        show = not show
        updateRadar()
        startRadar()
    end
end)

Key:onJustPressed("J", 'Radar (NUMPAD5) (LSPD)' ,function()
    front.locked = not front.locked
    updateRadar()
end)

Key:onJustPressed("K", 'Radar (NUMPAD5) (LSPD)' ,function()
    rear.locked = not rear.locked
    updateRadar()
end)