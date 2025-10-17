Interact.Cursor = {}
function Interact.Cursor:Load(entities)
  self.entities = entities
  for k, v in pairs(entities) do
    for zoneDataIdx, zoneData in pairs(v) do
      zoneData.idx = zoneDataIdx
      for posDataIdx, posData in pairs(zoneData.coords) do
        posData.idx = posDataIdx

        local entityType = (
          (posData.ped or zoneData.ped) and "ped"
          or (posData.vehicle or zoneData.vehicle) and "vehicle"
          or (posData.object or zoneData.object) and "object"
        )

        local zoneEntityData, posEntityData =
          zoneData.ped or zoneData.vehicle or zoneData.object or {},
          posData.ped or posData.vehicle or posData.object or {}

        local model = posEntityData.model or zoneEntityData.model

        local entityHandle

        if entityType == "ped" then
          entityHandle =
            CreatePed(4, model, posData.pos, posData.heading or zoneData.heading or 444, true, true)
        elseif entityType == "vehicle" then
          entityHandle = CreateVehicle(
            model,
            posData.pos,
            posData.heading or zoneData.heading or 444,
            true,
            true
          )
        else
          entityHandle = CreateObjectNoOffset(model, posData.pos, true, true)
        end

        while not DoesEntityExist(entityHandle) do
          Wait(0)
        end

        posData.entityHandle = entityHandle

        posData.netId = NetworkGetNetworkIdFromEntity(entityHandle)

        local dontFreeze = posEntityData.notFreeze or zoneEntityData.notFreeze
        FreezeEntityPosition(entityHandle, not dontFreeze and true)

        if entityType == "ped" then
          SetPedRandomProps(entityHandle)
          SetPedRandomComponentVariation(entityHandle, 4)
          for flagId, flagValue in pairs(Config.Cursor.pedFlags) do
            Wait(0)
            SetPedConfigFlag(entityHandle, flagId, flagValue)
          end
        end

        Entity(entityHandle).state.isOwned = true
        Entity(entityHandle).state.hasAction = true
        Entity(entityHandle).state.posData = posData
        Entity(entityHandle).state.zoneData = zoneData

        Entity(entityHandle).state.action = posData.action or zoneData.action
        SetEntityRoutingBucket(entityHandle, posData.bucket or zoneData.bucket)
      end
    end
  end
end
