--[[ 
    TODO:
        - marekr na jeden pos
]]
Marker = class()

function Marker:Remove(name)
  if DWB.Zones[name] then
    DWB.Zones[name].remove = true
  end
end

function Marker:ModifyData(name, data)
  for k, v in pairs(data) do
    DWB.Zones[name].data[k] = v
  end
end

function Marker:Deactive(name, data)
  if DWB.Zones[name] then
    DWB.Zones[name].deactive = true
  end
end

function Marker:Active(name, data)
  if DWB.Zones[name] then
    DWB.Zones[name].deactive = false
  end
end

-- function Marker:EditCoordsData(key, key2, value2, dataKey, dataValue)
--     for k,v in pairs(DWB.Zones[key]) do
--         for k2,v2 in pairs(v.coords) do
--             if v2.data and v2.data[key2] == value2 then
--                 v2.data[dataKey] = dataValue
--             end
--         end
--     end
-- end

function Marker:RemoveNonExistantObjects(name)
  for k, v in pairs(DWB.Zones[name].coords) do
    if v.obj and not DoesEntityExist(v.obj) then
      DWB.Zones[name].coords[k].remove = true
      -- table.remove(DWB.Zones[name].coords, k)
    end
  end
end

function Marker:GetCoordsByKey(name, data)
  local result = nil
  for k, v in pairs(DWB.Zones[name].coords) do
    if v[data.key] == data.value then
      result = v
    end
  end
  return result
end

function Marker:RemoveCoordsByKey(name, data)
  for k, v in pairs(DWB.Zones[name].coords) do
    if v[data.key] == data.value then
      DWB.Zones[name].coords[k].remove = true
      -- table.remove(DWB.Zones[name].coords, k)
    end
  end
end

function Marker:Add(name, data)
  --[[
           data-structure:
            marker: {
                type: int,
                direction: vector3,
                rotation: vector3,
                scale: vector3,
                color: {
                    r,g,b,a: int,int,int,int,int,
                },    
                animate: boolean,
                faceCam: boolean
            },
            messages: {
                onEnter: string,
                onClose: string,
                onExit: string
            },
            data: {

            },
            settings: {
                drawDist: int,
                drawMarker: boolean,
            }, 
            functions: {
                onDrawDistEnter: function(zone)
                onDrawDistExit: function(zone)
                onCloseDist: function(zone),
                onExitCb: function(zone),
                onEnterCb: function(zone),
                onClickCb: function(zone)
            }, 
            coords: {
                {
                    drawDist: int,
                    key: string || int,
                    pos: vector3,
                    marker: {},
                    functions: {
                        onCloseDist: function,
                        onExitCb: function,
                        onEnterCb: function,
                        onClickCb: function
                    } 
                }
            }

        ]]

  data.name = name
  data.remove = false

  local result = DWB.Zones[name]

  if result then
    result.remove = false
    if result.settings.overrideCoords then
      if Config.Debug.Log.Binding then
        Log:Info("overriding zone coords" .. name)
      end
      for k, v in pairs(data.coords) do
        Wait(0)
        table.insert(DWB.Zones[name].coords, v)
      end
      return
    end
  end

  for k, v in pairs(Config.Default.Zone) do
    Wait(0)
    if data[k] == nil then
      data[k] = v
      if Config.Debug.Log.Binding then
        Log:Info("zone manager writing " .. k .. " " .. json.encode(v) .. " " .. name)
      end
    else
      if type(data[k]) == "table" then
        for n, m in pairs(v) do
          if data[k][n] == nil then
            if k == "marker" and n == "scale" then
              if type(data.settings.radius) == "table" then
                local newscale = vec3(
                  m.x * data.settings.radius.x,
                  m.y * data.settings.radius.y,
                  m.z * data.settings.radius.z
                )
                data[k][n] = newscale
              else
                local newscale = m * data.settings.radius
                data[k][n] = newscale
              end
            else
              data[k][n] = m
            end
          end
        end
      end
    end
  end

  --if data.settings and data.settings.createBlips then
  --  if not data.settings.dynamicBlips then
  --    local blips, blip = Blips:Add(name, data)
  --    if data.settings.autoRoute then
  --      SetBlipRoute(blip, 1)
  --    end
  --  else
  --    local blips, blip = Blips:AddDynamic(name, data)
  --    if data.settings.autoRoute then
  --      SetBlipRoute(blip, 1)
  --    end
  --  end
  --end

  for k, v in pairs(data.coords) do
    Wait(0)
    v.uid = data.name .. "-" .. k
    if v.coords and not v.pos then
      v.pos = v.coords
    end
    if v.marker then
      for k2, v2 in pairs(Config.Default.Zone.marker) do
        if not v.marker[k2] then
          v.marker[k2] = v2
        end
      end
    end
  end
  DWB.Zones[name] = data
end

function Marker:Get(name)
  return DWB.Zones[name]
end
