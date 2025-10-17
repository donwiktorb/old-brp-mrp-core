local desc = {}
local showme = {}
local nbrDisplaying2 = 7

Citizen.CreateThread(function()
    local getCoords = GetEntityCoords
    local getPed = GetPlayerPed
    while true do
        Wait(0)
        -- local letSleep = trueGetPlayerPed
        for k,v in pairs(showme) do
            -- letSleep = false
            local pped = getPed(k)
            local pcoords = getCoords(pped)
            -- local pcoords = v.coords
            DrawText3D(pcoords['x'], pcoords['y'], pcoords['z'], v.value)
        end

        -- if letSleep then
        --     Citizen.Wait(500)
        -- end
    end
end)

Citizen.CreateThread(function()
    local getCoords = GetEntityCoords
    local clearLos = HasEntityClearLosToEntity
    local getPed = GetPlayerPed

    while true do
        Wait(0)
        local letSleep = true
        local ped = PlayerPedId()
        local coords = getCoords(ped)
        showme = {}
        for k,v in pairs(desc) do
            -- local pcoords = getCoords(pped)
            local pcoords = v.coords
            local dist = #(coords - pcoords)
            if dist <= 18 then
                local pped = GetPlayerPed(k)
                if clearLos(pped --[[ Entity ]], ped --[[ Entity ]], 17 --[[ integer ]]) then
                    showme[k] = v
                    -- letSleep = false
                    -- DrawText3D(pcoords['x'], pcoords['y'], pcoords['z'], v)
                end
            end
        end

        if letSleep then
            Citizen.Wait(1000)
        end
    end
end)

function DrawText3D(x,y,z, text, type)
    coords = vector3(x,y,z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	if type == 'me' then
    SetTextColour(227, 5, 252, 255)
    elseif type =='do' then
    SetTextColour(5, 145, 252, 255)
    else
    SetTextColour(255, 255, 255, 255)
    end
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
    
    -- local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    -- if onScreen then
    --     local px,py,pz = table.unpack(GetGameplayCamCoord())
    --     local dist = #(vector3(px,py,pz) - vector3(x,y,z))
    --     local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100
        
    --     SetTextScale(0.0*scale, 0.55*scale)
    --     SetTextFont(0)
    --     SetTextProportional(1)
    --     SetTextCentre(true)
    --     BeginTextCommandWidth("STRING")
    --     AddTextComponentString(text)
    --     local height = GetTextScaleHeight(0.55*scale, 0)
    --     local width = EndTextCommandGetWidth(0)
    --     SetTextEntry("STRING")
    --     AddTextComponentString(text)
    --     EndTextCommandDisplayText(_x, _y)
    -- end
end

RegisterNetEvent('dwb_rpchat:descUpdated')
AddEventHandler('dwb_rpchat:descUpdated', function(table)
    desc = {}
    for k,v in pairs(table) do
        desc[GetPlayerFromServerId(k)] = v
    end
end)

Event:Register('dwb:rpchat:me', function(id,msg)
    local pid = GetPlayerFromServerId(id)
    local offset = (nbrDisplaying2*0.14)
    Display(pid, "*"..msg.."*" , offset, 'me')
    Event:Trigger('dwb:chat:addMessage', {
        template =  '<b><font size="3" color="purple">ME | [{0}]  </font></b></i><b><i><font color="white">*{1}*</font</b>',
        args = { id, msg }
    })
end, true)

Event:Register('dwb:rpchat:do', function(id,msg)
    local pid = GetPlayerFromServerId(id)
    local offset = (nbrDisplaying2*0.14)
    Display(pid, "*"..msg.."*" , offset, 'do')
    Event:Trigger('dwb:chat:addMessage', {
        template = '<b><font size="3" color="lightblue">DO | [{0}]  </font></b></i><b><i><font color="white">*{1}*</font></b>',
        args = { id, msg }
    })
end, true)

function Display(mePlayer, text, offset, type)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(7000)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying2 = nbrDisplaying2 + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = #(coordsMe - coords)
            if dist < 2500 then
                if HasEntityClearLosToEntity(GetPlayerPed(mePlayer) --[[ Entity ]], PlayerPedId() --[[ Entity ]], 17 --[[ integer ]]) then
                    DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text, type)
                end
            end
        end
        nbrDisplaying2 = nbrDisplaying2 - 1
    end)
end