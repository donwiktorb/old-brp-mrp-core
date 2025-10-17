--- Class Module
---Provides class function.
---@module class

--- Class function.
---@param base? table
---@param methods? table
---@param init? function | table
---@param shared? table
---@return table
function class(base, methods, init, shared)
  local class = {}
  class.__index = class

  local index
  if base and type(base) == "table" then
    index = base
    class = base
  elseif base then
    init = base
  end

  if methods then
    for k, v in pairs(methods) do
      class[k] = v
    end
  end

  if init then
    class.__init = init
  end

  function class:extends(methods, init)
    return class(nil, methods, init)
  end

  setmetatable(class, {
    __index = index or shared,
    __call = function(c, ...)
      local instance = setmetatable({}, c)
      if c.__init then
        c.__init(instance, ...)
      end
      return instance
    end,
  })
  return class
end
