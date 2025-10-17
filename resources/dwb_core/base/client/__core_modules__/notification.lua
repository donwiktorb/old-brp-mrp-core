Notification = class()

function Notification:Show(msg)
    AddTextEntry('dwbNotification', msg)
	SetNotificationTextEntry('dwbNotification')
	DrawNotification(false, true)
end

function Notification:ShowCustom(type, subject, msg, time)
    if not Config.Notifications.Types[type] then return self:ShowCustom2(type, subject, msg, time) end 

	if type == 'info' then
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
	elseif type == 'warning' then
        type = 'warn'
		PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1)
	elseif type == 'success' then
		PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
	end

    -- Notify:new(type, subject, msg)
    UI:Action('Notify', 'notify', 'add', {
        type = type,
        title = subject,
        content = msg,
        time = time or 250
    })

end

function Notification:ShowCustom2(type5, subject, msg, time)
    local notify = Table:Copy(Config.Notifications.Custom[type5])

    if notify then
        if notify.sound then
            if notify.type == 'gta5' then
                PlaySoundFrontend(-1, notify.sound.name, notify.sound.name2 , 1)
            else
                Sound:Play(notify.sound.name, notify.sound.volume)
            end
        end


        if type(notify.content) == 'table' then
            notify.title = subject
            for k,v in pairs(notify.content) do
                notify.content[k].content = string.format(notify.content[k].content, msg[k]) 
                msg[k] = nil
            end
            for k,v in pairs(msg) do
                if string.find(v, 'boskierp.pl') then
                    notify.style.img = v
                    msg[k] = nil
                end
            end
        else
            if notify.translate == 2 then
                notify.content = TR(notify.content, type(msg) == 'table' and table.unpack(msg) or msg)
                if subject then
                    notify.title = TR(notify.title, type(subject) == 'table' and table.unpack(subject) or subject)
                else
                    notify.title = TR(notify.title)
                end
            end
        end

        notify.time = time or 250

        UI:Action('Notify', 'notify', 'add', notify)
    end

    -- Notify:new(type, subject, msg)

end

function Notification:ShowInventory(item, count, remove)
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)

    -- Notify:new(type, subject, msg)
    UI:Action('Notify3', 'notify3', 'add', {
        type = 'inv',
        time = time or 250,
        remove = remove,
        count = count,
        item = item
    })

end

function Notification:ShowPrettier(type, subject, msg)
	BeginTextCommandThefeedPost("STRING")
	if type == 'info' then
		ThefeedNextPostBackgroundColor(200)
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandThefeedPostMessagetext('CHAR_INFO', 'CHAR_INFO', true, false, 'Informacja', '~b~'..subject)
		PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
	elseif type == 'warning' then
		ThefeedNextPostBackgroundColor(6)
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandThefeedPostMessagetext('CHAR_WARNING', 'CHAR_WARNING', true, false, 'Uwaga', '~r~'..subject)
		PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1)
	elseif type == 'success' then
		ThefeedNextPostBackgroundColor(184)
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandThefeedPostMessagetext('CHAR_SUCCESS', 'CHAR_SUCCESS', true, false, 'Udane', '~g~ '..subject)
		PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
	end
	ThefeedSetAnimpostfxCount(1)
	ThefeedSetAnimpostfxColor(0, 0, 0, 255)
	EndTextCommandThefeedPostTicker(true, true)
end

function Notification:ShowHelp(msg)
	AddTextEntry('dwbHelpNotification', msg)
	BeginTextCommandDisplayHelp('dwbHelpNotification')
	EndTextCommandDisplayHelp(0, false, true, -1)
end

function Notification:ShowAdvanced(title, subject, msg, icon, icontype, flash, color)
	BeginTextCommandThefeedPost("STRING")
	
	if color then
		ThefeedNextPostBackgroundColor(color)
	end

	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostMessagetext(icon, icon, true, icontype, title, subject)
	ThefeedSetAnimpostfxCount(1)
	ThefeedSetAnimpostfxColor(0, 0, 0, 255)
	EndTextCommandThefeedPostTicker(true, true)
end

-- function Notification:ShowAdvanced(title, subject, msg, icon, icontype, flash)
-- 	AddTextEntry('dwbAdvancedNotification', msg)
-- 	SetNotificationTextEntry('dwbAdvancedNotification')
-- 	SetNotificationMessage(icon, icon, flash, iconType, title, subject)
-- 	DrawNotification(false, false)
-- end
