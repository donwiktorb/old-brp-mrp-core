
local function dbg(msg)
    Log:Warn(msg)
end

AddEventHandler("fireEvent", function(source, data)
	dbg('fireEvent ' .. source .. ' '.. json.encode(data), true)
	-- -- TriggerEvent("banmere", source, "playSound "..data.weaponType.." ".. data.ammo)
	-- -- CancelEvent()
end)



AddEventHandler("networkPlaySoundEvent", function(source, data)
	dbg('playSound ' .. source .. ' '.. json.encode(data), true)
	-- -- TriggerEvent("banmere", source, "playSound "..data.weaponType.." ".. data.ammo)
	CancelEvent()
end)

AddEventHandler("playSoundEvent", function(source, data)
	dbg('playSound ' .. source .. ' '.. json.encode(data), true)
	-- -- TriggerEvent("banmere", source, "playSound "..data.weaponType.." ".. data.ammo)
	CancelEvent()
end)

AddEventHandler("soundEvent", function(source, data)
	dbg('playSound ' .. source .. ' '.. json.encode(data), true)
	-- -- TriggerEvent("banmere", source, "playSound "..data.weaponType.." ".. data.ammo)
	CancelEvent()
end)

AddEventHandler("giveWeaponEvent", function(source, data)
    local ped = NetworkGetEntityFromNetworkId(data.pedId)
    if IsPedAPlayer(ped) then
        dbg('giveWeaponEvent ' .. source .. ' '.. json.encode(data), true)
        CancelEvent()
    end
end)

AddEventHandler("weaponDamageEvent", function(source, data)
	dbg('weaponDamageEvent ' .. source .. ' '.. json.encode(data))
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
    local ped = NetworkGetEntityFromNetworkId(data.pedId)
    if IsPedAPlayer(ped) then
	dbg('clearPedTasksEvent ' .. source .. ' '.. json.encode(data))
	if data.immediately then
		CancelEvent()
	end
end
end)

AddEventHandler('gameEventTriggered', function (name, args)
	dbg('gameEventTriggered'.. name .. json.encode(args))
end)

AddEventHandler('ptFxEvent', function(sender, ev)
	dbg('ptFxEvent ' .. sender .. ' ' .. ev.effectHash)
	CancelEvent()
end)

AddEventHandler('explosionEvent', function(sender, ev)
	dbg('explosionEvent ' .. sender .. ' ' .. json.encode(ev))
	CancelEvent()
end)

AddEventHandler('vehicleComponentControlEvent', function(sender, ev)
	dbg('vehicleComponentControlEvent ' .. sender .. ' '..json.encode(ev)..' '..source)
    -- local xPlayer = DWB.Players[sender]
    -- local job = xPlayer:GetJob('mechanic')
    -- if not job then
    --     CancelEvent()
    -- end
end)

AddEventHandler("respawnPlayerPedEvent", function(player, content)
	dbg('respawnPlayerPedEvent '.. player .. ' ' ..json.encode(content))
	if content.posX ~= 0 and content.posY ~= 0 and content.posZ ~= 0  then

	end
end)

AddEventHandler('entityCreating', function(entity)
	local model = GetEntityModel(entity)
    if Config.Anticheat.Blacklist.Vehicles[model] then
        CancelEvent()
    end
end)

AddEventHandler('entityCreated', function(entity)
    CancelEvent()
end)

AddEventHandler('entityRemoved', function(entity)
    Entity(entity).state.data = nil
    Entity(entity).state.action = nil
end)


Thread:Create(function()
    while true do
        Wait(30000)
        for k,v in pairs(DWB.Players) do
            if v.syncTime then
                local dist = os.time() - v.syncTime
                if dist >= 500 then
                    Event:Trigger('dwb:admin:ban:me', source, 'Anticheat (Stopped resource)', -1)
                end
            end
        end
    end
end)

Event:Register('dwb:ac:sync', function(source, xPlayer)

    -- -- print(source, xPlayer)
    -- if IsPlayerUsingSuperJump(source) then
    --     Event:Trigger('dwb:admin:ban:me', source, 'Anticheat (Super Jump)', -1)
    -- end
    xPlayer.syncTime = os.time()
end, true)

Event:Register('dwb:ac:weapon', function(source, xPlayer, hash)
    local found = false
    for k,v in pairs(xPlayer.char.inventory) do
        if GetHashKey(v.name)  == hash then
            found = true
        end
    end
    -- -- -- -- if not found then
    -- -- -- --     Event:Trigger('dwb:admin:ban:me', source, 'Anticheat (Weapon Spawn) '..hash, -1)
    -- -- -- -- end
end, true)

-- -- Thread:Create(function()
-- --     while true do
-- --         Wait(30000)
-- --         for k,v in pairs(DWB.Players) do
-- --             if v.syncTime then
-- --                 local dist = os.time() - v.syncTime
-- --                 if dist >= 10 then
-- --                     Event:Trigger('dwb:admin:ban:me', source, 'Stopped res', -1)
-- --                 end
-- --             end
-- --         end
-- --     end
-- -- end)
