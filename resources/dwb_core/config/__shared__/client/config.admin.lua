Config.Admin.Categories = {
	{
		requires = "menu.players",
		element = {
			label = "Zarządzanie graczami",
			value = "players",
		},
	},
	{
		requires = "menu.server",
		element = {
			label = "Zarządzanie serwer",
			value = "server",
		},
	},
	{
		requires = "menu.options",
		element = {
			label = "Opcje",
			value = "options",
		},
	},
}

Config.Admin.Actions = {
	["player"] = {
		{
			label = "Spectuj gracza",
			value = "spectate",
			requires = "menu.spectate",
		},
		{
			label = "Teleportuj do gracza",
			value = "teleportto",
			requires = "menu.teleportto",
		},
		{
			label = "Teleportuj gracza do siebie",
			value = "teleporttome",
			requires = "menu.teleporttome",
		},
		{
			label = "Freeze",
			value = "freeze",
			requires = "menu.freeze",
		},
		{
			label = "Sprawdz eq",
			value = "check",
			requires = "menu.check",
		},
		{
			label = "Zdjęcie",
			value = "photo",
			requires = "menu.photo",
		},
	},
	["last_player"] = {
		{
			label = "Zbanuj gracza",
			value = "ban",
		},
	},
}

Config.Admin.Elements = {
	["players"] = { {
		label = "Ostatni gracze",
		value = "last_players",
	} },
	["server"] = {
		{
			label = "Odbanuj gracza przez liste",
			value = "unban_player",
		},
		-- {
		--     label = 'Odbanuj gracza przez hexa',
		--     value = 'unban_player_by'
		-- }
	},
	["options"] = {
		{
			label = "Noclip",
			value = "noclip",
			requires = "menu.noclip",
		},
		{
			label = "Noclip speed",
			valType = "noclip",
			type = "slider",
			min = 0,
			value = 50,
			max = 100,
			requires = "menu.noclip",
		},
		{
			label = "Tpm",
			value = "tpm",
			requires = "menu.tpm",
		},
		{
			label = "Niewidka",
			value = "inv",
			requires = "menu.inv",
		},
	},
}

Config.Admin.Menu = {
	categories = {
		{
			label = "Zarządzanie graczami",
			value = "players_management",
		},
		{
			label = "Zarządzanie Serwerem",
			value = "server_management",
		},
		{
			label = "Opcje",
			value = "options",
		},
	},
	Options = {
		["server_management"] = {
			{
				label = "Odbanuj gracza przez liste",
				value = "unban_player",
			},
			{
				label = "Odbanuj gracza przez hexa",
				value = "unban_player_by",
			},
		},
		["players_management"] = {
			{
				label = "Ostatni gracze",
				value = "last_players",
			},
		},
		["options"] = {
			{
				label = "Noclip",
				value = "noclip",
			},
			{
				label = "Noclip speed",
				valType = "noclip",
				type = "slider",
				min = 0,
				value = 50,
				max = 100,
			},
			{
				label = "Tpm",
				value = "tpm",
			},
			{
				label = "Niewidka",
				value = "inv",
			},
		},
	},
	Actions = {
		{
			label = "Zbanuj gracza",
			value = "ban",
		},
		{
			label = "Wyrzuc gracza",
			value = "kick",
		},
		{
			label = "Spectuj gracza",
			value = "spectate",
		},
		{
			label = "Teleportuj do gracza",
			value = "teleportto",
		},
		{
			label = "Teleportuj gracza do siebie",
			value = "teleporttome",
		},
		{
			label = "Freeze",
			value = "freeze",
		},
		{
			label = "Sprawdz eq",
			value = "check",
		},
	},
	ActionsCached = { {
		label = "Zbanuj gracza",
		value = "ban",
	} },
}
