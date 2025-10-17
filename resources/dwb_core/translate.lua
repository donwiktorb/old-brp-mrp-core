local language = {}
local currentLang
local translations = {
	"admin",
	"main",
	"locale",
	"inventory",
	"commands",
	"skin",
	"weapons",
	"weapon.components",
}

function SetLanguage(lang, type, file)
	if not file then
		file = type
	end
	currentLang = lang
	local newLang = json.decode(
		LoadResourceFile(GetCurrentResourceName(), "base/data/shared/languages/" .. lang .. "/" .. file .. ".json")
	)
	for k, v in pairs(newLang) do
		language[k] = v
	end
end

function TR(name, ...)
	if language[name] then
		return tostring(string.format(language[name], ...):gsub("^%l", string.upper))
	else
		return "no_string" .. name .. " " .. json.encode({ ... }), 10
	end
end

function SetTranslation(lang, type, file, k, v)
	language[k] = v
	local data = json.decode(
		LoadResourceFile(GetCurrentResourceName(), "base/data/shared/languages/" .. lang .. "/" .. file .. ".json")
			or "{}"
	) or {}
	data[k] = v
	SaveResourceFile(
		"dwb",
		"base/data/shared/languages/" .. lang .. "/" .. file .. ".json",
		json.encode(data, { indent = 4 }),
		-1
	)
end

for k, v in pairs(translations) do
	SetLanguage("pl", v)
end
