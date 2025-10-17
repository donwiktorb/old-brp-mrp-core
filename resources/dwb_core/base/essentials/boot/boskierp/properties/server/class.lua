Property = class(false, false, false, User)

function Property:Load(single)
  self.properties =
    Mysql.Sync:fetchAll('SELECT * FROM owned_properties WHERE owner = ? AND type = "property"', {
      self.charId,
    })

  for k, v in pairs(self.properties) do
    if single[v.name] then
      v.single = true
    end
    v.items = json.decode(v.items) or {}
    local items = v.items
    for k, v in pairs(v.items) do
      if not v.slot then
        v.slot = math.random(1, 50)
      end

      if not v.count or v.count <= 0 then
        v.count = 1
      end

      if v.ammo then
        v.data = {
          ammo = v.ammo,
        }
      end

      items[k] = Item:GetInventoryFormat(v)
    end
    v.clothes = json.decode(v.clothes)
    v.owners = json.decode(v.owners)
  end

  Event:TriggerNet("dwb:property:loaded", self.source, self.properties)
end

function Property:Refresh()
  Event:TriggerNet("dwb:property:loaded", self.source, self.properties)
end

function Property:GetAllSingle()
  local props = {}
  for k, v in pairs(self.properties) do
    if v.single then
      table.insert(props, v)
    end
  end
  return props
end

function Property:Add(name, single)
  table.insert(self.properties, {
    id = 0,
    owner = self.charId,
    owners = {},
    name = name,
    type = "property",
    items = {},
    single = single,
    clothes = {},
  })
end

function Property:Remove(name)
  for k, v in pairs(self.properties) do
    if v.name == name then
      table.remove(self.properties, k)
      Mysql.Async:Execute("DELETE FROM owned_properties WHERE owner = ? AND name = ?", {
        self.charId,
        name,
      })
    end
  end
end

function Property:Save(cb)
  if #self.properties > 0 then
    local saveProps = {}

    for k, v in pairs(self.properties) do
      for key, value in pairs(v.items) do
        v.items[key] = Item:GetDatabaseFormat(value)
      end

      v.items = json.encode(v.items)
      v.clothes = json.encode(v.clothes)
      v.owners = json.encode(v.owners)

      table.insert(saveProps, {
        v.id or 0,
        v.owner,
        v.owners,
        v.name,
        v.type,
        v.items,
        v.clothes,
      })
    end

    Mysql.Async:Execute(
      "REPLACE INTO owned_properties (id,owner,owners,name,type,items,clothes) VALUES ?",
      {
        { table.unpack(saveProps) },
      },
      function(rowsChanged)
        --Log:Info("Saved props for ", self.source)
        cb()
      end
    )
  else
    cb()
  end
end

function Property:Unload()
  self:Save(function()
    self.properties = nil
  end)
end

function Property:Get(value, key)
  for k, v in pairs(self.properties) do
    if v[key] == value then
      return v, k
    end
  end
end

function Property:Enter(name, source, data)
  local prop = self:Get(name, "name")
  if not prop.players then
    prop.players = {}
  end
  if not prop.currentData then
    prop.currentData = data
  end
  self.inProperty = true
  table.insert(prop.players, source or self.source)
end

function Property:Exit(name) end

function Property:IsIn(value, key) end
