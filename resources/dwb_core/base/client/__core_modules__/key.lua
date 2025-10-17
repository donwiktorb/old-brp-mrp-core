Key = class()
Key.Listeners = {}

function Key:RemoveBy(key, value)
	for k, v in pairs(DWB.Keybinds) do
		if v[key] == value then
			DWB.Keybinds[k] = nil
			if v.single then
				return RegisterCommand(k, function() end)
			end

			RegisterCommand("-" .. k, function() end)

			RegisterCommand("+" .. k, function() end)
		end
	end
end

function Key:onMouseJustPressed(key, label, cb)
	DWB.CurrentKeyId = DWB.CurrentKeyId + 1

	if Config.Debug.Log.Binding then
		Log:Info("Binding " .. key .. " -> " .. label .. "[" .. GetCurrentResourceName() .. "]")
	end

	local name = GetHashKey(GetCurrentResourceName() .. "-" .. key .. "-" .. label)
	local dbg = debug.getinfo(2, "Sl")
	local mode = string.match(dbg.source, "%w+")
	DWB.Keybinds[name] = {
		cb = cb,
		mode = mode,

		single = true,
	}

	RegisterCommand(name, function()
		Handling:Call(DWB.Keybinds[name].cb)
	end)

	RegisterKeyMapping(name, label .. "~", "mouse_button", key)
end

function Key:onJustPressedAndReleased(key, label, cb, cbOff)
	DWB.CurrentKeyId = DWB.CurrentKeyId + 1

	if Config.Debug.Log.Binding then
		Log:Info("Binding " .. key .. " -> " .. label .. "[" .. GetCurrentResourceName() .. "]")
	end

	local name = GetHashKey(GetCurrentResourceName() .. "-" .. key .. "-" .. label)

	local dbg = debug.getinfo(2, "Sl")
	local mode = string.match(dbg.source, "%w+")
	DWB.Keybinds[name] = {
		cb = cb,
		cbOff = cbOff,

		mode = mode,
	}

	RegisterCommand("+" .. name, function()
		Handling:Call(DWB.Keybinds[name].cb)
	end)

	RegisterCommand("-" .. name, function()
		Handling:Call(DWB.Keybinds[name].cbOff)
	end)

	RegisterKeyMapping("+" .. name, label .. "~", "keyboard", key)
end

function Key:onJustPressed(key, label, cb)
	DWB.CurrentKeyId = DWB.CurrentKeyId + 1

	if Config.Debug.Log.Binding then
		Log:Info("Binding " .. key .. " -> " .. label .. "[" .. GetCurrentResourceName() .. "]")
	end
	local dbg = debug.getinfo(2, "Sl")
	local mode = string.match(dbg.source, "%w+")
	local name = GetHashKey(GetCurrentResourceName() .. "-" .. key .. "-" .. label)

	DWB.Keybinds[name] = {
		cb = cb,
		mode = mode,
	}

	RegisterCommand("+" .. name, function()
		Handling:Call(DWB.Keybinds[name].cb)
	end)

	RegisterKeyMapping("+" .. name, label .. "~", "keyboard", key)
end

function Key:onJustReleased(key, label, cb, kType)
	DWB.CurrentKeyId = DWB.CurrentKeyId + 1

	if Config.Debug.Log.Binding then
		Log:Info("Binding " .. key .. " -> " .. label .. "[" .. GetCurrentResourceName() .. "]")
	end

	local name = GetHashKey(GetCurrentResourceName() .. "-" .. key .. "-" .. label)

	local dbg = debug.getinfo(2, "Sl")
	local mode = string.match(dbg.source, "%w+")

	DWB.Keybinds[name] = { cb = cb, mode = mode }

	RegisterCommand("+" .. name, function() end)

	RegisterCommand("-" .. name, function()
		Handling:Call(DWB.Keybinds[name].cb)
	end)

	local kType = kType or "keyboard"

	RegisterKeyMapping("+" .. name, label .. "~", kType, key)
end

function Key:onPressed(key, label, cb, cbOff)
	DWB.CurrentKeyId = DWB.CurrentKeyId + 1

	if Config.Debug.Log.Binding then
		Log:Info("Binding " .. key .. " -> " .. label .. "[" .. GetCurrentResourceName() .. "]")
	end

	local name = GetHashKey(GetCurrentResourceName() .. "-" .. key .. "-" .. label)

	local dbg = debug.getinfo(2, "Sl")
	local mode = string.match(dbg.source, "%w+")
	DWB.Keybinds[name] = {
		cb = cb,
		cbOff = cbOff,
		mode = mode,
	}

	local isPressed = false

	RegisterCommand("+" .. name, function()
		isPressed = true
		while isPressed do
			Handling:Call(DWB.Keybinds[name].cb)
			Citizen.Wait(0)
		end
	end)

	RegisterCommand("-" .. name, function()
		isPressed = false
		if cbOff then
			Handling:Call(DWB.Keybinds[name].cbOff)
		end
	end)

	RegisterKeyMapping("+" .. name, label .. "~", "keyboard", key)
end
