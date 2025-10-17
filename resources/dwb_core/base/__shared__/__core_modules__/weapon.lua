Weapon = class()

function Weapon:GetList()
	return Config.Weapons
end

function Weapon:Get(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = Weapon:GetList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return i, weapons[i]
		end
	end
end

function Weapon:GetHash(weaponHash)
	local weapons = Weapon:GetList()

	for i=1, #weapons, 1 do
		if GetHashKey(weapons[i].name) == weaponHash then
			return i, weapons[i]
		end
	end
end

function Weapon:GetLabel(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = Weapon:GetList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return weapons[i].label
		end
	end
end

function Weapon:GetWeaponComponent(weaponName, weaponComponent)
	if not tonumber(weaponName) then
		weaponName = string.upper(weaponName)
		local weapons = Weapon:GetList()

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				for j=1, #weapons[i].components, 1 do
					if weapons[i].components[j].name == weaponComponent then
						return weapons[i].name, weapons[i].components[j]
					end
				end
			end
		end
	else
		local weapons = Weapon:GetList()

		for i=1, #weapons, 1 do
			if GetHashKey(weapons[i].name) == weaponName then
				for j=1, #weapons[i].components, 1 do
					if weapons[i].components[j].name == weaponComponent then
						return weapons[i], weapons[i].components[j]
					end
				end
			end
		end
	end
end

function Weapon:GetComponent(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = Weapon:GetList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j]
				end
			end
		end
	end
end
