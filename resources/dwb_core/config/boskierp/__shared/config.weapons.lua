Config.Weapons = {
	{name = 'WEAPON_KNIFE', label = TR('weapon_knife'), components = {}},
	{name = 'WEAPON_NIGHTSTICK', label = TR('weapon_nightstick'), components = {}},
	{name = 'WEAPON_HAMMER', label = TR('weapon_hammer'), components = {}},
	{name = 'WEAPON_BAT', label = TR('weapon_bat'), components = {}},
	{name = 'WEAPON_GOLFCLUB', label = TR('weapon_golfclub'), components = {}},
	{name = 'WEAPON_CROWBAR', label = TR('weapon_crowbar'), components = {}},
	{name = 'WEAPON_FLASHBANG', label = TR('weapon_flashbang'), components = {}},

	{
		name = 'WEAPON_PISTOL',
		label = TR('weapon_pistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = TR('weapon_combatpistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = TR('weapon_appistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = TR('weapon_pistol50'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')}
		}
	},

	{name = 'WEAPON_REVOLVER', label = TR('weapon_revolver'), components = {}},

	{
		name = 'WEAPON_SNSPISTOL',
		label = TR('weapon_snspistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = TR('weapon_heavypistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = TR('weapon_vintagepistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = TR('weapon_microsmg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SMG',
		label = TR('weapon_smg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = TR('weapon_assaultsmg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = TR('weapon_minismg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02')}
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = TR('weapon_machinepistol'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = TR('weapon_combatpdw'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')}
		}
	},
	
	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = TR('weapon_pumpshotgun'),
		components = {
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = TR('weapon_sawnoffshotgun'),
		components = {
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = TR('weapon_assaultshotgun'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = TR('weapon_bullpupshotgun'),
		components = {
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = TR('weapon_heavyshotgun'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = TR('weapon_assaultrifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = TR('weapon_carbinerifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')},
			{name = 'clip_box', label = TR('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = TR('weapon_advancedrifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = TR('weapon_specialcarbine'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = TR('weapon_bullpuprifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW')}
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = TR('weapon_compactrifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = TR('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')}
		}
	},

	{
		name = 'WEAPON_MG',
		label = TR('weapon_mg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_MG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_MG_CLIP_02')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = TR('weapon_combatmg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = TR('weapon_gusenberg'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02')},
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = TR('weapon_sniperrifle'),
		components = {
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = TR('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = TR('weapon_heavysniper'),
		components = {
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = TR('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')}
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = TR('weapon_marksmanrifle'),
		components = {
			{name = 'clip_default', label = TR('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01')},
			{name = 'clip_extended', label = TR('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')},
			{name = 'flashlight', label = TR('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = TR('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM')},
			{name = 'suppressor', label = TR('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = TR('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = TR('component_luxary_finish'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE')}
		}
	},
	{
		name = 'WEAPON_GLOCK17',
		label = TR('WEAPON_GLOCK17'),
		components = {
			{name = 'w_pi_glock17_mag1', label = TR('w_pi_glock17_mag1'), hash = GetHashKey('w_pi_glock17_mag1')},
		}
	},
	{
		name = 'WEAPON_GLOCK19',
		label = TR('WEAPON_GLOCK19'),
		components = {
			{name = 'w_pi_glock19_flsh', label = TR('w_pi_glock19_flsh'), hash = GetHashKey('w_pi_glock19_flsh')},
			{name = 'w_pi_glock19_mag1', label = TR('w_pi_glock19_mag1'), hash = GetHashKey('w_pi_glock19_mag1')},
			{name = 'w_pi_glock19_mag2', label = TR('w_pi_glock19_mag2'), hash = GetHashKey('w_pi_glock19_mag2')},
		}
	},
	{
		name = 'WEAPON_M4A1FM',
		label = TR('WEAPON_M4A1FM'),
		components = {
			{name = 'COMPONENT_M4A1FM_BARREL', label = TR('COMPONENT_M4A1FM_BARREL'), hash = GetHashKey('COMPONENT_M4A1FM_BARREL')},
			{name = 'COMPONENT_M4A1FM_CLIP', label = TR('COMPONENT_M4A1FM_CLIP'), hash = GetHashKey('COMPONENT_M4A1FM_CLIP')},
			{name = 'COMPONENT_M4A1FM_FLSH', label = TR('COMPONENT_M4A1FM_FLSH'), hash = GetHashKey('COMPONENT_M4A1FM_FLSH')},
			{name = 'COMPONENT_M4A1FM_SCOPE', label = TR('COMPONENT_M4A1FM_SCOPE'), hash = GetHashKey('COMPONENT_M4A1FM_SCOPE')},
		}
	},
	{
		name = 'WEAPON_M19',
		label = TR('WEAPON_M19'),
		components = {
			{name = 'w_pi_m19_mag2', label = TR('w_pi_m19_mag2'), hash = GetHashKey('w_pi_m19_mag2')},
			{name = 'w_pi_m19_mag1', label = TR('w_pi_m19_mag1'), hash = GetHashKey('w_pi_m19_mag1')},
		}
	},
	{
		name = 'WEAPON_R870',
		label = TR('WEAPON_R870'),
		components = {
		}
	},
	{
		name = 'WEAPON_VIS100',
		label = TR('WEAPON_VIS100'),
		components = {
			{name = 'w_pi_vis100_mag1', label = TR('w_pi_vis100_mag1'), hash = GetHashKey('w_pi_vis100_mag1')},
		}
	},

	{name = 'WEAPON_GRENADELAUNCHER', label = TR('weapon_grenadelauncher'), components = {}},
	{name = 'weapon_pistol_mk2', label = 'Pistol Mk2', components = {}},
	{name = 'WEAPON_RPG', label = TR('weapon_rpg'), components = {}},
	{name = 'WEAPON_STINGER', label = TR('weapon_stinger'), components = {}},
	{name = 'WEAPON_MINIGUN', label = TR('weapon_minigun'), components = {}},
	{name = 'WEAPON_GRENADE', label = TR('weapon_grenade'), components = {}},
	{name = 'WEAPON_STICKYBOMB', label = TR('weapon_stickybomb'), components = {}},
	{name = 'WEAPON_SMOKEGRENADE', label = TR('weapon_smokegrenade'), components = {}},
	{name = 'WEAPON_BZGAS', label = TR('weapon_bzgas'), components = {}},
	{name = 'WEAPON_MOLOTOV', label = TR('weapon_molotov'), components = {}},
	{name = 'WEAPON_FIREEXTINGUISHER', label = TR('weapon_fireextinguisher'), components = {}},
	{name = 'WEAPON_PETROLCAN', label = TR('weapon_petrolcan'), components = {}},
	{name = 'WEAPON_DIGISCANNER', label = TR('weapon_digiscanner'), components = {}},
	{name = 'WEAPON_BALL', label = TR('weapon_ball'), components = {}},
	{name = 'WEAPON_BOTTLE', label = TR('weapon_bottle'), components = {}},
	{name = 'WEAPON_DAGGER', label = TR('weapon_dagger'), components = {}},
	{name = 'WEAPON_FIREWORK', label = TR('weapon_firework'), components = {}},
	{name = 'WEAPON_MUSKET', label = TR('weapon_musket'), components = {}},
	{name = 'WEAPON_STUNGUN', label = TR('weapon_stungun'), components = {}},
	{name = 'WEAPON_HOMINGLAUNCHER', label = TR('weapon_hominglauncher'), components = {}},
	{name = 'WEAPON_PROXMINE', label = TR('weapon_proxmine'), components = {}},
	{name = 'WEAPON_SNOWBALL', label = TR('weapon_snowball'), components = {}},
	{name = 'WEAPON_FLAREGUN', label = TR('weapon_flaregun'), components = {}},
	{name = 'WEAPON_GARBAGEBAG', label = TR('weapon_garbagebag'), components = {}},
	{name = 'WEAPON_HANDCUFFS', label = TR('weapon_handcuffs'), components = {}},
	{name = 'WEAPON_MARKSMANPISTOL', label = TR('weapon_marksmanpistol'), components = {}},
	{name = 'WEAPON_KNUCKLE', label = TR('weapon_knuckle'), components = {}},
	{name = 'WEAPON_HATCHET', label = TR('weapon_hatchet'), components = {}},
	{name = 'WEAPON_RAILGUN', label = TR('weapon_railgun'), components = {}},
	{name = 'WEAPON_MACHETE', label = TR('weapon_machete'), components = {}},
	{name = 'WEAPON_SWITCHBLADE', label = TR('weapon_switchblade'), components = {}},
	{name = 'WEAPON_DBSHOTGUN', label = TR('weapon_dbshotgun'), components = {}},
	{name = 'WEAPON_AUTOSHOTGUN', label = TR('weapon_autoshotgun'), components = {}},
	{name = 'WEAPON_BATTLEAXE', label = TR('weapon_battleaxe'), components = {}},
	{name = 'WEAPON_COMPACTLAUNCHER', label = TR('weapon_compactlauncher'), components = {}},
	{name = 'WEAPON_PIPEBOMB', label = TR('weapon_pipebomb'), components = {}},
	{name = 'WEAPON_POOLCUE', label = TR('weapon_poolcue'), components = {}},
	{name = 'WEAPON_WRENCH', label = TR('weapon_wrench'), components = {}},
	{name = 'WEAPON_FLASHLIGHT', label = TR('weapon_flashlight'), components = {}},
	{name = 'GADGET_NIGHTVISION', label = TR('gadget_nightvision'), components = {}},
	{name = 'GADGET_PARACHUTE', label = TR('gadget_parachute'), components = {}},
	{name = 'WEAPON_FLARE', label = TR('weapon_flare'), components = {}},
	{name = 'WEAPON_DOUBLEACTION', label = TR('weapon_doubleaction'), components = {}}
}