Stream = class()

function Stream:RequestWeapon(hash, cb)
    if not HasWeaponAssetLoaded(hash) then
        RequestWeaponAsset(hash)
        while not HasWeaponAssetLoaded(hash) do
            Wait(10)
        end
    end
    if cb then cb() end
    RemoveWeaponAsset(hash)
end

function Stream:RequestPtfx(dict, cb)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(10)
        end
    end
    
    UseParticleFxAssetNextCall(dict) 
    if cb then cb(dict) end
    RemoveNamedPtfxAsset(dict)
end

function Stream:RequestAnimSet(animSet, cb)
	if not HasAnimSetLoaded(animSet) then
		RequestAnimSet(animSet)

		while not HasAnimSetLoaded(animSet) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function Stream:RequestModel(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function Stream:RequestAnimDict(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end
