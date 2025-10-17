DUI = class({
	txds = {},
	menus = {},
})

function DUI:Open(type, data, s, c, ch, cl)
	local name = data.name
	local txd = self.txds[name]

	if not txd then
		txd = CreateRuntimeTxd(name)
		self.txds[name] = txd
	end

	local scale = data.scale or 1
	local screenWidth = math.floor(1920 * scale)
	local screenHeight = math.floor(1080 * scale)

	local duiObject = CreateDui(duiUrl, screenWidth, screenHeight)

	local duiHandle = GetDuiHandle(duiObject)

	local runtimeTxt = CreateRuntimeTextureFromDuiHandle(txd, name, duiHandle)

	RequestStreamedTextureDict(name)
	while not HasStreamedTextureDictLoaded(name) do
		Wait(0)
	end
	SendDuiMessage(
		duiObject,
		json.encode({
			action = "open",
			type = type,
			data = data,
		})
	)

	local element = {}

	element.close = function()
		DUI:Close(type, name)
	end
end

function DUI:Close(type, data)
	SendNUIMessage({
		action = "close",
		type = type,
		data = data,
	})
end
