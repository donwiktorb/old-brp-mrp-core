


local objects = {
  {
    label = "Podstawa",
    model = "true_fundament",
    offsets = {},
  },
}
Key:onJustPressed("G", "G", function()
  local obj = CreateObject(`true_fundament`, DWB.PlayerData.Coords)
  while not DoesEntityExist(obj) do
    Wait(0)
  end
  --SetEntityCollision(obj, false, true)
  while true do
    Wait(0)
    local ret, rayCat, endCoords, sNormal, entHit, target = Object:RayCastMid()
    SetEntityCoords(obj, target)
    local camRot = GetGameplayCamRot(2)
    ----PlaceObjectOnGroundProperly(obj)
    local pitch = math.rad(camRot.x)
    local roll = camRot.y
    local yaw = math.rad(-camRot.z)
    local targetObj = GetClosestObjectOfType(target + 4, 10.0, `true_fundament`, false, true, true)
    if targetObj ~= obj and not IsEntityAttached(obj) and DoesEntityExist(targetObj) then
      ----SetEntityCoords(obj, GetWorldPositionOfEntityBone(targetObj, 3))
      local closestBonId = 0
      local closestBonIdTarget = 0
      local distance = 99999
      for i = 3, GetEntityBoneCount(obj) - 1 do
        local ret = GetEntityBonePosition_2(targetObj, i)
        for n = 3, GetEntityBoneCount(targetObj) - 1 do
          local ret4 = GetEntityBonePosition_2(obj, n)
          local dist = #(ret - ret4)
          if dist <= distance then
            distance = dist
            closestBonId = n
            closestBonIdTarget = i
          end
        end
      end
      SetEntityCollision(obj, true, true)
      return AttachEntityBoneToEntityBonePhysically(
        obj,
        targetObj,
        closestBonId,
        closestBonIdTarget,
        true,
        true
      )
    end
  end
end)
