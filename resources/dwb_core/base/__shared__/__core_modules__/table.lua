Table = class()

function Table:Shuffle(t)
  local t = t or self
  for i = #t, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end

function Table:SetProtected(t)
  local mt = t
  setmetatable(mt, {
    __index = t,
    __newindex = function(t, k, v)
      if not t[k] then
        rawset(t, k, v)
      else
        print("override detected")
      end
    end,
  })
  return mt
end

function Table:GetValues(t, values)
  local result = {}

  for k, v in pairs(values) do
    result[v] = false
  end

  for k, v in pairs(t) do
    for n, b in pairs(values) do
      if string.find(v, b) then
        result[b] = v
      end
    end
  end

  return result
end

function Table:InTable(t, v, key)
  local found = false
  if key then
    for k, v2 in pairs(t) do
      if v2[key] == v then
        return true
      end
    end
  else
    for k, v2 in pairs(t or {}) do
      if v2 == v then
        return true
      end
    end
  end
end
function Table:CopyEx(t)
  local newT = {}
  for k, v in pairs(t) do
    newT[k] = v
  end
  return newT
end
function Table:Copy(t)
  return json.decode(json.encode(t))
  -- local newT = {}
  -- for k,v in pairs(t) do
  --     table.insert(newT, v)
  -- end
  -- return newT
end

function Table:Merge(t, tt)
  local t = tt and t or self
  for k, v in pairs(tt) do
    table.insert(t, v)
  end
end

function Table:MergeKV(t, tt)
  local t = tt and t or self
  for k, v in pairs(tt) do
    t[k] = v
  end
end

table.merge = Table.Merge
table.copy = Table.copy
table.contains = Table.InTable
table.copyEx = Table.CopyEx
table.shuffle = Table.Shuffle
