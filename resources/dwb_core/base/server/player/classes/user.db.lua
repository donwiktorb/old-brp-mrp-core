-- Async better, errory etc

function User:Load(identifier, cb)
  Database.Async:fetch("SELECT id, data FROM users WHERE identifier = ?", {
    identifier or self.identifier,
  }, function(userData)
    if userData then
      self.newUser = true
    end

    local id = userData and userData.id or 0

    local data = userData and json.decode(userData.data) or {
      chars = {},
    }

    self.data = data
    self.id = id

    if cb then
      cb()
    end
  end)
end

function User:LoadCharFromData(id, charData, cb)
  local newJobs = {}

  for k, v in pairs(charData.jobs or {}) do
    local jobObj, gradeObj = Job:GetJobFromNameGrade(v.job, tonumber(v.grade), v.data)
    gradeObj.data = v.data
    newJobs[v.job] = gradeObj
  end

  charData.jobs = newJobs

  charData.inventory = charData.inventory or {}

  for k, v in pairs(charData.inventory or {}) do
    charData.inventory[k] = Item:GetInventoryFormat(v)
  end

  charData.position = charData.position
      and vec3(charData.position.x or 0, charData.position.y or 0, charData.position.z or 0)
    or vec3(Config.Default.Spawn.coords)

  self.char = charData
  self.charId = id
  charData.id = id

  self:LoadedChar(cb)

  -- if cb then
  --     cb()
  -- end
end

function User:LoadChar(id, cb)
  Database.Async:fetch(
    "SELECT data, skin, jobs, inventory, position FROM characters WHERE id = ?",
    {
      id or self.charId,
    },
    function(charData)
      if not charData then
        charData = {}
      end

      for k, v in pairs(charData) do
        charData[k] = json.decode(v)
      end

      local newJobs = {}

      for k, v in pairs(charData.jobs) do
        if v.job then
          local jobObj, gradeObj = Job:GetJobFromNameGrade(v.job, tonumber(v.grade))
          gradeObj.data = v.data
          newJobs[v.job] = gradeObj
        end
      end

      charData.jobs = newJobs

      charData.inventory = charData.inventory or {}

      for k, v in pairs(charData.inventory) do
        charData.inventory[k] = Item:GetInventoryFormat(v)
      end

      charData.position = charData.position
          and vec3(charData.position.x or 0, charData.position.y or 0, charData.position.z or 0)
        or vec3(Config.Default.Spawn.Coords)

      self.char = charData
      self.charId = id

      charData.id = id

      self:LoadedChar(cb)

      -- if cb then
      --     cb()
      -- end
    end
  )
end

function User:Save(identifier, cb)
  if self.id == nil then
    if cb then
      cb()
      return
    end
  end
  Database.Async:Insert(
    "INSERT INTO users (id, name, identifier, identifiers, data) VALUES (?) ON DUPLICATE KEY UPDATE name = VALUES(name), identifiers = VALUES(identifiers), data = VALUES(data)",
    {
      {

        self.id,
        self.name,
        identifier or self.identifier,
        json.encode(self.identifiers),
        json.encode(self.data),
      },
    },
    function(insertId)
      if cb then
        cb(insertId)
      end
    end
  )
end

function User:AddToChars(charId, data)
  print(json.encode(data))
  local found = Table:InTable(self.data.chars, charId, "id")
  if not found then
    table.insert(self.data.chars, {
      id = charId,
      firstname = data.firstname,
      lastname = data.lastname,
      type = data.type,
    })
  end
end

function User:CreateChar(charData, cb)
  if not charData.inventory then
    charData.inventory = Table:Copy(Config.Default.PlayerData.inventory)
  end
  Database.Async:Insert(
    "INSERT INTO characters (id, data, skin, jobs, inventory, position) VALUES (?) ON DUPLICATE KEY UPDATE data = VALUES(data), skin = VALUES(skin), jobs = VALUES(jobs), inventory = VALUES(inventory), position = VALUES(position)",
    {
      {
        charData.charId or 0,
        json.encode(charData.data or {}),
        json.encode(charData.skin or {}),
        json.encode(charData.jobs or {}),
        json.encode(charData.inventory or {}),
        json.encode(charData.position or {}),
      },
    },
    function(insertId)
      self:AddToChars(insertId, charData.data)
      if cb then
        cb(insertId)
      end
    end
  )
end

function User:SaveChar(charId, cb)
  if self.charId == nil then
    if cb then
      cb()
    end
    return
  end
  Database.Async:Insert(
    "INSERT INTO characters (id, data, skin, jobs, inventory, position) VALUES (?) ON DUPLICATE KEY UPDATE data = VALUES(data), skin = VALUES(skin), jobs = VALUES(jobs), inventory = VALUES(inventory), position = VALUES(position)",
    {
      {
        charId or self.charId,
        json.encode(self.char.data),
        json.encode(self.char.skin or {}),
        json.encode(Job:GetDatabaseFormat(self.char.jobs or {})),
        json.encode(Item:GetInventoryDatabaseFormat(self.char.inventory or {})),
        json.encode(self.char.position or {}),
      },
    },
    function(insertId)
      if cb then
        cb(insertId)
      end
    end
  )
end

function User:SaveAll(cb)
  self:SaveChar(nil, function(charId)
    if charId then
      self:AddToChars((charId and charId > 0) and charId or self.charId, self.char.data)
    end
    self:Save(nil, cb)
  end)
end

function User:UnloadChar(cb)
  self:SaveChar(nil, function(charId)
    if charId then
      self:AddToChars((charId and charId > 0) and charId or self.charId, self.char.data)
    end
    self:UnloadedChar(function()
      self.char = nil
      self.charId = nil
      if cb then
        cb(charId)
      end
    end)
  end)
end

function User:Unload(cb)
  self:Save(false, function()
    self:UnloadChar(function()
      self:Unloaded(cb)
    end)
  end)
end
