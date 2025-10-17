local middleCoords = vec3(770.9, -234.0, 66.3)
local ballEnt = nil

Thread:Create(function()
  Object:CreateAsync2("p_ld_soc_ball_01", middleCoords, function(obj, objId)
    ballEnt = obj
  end)
end)

User:OnCustomEvent("soccer", function(self, zoneData, posData)
  SetEntityCoords(ballEnt, middleCoords)
  Event:TriggerNet("dwb:soccer:play", self.source, NetworkGetNetworkIdFromEntity(ballEnt))
end)
