--- Config
-- template
-- like - but to keep backwards compatibility, say 'not_luadoc=true'
-- @module Config

--- Vector3 Type
-- Represents a 3D vector with x, y, and z components.
-- @type vector3
-- @field x number X component of the vector.
-- @field y number Y component of the vector.
-- @field z number Z component of the vector.

--- Config table
-- @table Config
Config = {}

ConfigMeta = {}

ConfigMeta.__index = ConfigMeta
ConfigMeta.__newindex = function(t, k, v)
  if type(v) == "table" then
    setmetatable(v, ConfigMeta)
  end
  rawset(t, k, v)
end

function ConfigMeta:Merge(t)
  for k, v in pairs(t) do
    table.insert(self, v)
  end
end

noop = function() end

function merge(t, tt)
  for k, v in pairs(tt) do
    table.insert(t, v)
  end
end

--setmetatable(Config, ConfigMeta)
