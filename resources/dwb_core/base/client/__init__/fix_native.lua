


local function GetIntFromBlob(b, s, o)
	r = 0
	for i=1,s,1 do
		r = r | (string.byte(b,o+i)<<(i-1)*8)
	end
	return r
end

local function GetStringFromBlob(b, s, o)
	r = ''
	for i=1,s,1 do
		if string.byte(b,o+i) ~= 0 then
			r = r .. string.char(string.byte(b,o+i))
		else
			break
		end
	end
	return r
end

function GetDlcVehicleData(dlcVehicleIndex, none)
	local blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
	local retval = Citizen.InvokeNative(0x33468EDC08E371F6, dlcVehicleIndex, blob, Citizen.ReturnResultAnyway())
	local val1 = GetIntFromBlob(blob,8,0)
	local hash = GetIntFromBlob(blob,8,8)
	local val3 = GetIntFromBlob(blob,8,16)
	return retval, val1, hash, val3
end

function GetDlcWeaponData(dlcWeaponIndex, none)
	local blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
	local retval = Citizen.InvokeNative(0x79923CD21BECE14E, dlcWeaponIndex, blob, Citizen.ReturnResultAnyway())
	local emptyCheck = GetIntFromBlob(blob,8,0)
	local weaponHash = GetIntFromBlob(blob,8,8)
	local val3 = GetIntFromBlob(blob,8,16)
	local weaponCost = GetIntFromBlob(blob,8,24)
	local ammoCost = GetIntFromBlob(blob,8,32)
	local ammoType = GetIntFromBlob(blob,8,40)
	local clipSize = GetIntFromBlob(blob,8,48)
	local nameLabel = GetStringFromBlob(blob,64,56)
	local descLabel = GetStringFromBlob(blob,64,120)
	local desc2Label = GetStringFromBlob(blob,64,184)
	local upperCaseNameLabel = GetStringFromBlob(blob,64,248)
	return retval, emptyCheck, weaponHash, val3, weaponCost, ammoCost, ammoType, clipSize, nameLabel, descLabel, desc2Label, upperCaseNameLabel
end

function GetDlcWeaponComponentData(dlcWeaponIndex, dlcWeapCompIndex, none)
	local blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
	local retval = Citizen.InvokeNative(0x6CF598A2957C2BF8, dlcWeaponIndex, dlcWeapCompIndex, blob, Citizen.ReturnResultAnyway())
	local attachBone = GetIntFromBlob(blob,8,0)
	local bActiveByDefault = GetIntFromBlob(blob,8,8)
	local val3 = GetIntFromBlob(blob,8,16)
	local componentHash = GetIntFromBlob(blob,8,24)
	local val5 = GetIntFromBlob(blob,8,32)
	local componentCost = GetIntFromBlob(blob,8,40)
	local nameLabel = GetStringFromBlob(blob,64,48)
	local descLabel = GetStringFromBlob(blob,64,112)
	return retval, attachBone, bActiveByDefault, val3, componentHash, val5, componentCost, nameLabel, descLabel
end

function GetWeaponHudStats(weaponHash, none)
	local blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
	local retval = Citizen.InvokeNative(0xD92C739EE34C9EBA, weaponHash, blob, Citizen.ReturnResultAnyway())
	local hudDamage = GetIntFromBlob(blob,8,0)
	local hudSpeed = GetIntFromBlob(blob,8,8)
	local hudCapacity = GetIntFromBlob(blob,8,16)
	local hudAccuracy = GetIntFromBlob(blob,8,24)
	local hudRange = GetIntFromBlob(blob,8,32)
	return retval, hudDamage, hudSpeed, hudCapacity, hudAccuracy, hudRange
end

function GetWeaponComponentHudStats(componentHash, none)
	local blob = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
	local retval = Citizen.InvokeNative(0xB3CAF387AE12E9F8, componentHash, blob, Citizen.ReturnResultAnyway())
	local hudDamage = GetIntFromBlob(blob,8,0)
	local hudSpeed = GetIntFromBlob(blob,8,8)
	local hudCapacity = GetIntFromBlob(blob,8,16)
	local hudAccuracy = GetIntFromBlob(blob,8,24)
	local hudRange = GetIntFromBlob(blob,8,32)
	return retval, hudDamage, hudSpeed, hudCapacity, hudAccuracy, hudRange
end